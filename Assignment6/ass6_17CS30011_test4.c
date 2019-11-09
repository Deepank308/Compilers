/*
Name : Deepank Agrawal
Roll No. : 17CS30011
Test Case : 4
*/

int main()
{
    int n, reversedInteger , remainder, originalInteger;
    reversedInteger = 0;
    
	printStr("Enter an integer: ");
    
	readInt(&n);

    originalInteger = n;
    while( n !=0 )
    {
        remainder = n%10;
        reversedInteger = reversedInteger*10 + remainder;
        n = n/10;
    }
    if (originalInteger == reversedInteger)
        printStr("Yes, It is a palindrome.\n");
    else
        printStr("No, It is not a palindrome.\n");
    
    return 0;
}