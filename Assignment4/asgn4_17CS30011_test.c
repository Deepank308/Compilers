int main()
{
    int t;

    while(t--)
    {
        int n;

        int arr[n];
        for(i = 0; i < n; i++);
        int x;
        int low = 0, high = n, mid;

        while(low < high)
        {
            mid = (low + high) / 2;
            if(arr[mid] == x)
                break;
            if(arr[mid] >= arr[low])
            {
                if(arr[mid] >= x && x >= arr[low])
                    high = mid;
                else
                    low = mid + 1;
            }
            else
            {
                if(arr[mid] <= x && x <= arr[high - 1])
                    low = mid + 1;
                else
                    high = mid;
            }
            if(low >= high)
            {
                mid = -1;
                break;
            }
        }
    }    
    return;
}