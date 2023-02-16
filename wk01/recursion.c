#include <stdio.h>


// 4! = 4 * 3 * 2 * 1 = 4 * 3!
// 3! =     3 * 2 * 1
// ...
// n! = n * (n-1)!
int factorial(int n) {
    // base case ; n = 0 return 1
    if (n == 0) {
        return 1;
    }
    // general case // n! = n * (n-1)!
    return n * factorial(n - 1);
}

int main(void)
{
    int n;
    printf("Enter a number:\n");
    scanf("%d", &n);
    printf("%d\n", factorial(n)); 
    return 0;
}
