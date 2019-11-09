/*
Name : Deepank Agrawal
Roll No. : 17CS30011
Test Case : 2
*/

int compilers = 1;
int main ()
{
    int arr[10];
    
    int n = 10, i = 1;
    printStr("Enter any number not exceeding 10:\n");
    readInt(&n);
    
    for(i = 0; i < n; i++)
        arr[i] = i*i;

    printStr("The square of the first ");
    printInt(n);
    printStr("non-negative integers:\n");

    for(i = 0; i < n; i++)
    {
        printInt(arr[i]);
        printStr(" ");
    }
    printStr("\n");
    
    return 0;
}
