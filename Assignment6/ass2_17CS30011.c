#include "myl.h"
#define STDIN_FILENO 0
#define SYS_READ 0

// Function to print string, returns the number of characters printed
int printStr(char *S)
{
    int count = 0;
    // get length of the string
    while(S[count++] != '\0');
    // assembly code to print the string
    __asm__ __volatile__(
        "movl $1, %%eax \n\t"
        "movq $1, %%rdi \n\t"
        "syscall \n\t"
        :
        :"S"(S), "d"(count)
    );
    // printed length of string
    return count;
}

int readInt(int *n)
{
    char buff[100];
    int disp, i = 0, num, flag = 0;
    // get the input string in the buff array
    asm volatile("syscall"
    : "=a" (disp)
    : "0" (SYS_READ), "D"
    (STDIN_FILENO), "S"(buff),
    "d"(sizeof(buff))
    : "rcx", "r11", "memory", "cc");

    // check for negative number
    if(buff[i] == '-')
    {
        flag = 1;
        i++;
    }
    if(buff[i] >= '0' && buff[i] <= '9')
    {
        num = buff[i] - '0';
        i++;
    }
    // Return error if not integer
    else
        return ERR;
    // store the number and return the pointer
    while(i < disp - 1)
    {
        if(buff[i] < '0' || buff[i] > '9')
            return ERR;
        num = num*10 + buff[i] - '0';
        i++;
    }
    // if negative multiply with -1
    if(flag == 1)
        num = -1*num;
    *n = num;
    return OK;
}

int printInt(int n)
{
    char buff[20], zero = '0', temp;
    int i = 0, j = 0, bytes, k;
    // if n is zero, put zero and print
    if(n == 0)
    {
        buff[i] = zero;
        i += 1;
    }
    // add negative sign if negative
    if(n < 0)
    {
        n = -1*n;
        buff[i] = '-';
        i = i + 1;
    }
    // get digit by digit and add to the print buffer
    for(;;)
    {
        if(n == 0)
            break;
        buff[i] = (char)(n%10 + zero);
        n = n / 10;
        i = i + 1;
    }
    if(buff[0] == '-')
        j = 1;
    k = i - 1;
    bytes = i;
    // reverse the buffer string
    for(; j < k; j++, k--)
    {
        temp = buff[j];
        buff[j] = buff[k];
        buff[k] = temp;
    }
    // assembly code to print the integer
    __asm__ __volatile__(
        "movl $1, %%eax \n\t"
        "movq $1, %%rdi \n\t"
        "syscall \n\t"
        :
        :"S"(buff), "d"(bytes)
    );
    return bytes;
}
