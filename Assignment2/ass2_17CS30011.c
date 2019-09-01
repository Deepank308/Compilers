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

int readFlt(float *f)
{
    char buff[100];
    int disp, i = 0, int_p, flag = 0, flag2 = 0;
    float fac = 0.1, dec_p = 0.0, ans;
    // assembly code to scan number
    asm volatile("syscall"
    : "=a" (disp)
    : "0" (SYS_READ), "D" (STDIN_FILENO),
    "S" (buff), "d" (sizeof(buff))
    : "rcx", "r11", "memory", "cc");

    if(buff[i] == '-')
    {
        flag = 1;
        i++;
    }
    if(buff[i] >= '0' && buff[i] <= '9')
    {
        int_p = buff[i] - '0';
        i++;
    }
    else if(buff[i] == '.')
    {
        flag2 = 1;
        i++;
    }
    else
        return ERR;
    // build the number digit by digit
    while(i < disp - 1)
    {
        if(buff[i] == '.')
        {
            if(flag2 == 1) return ERR;
            flag2 = 1;
        }
        else if(buff[i] < '0' || buff[i] > '9')
            return ERR;
        else if(flag2 == 0)
            int_p = int_p*10 + buff[i] - '0';
        else
        {
            dec_p = dec_p + fac*(buff[i] - '0');
            fac = fac*0.1;
        }
        i++;
    }
    // add the integer and decimal part 
    ans = int_p + dec_p;
    // if number is negative
    if(flag == 1)
        ans = -1.0*ans;
    *f = ans;
    return OK;
}

int printFlt(float f)
{
    // store the integer and floating part
    int i = 1, length = 7;
    int int_p = (int)f;
    float dec_p = f - (float)int_p;
    // char array to store the decimal part
    char buff[20];
    // if number is negative, print the minus sign
    if(int_p == 0 && f < 0)
        printStr("-"); 
    // store the length to return
    length = length + printInt(int_p);
    if(dec_p < 0) dec_p = -dec_p;
    buff[0] = '.';
    // get decimal digit by digit
    for(; dec_p > 0 && i < 7; i++)
    {
        dec_p = dec_p*10;
        int_p = (int)dec_p;
        buff[i] = int_p + '0';
        dec_p = dec_p - int_p;
    }
    // add trailing zeros, if any
    for(; i < 7; i++)
        buff[i] = '0';
    // add null string at the end
    buff[i] = '\0';
    printStr(buff);
    return length;
}