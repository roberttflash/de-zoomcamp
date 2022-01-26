#!/bin/python3

import math
import os
import random
import re
import sys



#
# Complete the 'getMin' function below.
#
# The function is expected to return an INTEGER.
# The function accepts STRING s as parameter.
#

def getMin(s):
    # Write your code here
         
    bal=0
    ans=0
    for i in range(0,len(s)):
        if(s[i]=='('):
            bal+=1
        else:
            bal+=-1
             
        if(bal==-1):
            ans+=1
            bal+=1
    return bal+ans
if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    s = input()

    result = getMin(s)

    fptr.write(str(result) + '\n')

    fptr.close()
