#include <stdint.h>
#include <stdio.h>


uint32_t six_middle_bits(int32_t value) {
    // starting number -> 0b00011100 01010011 10101011 10101011 = 475245483
    // mask1           -> 0b00000000 00000111 11100000 00000000 = 0x7E000
    // 475245483 >> 13 -> 0b00000000 00000000 11100010 10011101
    // mask            -> 0b00000000000000000000000000111111

    // return (value >> 13) & 0x3F;

    return (value & 0x7E000) >> 13;

}

int main() {
    // starting number -> 0b00011100 01010011 10101011 10101011 = 475245483
    // result          -> 0b00000000 00000000 00000000 00011101 = 29 
    printf("the six middle bits are %d\n", six_middle_bits(475245483));
}