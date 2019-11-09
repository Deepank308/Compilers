/*
Name : Deepank Agrawal
Roll No. : 17CS30011
Test Case : 3
*/

int sumOfDigits(int x)
{
    if((x / 10) == 0)
    {
        return x;
    }
    else
    {
        return (sumOfDigits(x%10) + sumOfDigits(x / 10));     
    }
}

int main()
{
    int n;

    printStr("Enter Integer:\n");
    readInt(&n);

    int s;
    s = sumOfDigits(n);
    printStr("Sum of Digit: ");
    printInt(s);
    printStr("\n");

    return 0;
}