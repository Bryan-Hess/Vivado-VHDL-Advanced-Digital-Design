/*------------------------------------------------------------------------------
--                                                                            --
--       .oooooo..o ooooo   ooooo ooooooooo.   oooooooooooo   .oooooo.        --
--      d8P'    `Y8 `888'   `888' `888   `Y88. `888'     `8  d8P'  `Y8b       --
--      Y88bo.       888     888   888   .d88'  888         888               --
--       `"Y8888o.   888ooooo888   888ooo88P'   888oooo8    888               --
--           `"Y88b  888     888   888`88b.     888    "    888               --
--      oo     .d8P  888     888   888  `88b.   888       o `88b    ooo       --
--      8""88888P'  o888o   o888o o888o  o888o o888ooooood8  `Y8bood8P'       --
--                                                                            --
--------------------------------------------------------------------------------
-- Vivado HLS 2D Convolutional Accelerator          author: Sebastian Sabogal --
--------------------------------------------------------------------------------
--                                                                            --
-- Copyright (C) 2020 SHREC.                                                  --
--                                                                            --
-- This file is part of HLS-2D-CONV.                                          --
--                                                                            --
-- HLS-2D-CONV is free software; you can redistribute it and/or modify        --
-- it under the terms of the GNU General Public License as published by the   --
-- Free Software Foundation; either version 3, or (at your option) any later  --
-- version.                                                                   --
-- HLS-2D-CONV is distributed in the hope that it will be useful, but         --
-- WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   --
-- for more details.                                                          --
-- You should have received a copy of the GNU General Public License along    --
-- with HLS-2D-CONV; see the file LICENSE.  If not see                        --
-- <http://www.gnu.org/licenses/>.                                            --
--                                                                            --
------------------------------------------------------------------------------*/

#include "convolution.hpp"

// kernel to be used for convolution
int8_t kern[K * K] = {
	1, 1, 1,
	1, -8, 1,
	1, 1, 1
};
uint8_t shift_div = 0;


// software convolution function
void sw_conv(uint8_t *A, uint8_t *B)
{
	// A is the input picture and B is the output picture.
	// Note, these two arrays are 1D arrays, arranged row after row.

	// double for loop to go over the all the pixels of the picture
	for (int i = 0; i < IMG_HEIGHT-2; ++i) {
		for (int j = 0; j < IMG_WIDTH-2; ++j) {

			int32_t result = 0; // variable to store the convolution result

			// nested for loop to calcualte the convolution and store it in result
			for (int y = 0; y < K; ++y) {
				for (int x = 0; x < K; ++x) {
					result += A[(i+y)*IMG_WIDTH + (j+x)] * kern[y*K+x];
				}
			}
			result >>= shift_div; // shifting right by 4, equivalent to dividing by 16 to normalize the pixel back to the operating range.

			// saturation
			if (result > 0xFF) {
				B[i*IMG_WIDTH + j] = 0xFF;
			} else if (result < 0) {
				B[i*IMG_WIDTH + j] = 0;
			} else {
				B[i*IMG_WIDTH + j] = result;
			}
		}
	}
}

void hw_conv(stream_t &sin, stream_t &sout)
{

	// directives to assign ports
#	pragma HLS INTERFACE ap_ctrl_none port=return
#	pragma HLS INTERFACE axis port=sin
#	pragma HLS INTERFACE axis port=sout

	uint8_t kbuf[K][K];					// the buffer used pixels to be multiplied by the kernel
	uint8_t lbuf[K-1][IMG_WIDTH - K];	// the line buffer used for pixels in between the pixels multiplied by the kernel. (see lecture slides)

	// directives to partition these arrays
#	pragma HLS ARRAY_PARTITION variable=kbuf complete dim=0
#	pragma HLS ARRAY_PARTITION variable=lbuf complete dim=1

	int32_t result;		// variable to store the conv result

	// a pipelined loop to go through all stream length + a delay (till the one convoluted pixel is correct.)
	for (int i = 0; i < STREAM_LENGTH+DELAY; ++i) {

		// pipeline directive
#		pragma HLS PIPELINE II=1

		/* Sliding Window */
		{
			// TODO

			// write code to shift pixels through one set (0 .. K-2) of kernel/line buffers
			// Hints:
			//	1. make sure to unroll all the loops written in this part to speed things up. use the command "# pragma HLS UNROLL"
			//	2. kbuf and ibuf can be index as a normal 2D array.

			for (int one = 0; one < K - 1; ++one) {
#				pragma HLS UNROLL
				for (int two=0; two<K; ++two) {
#					pragma HLS UNROLL

					if (two == K-1){
						kbuf[one][two] = lbuf[one][0]; //lbuf -> kbuf
					}else{
						kbuf[one][two] = kbuf[one][two+1]; //kbuf -> kbuf
					}

				}

				for (int two=0; two<IMG_WIDTH-K; ++two) {
#					pragma HLS UNROLL
					if (two == IMG_WIDTH-K-1) {
						lbuf[one][two] = kbuf[one+1][0]; //kbuf -> 1buf
					} else {
						lbuf[one][two] = lbuf[one][two+1]; //lbuf -> lbuf
					}
				}

			}

			// write code to shift pixels through last (K-1) kernel buffer
			// Hints:
			//	1. make sure to unroll all the loops written in this part to speed things up. use the command "# pragma HLS UNROLL"

			int one = K - 1;
			for (int two = 0; two<K-1; ++two) {
#				pragma HLS UNROLL
				kbuf[one][two] = kbuf[one][two+1];
			}

			// write code to insert pixel into last pixel of K-1 kernel buffer
			// Hints:
			//	1. make sure that you only read in a new beat_t from the input stream as long as i < STREAM_LENGTH
			//	2. define a beat_t variable.
			//	3. use sin >> (your defined variable) to read in a beat from the input stream
			//	4. assign the value of .data(7,0) member function of your beat_t variable to the last pixel of K-1 kernel buffer

			beat_t temp;
			if (i<STREAM_LENGTH){
				sin >> temp;
				kbuf[K-1][K-1] = temp.data(7, 0);
			}

		}

        /* Convolution */
        {
            // TODO

            // write code to implement the convolution operation.
            // Hints:
            //	1. reset the variable result before each conv operation.
            //	2. write loops to do the multiplication and accumulation in the result variable. use the command "# pragma HLS UNROLL"
            //	3. in those loops, figure out the correct indexing method to kernel kern (remember that kern is a 1D image)
            //	4. when you are done calculating the result, shift it to the right by the value shift_div defined above.
            //	5. make sure to check for saturation in the result variable as follows:
            //		if the result > 0xFF then it should be clamped to 0xFF
            //		if less than 0, then it should be clamped to 0
            //		otherwise, it should be the same value.

            // generate a beat_t object with the convoluted pixel and sending it the output stream
            // this is only done after a delay to ensure that we have calculated the correct pixel at the beginning


			result = 0;
			int index = 0;
			for (int first = 0; first < K; first++) {
				# pragma HLS UNROLL
					for (int second = 0; second < K; second++) {
					# pragma HLS UNROLL
						result += kbuf[first][second] * kern[index];
						index++;
					}
				}
			result >>= shift_div;
			if (result > 0xFF) {
				result = 0xFF;
			} else if (result < 0) {
				result = 0;
			}

			if (i >= DELAY) {
				beat_t val;
				val.data(7, 0) = result;
				val.keep(0, 0) = 0x1;
				val.last.set_bit(0, i == STREAM_LENGTH + DELAY - 1);
				sout << val;
			}
        }
	}
}
