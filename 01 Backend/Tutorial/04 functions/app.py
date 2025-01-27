# function definition
def find_square(num):
    result = num * num
    return result

# function call
square = find_square(3)

print('Square:', square)



# Example: Python Library Function
import math

# sqrt computes the square root
square_root = math.sqrt(4)

print("Square Root of 4 is",square_root)

# pow() comptes the power
power = pow(2, 3)

print("2 to the power 3 is",power)


# Function Argument with Default Values
def add_numbers( a = 7,  b = 8):
    sum = a + b
    print('Sum:', sum)


# function call with two arguments
add_numbers(2, 3)

#  function call with one argument
add_numbers(a = 2)

# function call with no arguments
add_numbers()



# Python Function With Arbitrary Arguments
# program to find sum of multiple numbers 

def find_sum(*numbers):
    result = 0
    
    for num in numbers:
        result = result + num
    
    print("Sum = ", result)

# function call with 3 arguments
find_sum(1, 2, 3)

# function call with 2 arguments
find_sum(4, 9)



# Based on the scope, we can classify Python variables into three types:

# Local Variables
# Global Variables
# Nonlocal Variables


# declare global variable
message = 'Hello'

# outside function 
def outer():
    message = 'local'

    # nested function  
    def inner():

        # declare nonlocal variable
        nonlocal message

        message = 'nonlocal'
        print("inner:", message)

    inner()
    print("outer:", message)

outer()


# Python Global Keyword
# Access and Modify Python Global Variable

# global variable
c = 1 

def add():

     # increment c by 2
    c = c + 2

    print(c)

add()
# Output

# UnboundLocalError: local variable 'c' referenced before assignment
# This is because we can only access the global variable but cannot modify it from inside the function.


Example: Changing Global Variable From Inside a Function using global
# global variable
c = 1 

def add():

    # use of global keyword
    global c

    # increment c by 2
    c = c + 2 

    print(c)

add()

# Output: 3 


def factorial(x):
    # """This is a recursive function
    # to find the factorial of an integer"""

    if x == 1:
        return 1
    else:
        return (x * factorial(x-1))


num = 3
print("The factorial of", num, "is", factorial(num))



# import standard math module 
import math

# use math.pi to get value of pi
print("The value of pi is", math.pi)

# import module by renaming it
import math as m

print(m.pi)

# Output: 3.141592653589793

# Python from...import statement
# We can import specific names from a module without importing the module as a whole. For example,

# import only pi from math module
from math import pi

print(pi)

# Output: 3.141592653589793


# import all names from the standard module math
from math import *

print("The value of pi is", pi)

# The dir() built-in function
# In Python, we can use the dir() function to list all the function names in a module.

# For example, earlier we have defined a function add() in the module example.

# We can use dir in example module in the following way:

print(dir(example))


import math
print(dir(math))


# Python Package
# A package is a container that contains various functions to perform specific tasks

# Importing module from a package
# In Python, we can import modules from packages using the dot (.) operator.

# For example, if we want to import the start module in the above example, it can be done as follows:

import Game.Level.start

# Now, if this module contains a function named select_difficulty(), we must use the full name to reference it.

Game.Level.start.select_difficulty(2)

# Import Without Package Prefix
# If this construct seems lengthy, we can import the module without the package prefix as follows:

from Game.Level import start

from Game.Level.start import select_difficulty


# Python Main function
# What is the main() function in Python?
# Some programming languages have a special function called main() which is the execution point for a program file. Python interpreter, however, runs each line serially from the top of the file and has no explicit main() function.

# Python offers other conventions to define the execution point. One of them is using the main() function and the __name__ property of a python file.

def main():
    print("Hello World")

if __name__=="__main__":
    main()


