// include my library functions
#include "myl.h"

int main()
{
    float flt;
    int choice, integer;
    // provide user list of choices
    while(1)
    {
        printStr("\nProvide command to execute:\n");
        printStr("1. Read Integer\n");
        printStr("2. Print Integer\n");
        printStr("3. Read Float\n");
        printStr("4. Print Float\n");
        printStr("5. Quit\n");

        printStr("Enter choice: \n");
        if(readInt(&choice) == ERR)
        {
            printStr("Invalid choice, re-enter: ");
            continue;
        }
        if(choice == 5) break;
        // perform action based on user command
        switch(choice)
        {
            case 1: printStr("Enter int: ");
                    if(readInt(&integer) == ERR)
                        printStr("ERR: The integer is not valid.\n");
                    else
                        printStr("Integer read.\n");
                    break;
            case 2: printInt(integer);
                    break;
            case 3: printStr("Enter float: ");
                    if(readFlt(&flt) == ERR)
                        printStr("ERR: The float is not valid.\n");
                    else
                        printStr("Float read.\n");
                    break;
            case 4: printFlt(flt);
                    break;
            default:
                    break;
        }
    }
    return 0;
}