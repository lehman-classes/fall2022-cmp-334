#include <stdio.h>

// https://en.wikipedia.org/wiki/Single-precision_floating-point_format
// IEEE 754 standard binary 32
// Sign bit: 1 bit
// Exponent width: 8 bits
// Significant precision: 24 bits (23 explicitly stored)
int main(int argc, char **argv) {
  // single precision binary floating point
  float y;

  // storing 16777215-1 into i
  // (111111111111111111111111)2 = (16777215)10
  int i = (1 << 24) - 1;

  // storing the same value into y
  y = i;

  for (int j = 0; j < 5; j++) {
    // print both values, int and float
    printf("%d %f  ", i, y);
    // print hex representation of both values
    printf("%08x %08x\n", i, *((int*)&y));

    // add one to each
    // note that y won't be able to represent any value past 16777216
    // because float only store 23 bits significant precision
    y = y + 1.0;
    i = i + 1;
  }
}
