/*
Name : Deepank Agrawal
Roll No. : 17CS30011
Test Case : 5
*/

int main()
{
    //declaration of all types
    int n = 2;
    if(n >= 0)
    {
        if(n <= 10)
        {
            char a = 'a', b = 'b', c = 'c';
            double dp[43][67];
            char *d = &a;
            int k = 9;
            int l = k + 10;
            int i = 50, *p = &l;
        }
        else
        {
            char a = 'a';
            double h = 11;
        }
        
    }
    else
    {
        return 0;
    }
    n = 35;
    return 0;
    
}

int mult(double a, int b)
{
    int ans;
    
    ans = a*b;
    ans = ans*a;
    a = b*ans;
    
    ans = a*a + b*b + ans*ans;
    
    return ans;
}

char func(int a, double b, char c)
{
    char *p = &c;
    int i = a + b;
    
    return c;
}