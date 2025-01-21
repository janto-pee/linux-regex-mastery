# VARIABLE ASSIGNMENT
#  assign value to site_name variable
site_name = 'programiz.pro'
print(site_name)

# Changing the Value of a Variable in Python
# assigning a new value to site_name
site_name = 'apple.com'
print(site_name)

# Example: Assigning multiple values to multiple variables
a, b, c = 5, 3.2, 'Hello'

print (a)  # prints 5
print (b)  # prints 3.2
print (c)  # prints Hello 

# If we want to assign the same value to multiple variables at once, we can do this as:
site1 = site2  = 'programiz.com'

print (site1)  # prints programiz.com
print (site2)  # prints programiz.com




# PYTHON LITERALS
# Literals are often used to assign values to variables or constants. For example
# list literal
fruits = ["apple", "mango", "orange"] 
print(fruits)

# tuple literal
numbers = (1, 2, 3) 
print(numbers)

# dictionary literal
alphabets = {'a':'apple', 'b':'ball', 'c':'cat'} 
print(alphabets)

# set literal
vowels = {'a', 'e', 'i' , 'o', 'u'} 
print(vowels)


# Special chracter literals -None
value = None

print(value)

# Output: None



# In programming, type conversion is the process of converting data of one type to another. For example: converting int data to str.
# There are two types of type conversion in Python.

# Implicit Conversion - automatic type conversion
# Explicit Conversion - manual type conversion

integer_number = 123
float_number = 1.23

new_number = integer_number + float_number

# display new value and resulting data type
print("Value:",new_number)
print("Data Type:",type(new_number))


# EXPLICIT
num_string = '12'
num_integer = 23

print("Data type of num_string before Type Casting:",type(num_string))

# explicit type conversion
num_string = int(num_string)

print("Data type of num_string after Type Casting:",type(num_string))

num_sum = num_integer + num_string

print("Sum:",num_sum)
print("Data type of num_sum:",type(num_sum))


# BASIC INOUT AND OUTPUT
print('Python is powerful')

# Output: Python is powerful

# Syntax of print
# print(object= separator= end= file= flush=)
# print with end whitespace
print('Good Morning!', end= ' ')
print('It is rainy today')
# Good Morning! It is rainy today

print('New Year', 2023, 'See you soon!', sep= '. ')
# New Year. 2023. See you soon!


# Example: Print Python Variables and Literals
number = -10.6
name = "Programiz"

# print literals     
print(5)

# print variables
print(number)
print(name)

# Example: Print Concatenated Strings
print('Programiz is ' + 'awesome.')
print(4*4)

# Output formatting
x = 5
y = 10

print('The value of x is {} and y is {}'.format(x,y))


# Python Input
# Syntax of input()

# input(prompt)

# using input() to take user input
num = input('Enter a number: ')

print('You Entered:', num)

print('Data type of num:', type(num))





# OPERATORS
# Example 1: Arithmetic Operators in Python

a = 7
b = 2

# addition
print ('Sum: ', a + b)  

# subtraction
print ('Subtraction: ', a - b)   

# multiplication
print ('Multiplication: ', a * b)  

# division
print ('Division: ', a / b) 

# floor division
print ('Floor Division: ', a // b)

# modulo
print ('Modulo: ', a % b)  

# a to the power b
print ('Power: ', a ** b)   




# 2. Python Assignment Operators
# assign 10 to a
a = 10

# assign 5 to b
b = 5 

# assign the sum of a and b to a
a += b      # a = a + b
print(a)

# Output: 15



# 3. Python Comparison Operators
# ==; <=; !=; >=; >; <
# Example 3: Comparison Operators

a = 5

b = 2

# equal to operator
print('a == b =', a == b)

# not equal to operator
print('a != b =', a != b)

# greater than operator
print('a > b =', a > b)

# less than operator
print('a < b =', a < b)

# greater than or equal to operator
print('a >= b =', a >= b)

# less than or equal to operator
print('a <= b =', a <= b)




# 4. Python Logical Operators
# Example 4: Logical Operators
# logical AND
print(True and True)     # True
print(True and False)    # False

# logical OR
print(True or False)     # True

# logical NOT
print(not True)          # False


# 6. Python Special operators
# Example 4: Identity operators in Python
x1 = 5
y1 = 5
x2 = 'Hello'
y2 = 'Hello'
x3 = [1,2,3]
y3 = [1,2,3]

print(x1 is not y1)  # prints False

print(x2 is y2)  # prints True

print(x3 is y3)  # prints False



# Membership operators

message = 'Hello world'
dict1 = {1:'a', 2:'b'}

# check if 'H' is present in message string
print('H' in message)  # prints True

# check if 'hello' is present in message string
print('hello' not in message)  # prints True

# check if '1' key is present in dict1
print(1 in dict1)  # prints True

# check if 'a' key is present in dict1
print('a' in dict1)  # prints False










