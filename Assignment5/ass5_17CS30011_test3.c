/*
Name : Deepank Agrawal
Roll No. : 17CS30011
Test Case : 3
*/

void get_exp(int temp, int elements);
int get_mod_exp(int int_var, int elements,int value);
int main();

void get_exp(int temp, int elements)
{
  temp = temp++;
  temp = elements;
  return;
}

int get_mod_exp(int int_var, int elements,int value)
{
  int i, passes = -1;
  if(int_var >= value)
    passes = passes + 1;
  return passes;
}

int main()
{
  int n = 10, j = 0;
  for(int i = 0; i < n; i++)
    j = j + 1;
  if(n >= 0)
  {
    int int_var = 3;
    int result;
    get_exp(int_var, 3);
    result = get_mod_exp(int_var, 4, 3);
  }
  else
  {
    int int_var = 11;
    get_exp(int_var, 11);
  }
}
