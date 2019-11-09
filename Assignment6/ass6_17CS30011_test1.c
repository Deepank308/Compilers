/*
Name : Deepank Agrawal
Roll No. : 17CS30011
Test Case : 1
*/

int func(int a, int b);

int foo(int a,int b,int c);

int bar(int a,int b, int c);

int get_random(int a,int b,int c,int d);

int main()
{
	int a, b, c, d, e;
	printStr("Enter the four numbers:\n");
	
	readInt(&a);
	readInt(&b);
	readInt(&c);
	readInt(&d);

	e = get_random(a, b, c, d);
	printStr("A random output is: ");
	printInt(e);
	printStr("\n");
	return 0;
}

int get_random(int a, int b, int c, int d)
{
	int i = 0, j = 0, k, l;
	k = bar(a, b, c);
	l = i + j + k;

	return l;
}

int bar(int a, int b, int c)
{
	int i;
	i = foo(a, b, c);
	return i*(a + b);
}

int foo(int a, int b, int c)
{
	int j;
	j = func(a, b);
	return j + b;
}

int func(int a, int b)
{
	int l;
	l = a + b;
	return l;
}
