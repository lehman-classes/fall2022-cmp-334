#include <stdio.h>

// https://en.wikipedia.org/wiki/Double-precision_floating-point_format
// IEEE 754 double-precision binary64
// Sign bit: 1 bit
// Exponent width: 11 bits
// Significant precision: 53 bits (52 explicitly stored)
int main(int argc, char **argv) {
  // double precision binary floating point
  double y;

  // storing 16777215-1 into i
  // (11111111111111111111111111111111111111111111111111111)2 = (9007199254740991)10
  long i = (1l << 53) - 1l;

  // storing the same value into y
  y = i;

  for (int j = 0; j < 5; j++) {
    // print both values, int and float
    printf("%ld %lf  ", i, y);
    // print hex representation of both values
    printf("%08lx %08lx\n", i, *((long*)&y));

    // add one to each
    // note that y won't be able to represent any value past 9007199254740991
    // because float only store 52 bits significant precision
    y = y + 1.0;
    i = i + 1;
  }
}
