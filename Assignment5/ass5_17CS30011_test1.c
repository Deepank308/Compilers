/*
Name : Deepank Agrawal
Roll No. : 17CS30011
Test Case : 1
*/

double arr1[3][6];

int func(int a, int b);

int foo(int a,int b,int c);

int bar(int a,int b, int c);

double get_maximum(int a,int b,int c,int d);

int main()
{
	int a = 6, b = 7, c = 8, d = 9;
	get_maximum(a, b, c, d);
	return 0;
}

double get_maximum(int a, int b, int c, int d)
{
	foo(a, b, c);
	func(a, b);
	bar(a, b, c);
	return 3.142857;
}

int bar(int a, int b, int c)
{
	foo(a, b, c);
	return 5*(6 + 4);
}

int foo(int a, int b, int c)
{
	func(a, b);
	return 10 + 67;
}

int func(int a, int b)
{
	int k;
	bar(a, b, k);
	return 4;
}
