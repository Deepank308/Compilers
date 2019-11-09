/*
Name : Deepank Agrawal
Roll No. : 17CS30011
Test Case : 4
*/

int sum(int a,int b);

int mod(int a, int b);

int divide(int a,int b);

int a, b;
int main()
{
	int arr[3][6];
	double arr2[56];
	int x;
	int x, y, z, w;
	x = sum(a, b);
	y = mod(a, b);
	z = divide(a, b);
}

int sum(int a, int b)
{
	int ans = a + b;
	return ans;
}

int mod(int a, int b)
{
	double ans = a%b;
	return ans;
}

int divide(int a, int b)
{
	int ans[5];
	if(b != 0)
		ans[0] = a / b;
	else
		ans[0] = -1;
	return ans[0];
}
