/*
 * A small program that illustrates how to call the max3 function we wrote in
 * assembly language.
 */

#include <stdio.h>
#include <inttypes.h>

int64_t max3(int64_t, int64_t, int64_t);

int main() {
    printf("%lld\n", max3(1, -4, -7));
    printf("%lld\n", max3(2, -6, 1));
    printf("%lld\n", max3(2, 3, 1));
    printf("%lld\n", max3(-2, 4, 3));
    printf("%lld\n", max3(2, -6, 5));
    printf("%lld\n", max3(2, 4, 6));
    return 0;
}