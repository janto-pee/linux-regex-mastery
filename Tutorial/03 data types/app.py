# Python Numbers, Type Conversion and Mathematics
num1 = 5
print(num1, 'is of type', type(num1))

num2 = 5.42
print(num2, 'is of type', type(num2))

num3 = 8+2j
print(num3, 'is of type', type(num3))


# Number Systems

print(0b1101011)  # prints 107

print(0xFB + 0b10)  # prints 253

print(0o15)  # prints 13

# Type Conversion in Python
print(1 + 2.0) # prints 3.0


num1 = int(2.3)
print(num1)  # prints 2

num2 = int(-2.8)
print(num2)  # prints -2

num3 = float(5)
print(num3) # prints 5.0

num4 = complex('3+5j')
print(num4)  # prints (3 + 5j)


# Python Random Module
import random

print(random.randrange(10, 20))

list1 = ['a', 'b', 'c', 'd', 'e']

# get random item from list1
print(random.choice(list1))

# Shuffle list1
random.shuffle(list1)

# Print the shuffled list1
print(list1)

# Print random element
print(random.random())


# Python Mathematics
# Python offers the math module to carry out different mathematics like trigonometry, logarithms, probability and statistics, etc. For example,

import math

print(math.pi)

print(math.cos(math.pi))

print(math.exp(10))

print(math.log10(1000))

print(math.sinh(1))

print(math.factorial(6))


# Python List
# In Python, lists allow us to store multiple items in a single variable. For example, if you need to store the ages of all the students in a class, you can do this task using a list.

# Create a Python List
# a list of three elements
ages = [19, 26, 29]
print(ages)

# List Items of Different Types
# List Items of Different Types
# Python lists are very flexible. We can also store data of different data types in a list. For example,

# a list containing strings, numbers and another list
student = ['Jack', 32, 'Computer Science', [2, 4]]
print(student)

# an empty list
empty_list = []
print(empty_list)


# List Characteristics
# In Python, lists are:

# Ordered - They maintain the order of elements.
# Mutable - Items can be changed after creation.
# Allow duplicates - They can contain duplicate values.

# Access List Elements

languages = ['Python', 'Swift', 'C++']

# access the first element
print('languages[0] =', languages[0])

# access the third element
print('languages[2] =', languages[2])


languages = ['Python', 'Swift', 'C++']

# access the last item
print('languages[-1] =', languages[-1])
# languages[-1] = C++

# access the third last item
print('languages[-3] =', languages[-3]) 
# languages[-3] = Python


# Slicing of a List in Python
# If we need to access a portion of a list, we can use the slicing operator, :. For example,

my_list = ['p', 'r', 'o', 'g', 'r', 'a', 'm']
print("my_list =", my_list)

# get a list with items from index 2 to index 4 (index 5 is not included)
print("my_list[2: 5] =", my_list[2: 5])    

# get a list with items from index 2 to index -3 (index -2 is not included)
print("my_list[2: -2] =", my_list[2: -2])  

# get a list with items from index 0 to index 2 (index 3 is not included)
print("my_list[0: 3] =", my_list[0: 3])


# Output
# my_list = ['p', 'r', 'o', 'g', 'r', 'a', 'm']
# my_list[2: 5] = ['o', 'g', 'r']
# my_list[2: -2] = ['o', 'g', 'r']
# my_list[0: 3] = ['p', 'r', 'o']

# Omitting Start and End Indices in Slicing
my_list = ['p', 'r', 'o', 'g', 'r', 'a', 'm']
print("my_list =", my_list)

# get a list with items from index 5 to last
print("my_list[5: ] =", my_list[5: ])

# get a list from the first item to index -5
print("my_list[: -4] =", my_list[: -4])

# omitting both start and end index
# get a list from start to end items
print("my_list[:] =", my_list[:])

# Output
# my_list = ['p', 'r', 'o', 'g', 'r', 'a', 'm']
# my_list[5: ] = ['a', 'm']
# my_list[: -4] = ['p', 'r', 'o']
# my_list[:] = ['p', 'r', 'o', 'g', 'r', 'a', 'm']

# Add Elements to a Python List
fruits = ['apple', 'banana', 'orange']
print('Original List:', fruits)

fruits.append('cherry')

print('Updated List:', fruits)

# Add Elements at the Specified Index
fruits = ['apple', 'banana', 'orange']
print("Original List:", fruits) 

fruits.insert(2, 'cherry')

print("Updated List:", fruits)
# Output
# Original List: ['apple', 'banana', 'orange']
# Updated List: ['apple', 'banana', 'cherry', 'orange']


# Add Elements to a List From Other Iterables
numbers = [1, 3, 5]
print('Numbers:', numbers)

even_numbers  = [2, 4, 6]
print('Even numbers:', numbers)

# adding elements of one list to another
numbers.extend(even_numbers)

print('Updated Numbers:', numbers) 
# Output
# Numbers: [1, 3, 5]
# Even numbers: [2, 4, 6]
# Updated Numbers: [1, 3, 5, 2, 4, 6]

# Change List Items
colors = ['Red', 'Black', 'Green']
print('Original List:', colors)

# change the first item to 'Purple'
colors[2] = 'Purple'

# change the third item to 'Blue'
colors[2] = 'Blue'

print('Updated List:', colors)

numbers = [2,4,7,9]

# remove 4 from the list
numbers.remove(4)

print(numbers) 


# Remove One or More Elements of a List
names = ['John', 'Eva', 'Laura', 'Nick', 'Jack']

# delete the item at index 1
del names[1]
print(names)

# delete items from index 1 to index 2
del names[1: 3]
print(names)

# delete the entire list
del names

# Error! List doesn't exist.
print(names)

cars = ['BMW', 'Mercedes', 'Tesla']

print('Total Elements:', len(cars))


fruits = ['apple', 'banana', 'orange']

# iterate through the list
for fruit in fruits:
    print(fruit)


#     Python List Methods
# Python has many useful list methods that make it really easy to work with lists.

# Method	Description
# append()	Adds an item to the end of the list
# extend()	Adds items of lists and other iterables to the end of the list
# insert()	Inserts an item at the specified index
# remove()	Removes the specified value from the list
# pop()	Returns and removes item present at the given index
# clear()	Removes all items from the list
# index()	Returns the index of the first matched item
# count()	Returns the count of the specified item in the list
# sort()	Sorts the list in ascending/descending order
# reverse()	Reverses the item of the list
# copy()	Returns the shallow copy of the list

# Python Tuple
# A tuple is a collection similar to a Python list. The primary difference is that we cannot modify a tuple once it is created.

numbers = (1, 2, -5)
print(numbers)

# We can also create a tuple using a tuple() constructor. For example,
# Output: (1, 2, -5)
tuple_constructor = tuple(('Jack', 'Maria', 'David'))
print(tuple_constructor)

# Output: ('Jack', 'Maria', 'David')

languages = ('Python', 'Swift', 'C++')

# access the first item
print(languages[0])   # Python

# access the third item
print(languages[2])   # C++

# Tuple Cannot be Modified
# Python tuples are immutable (unchangeable). We cannot add, change, or delete items of a tuple.

# If we try to modify a tuple, we will get an error. For example,

cars = ('BMW', 'Tesla', 'Ford', 'Toyota')

# trying to modify a tuple
cars[0] = 'Nissan'    # error
       
print(cars)

# Python Tuple Length
# We use the len() function to find the number of items present in a tuple. For example,

cars = ('BMW', 'Tesla', 'Ford', 'Toyota')
print('Total Items:', len(cars)) 

fruits = ('apple','banana','orange')

# iterate through the tuple
for fruit in fruits:
    print(fruit)

# create a string using double quotes
string1 = "Python programming"

# create a string using single quotes
string1 = 'Python programming'

# create string type variables

name = "Python"
print(name)

message = "I love Python."
print(message)

greet = 'hello'

# access 1st index element
print(greet[1]) # "e"

greet = 'hello'

# access 4th last element
print(greet[-4]) # "e"

greet = 'Hello'

# access character from 1st index to 3rd index
print(greet[1:4])  # "ell"

# Python Strings are Immutable
message = 'Hola Amigos'
message[0] = 'H'
print(message)
# TypeError: 'str' object does not support item assignment

message = 'Hola Amigos'

# assign new string to message variable
message = 'Hello Friends'

print(message); # prints "Hello Friends"

# multiline string 
message = """
Never gonna give you up
Never gonna let you down
"""

print(message)

str1 = "Hello, world!"
str2 = "I love Swift."
str3 = "Hello, world!"

# compare str1 and str2
print(str1 == str2)

# compare str1 and str3
print(str1 == str3)


greet = "Hello, "
name = "Jack"

# using + operator
result = greet + name
print(result)

# Output: Hello, Jack

greet = 'Hello'

# iterating through greet string
for letter in greet:
    print(letter)

greet = 'Hello'

# count length of greet string
print(len(greet))

# Output: 5

print('a' in 'program') # True
print('at' not in 'battle') # False


# Methods	Description
# upper() 	Converts the string to uppercase
# lower()	Converts the string to lowercase
# partition()	Returns a tuple
# replace()	Replaces substring inside
# find()	Returns the index of the first occurrence of substring
# rstrip()	Removes trailing characters
# split()	Splits string from left
# startswith()	Checks if string starts with the specified string
# isnumeric()	Checks numeric characters
# index()	Returns index of substring

# Escape Sequences in Python

# example = "He said, "What's there?""

# print(example) # throws error


# escape double quotes
example = "He said, \"What's there?\""

# escape single quotes
example = 'He said, "What\'s there?"'

print(example)

# Output: He said, "What's there?"


# Python Sets
# A set is a collection of unique data, meaning that elements within a set cannot be duplicated.
# create a set of integer type
student_id = {112, 114, 116, 118, 115}
print('Student ID:', student_id)

# create a set of string type
vowel_letters = {'a', 'e', 'i', 'o', 'u'}
print('Vowel Letters:', vowel_letters)

# create a set of mixed data types
mixed_set = {'Hello', 101, -2, 'Bye'}
print('Set of mixed data types:', mixed_set)

# Create an Empty Set in Python
# create an empty set
empty_set = set()

# create an empty dictionary
empty_dictionary = { }

# check data type of empty_set
print('Data type of empty_set:', type(empty_set))

# check data type of dictionary_set
print('Data type of empty_dictionary:', type(empty_dictionary))

# Duplicate Items in a Set
numbers = {2, 4, 6, 6, 2, 8}
print(numbers)   # {8, 2, 4, 6}

# Add and Update Set Items in Python
# Add Items to a Set in Python

numbers = {21, 34, 54, 12}

print('Initial Set:',numbers)

# using add() method
numbers.add(32)

print('Updated Set:', numbers) 
# Initial Set: {34, 12, 21, 54}
# Updated Set: {32, 34, 12, 21, 54}
numbers.add(32)


companies = {'Lacoste', 'Ralph Lauren'}
tech_companies = ['apple', 'google', 'apple']

# using update() method
companies.update(tech_companies)

print(companies)

# Output: {'google', 'apple', 'Lacoste', 'Ralph Lauren'}

languages = {'Swift', 'Java', 'Python'}

print('Initial Set:',languages)

# remove 'Java' from a set
removedValue = languages.discard('Java')

print('Set after remove():', languages)

# Built-in Functions with Set
# Here are some of the popular built-in functions that allow us to perform different operations on a set.
# all()	Returns True if all elements of the set are true (or if the set is empty).
# any()	Returns True if any element of the set is true. If the set is empty, returns False.
# enumerate()	Returns an enumerate object. It contains the index and value for all the items of the set as a pair.
# len()	Returns the length (the number of items) in the set.
# max()	Returns the largest item in the set.
# min()	Returns the smallest item in the set.
# sorted()	Returns a new sorted list from elements in the set(does not sort the set itself).
# sum()	Returns the sum of all elements in the set.


fruits = {"Apple", "Peach", "Mango"}

# for loop to access each fruits
for fruit in fruits: 
    print(fruit)

even_numbers = {2,4,6,8}
print('Set:',even_numbers)

# find number of elements
print('Total Elements:', len(even_numbers))


# Python Set Operations
# Python Set provides different built-in methods to perform mathematical set operations like union, intersection, subtraction, and symmetric difference.

# Union of Two Sets
# The union of two sets A and B includes all the elements of sets A and B.

# first set
A = {1, 3, 5}

# second set
B = {0, 2, 4}

# perform union operation using |
print('Union using |:', A | B)

# perform union operation using union()
print('Union using union():', A.union(B)) 
# Union using |: {0, 1, 2, 3, 4, 5}
# Union using union(): {0, 1, 2, 3, 4, 5}


# Set Intersection
# The intersection of two sets A and B include the common elements between set A and B.
# first set
A = {1, 3, 5}

# second set
B = {1, 2, 3}

# perform intersection operation using &
print('Intersection using &:', A & B)

# perform intersection operation using intersection()
print('Intersection using intersection():', A.intersection(B)) 

# Intersection using &: {1, 3}
# Intersection using intersection(): {1, 3}

# The difference between two sets A and B include elements of set A that are not present on set B.
# first set
A = {2, 3, 5}

# second set
B = {1, 2, 6}

# perform difference operation using &
print('Difference using &:', A - B)

# perform difference operation using difference()
print('Difference using difference():', A.difference(B)) 
# Difference using &: {3, 5}
# Difference using difference(): {3, 5}

# Set Symmetric Difference
# The symmetric difference between two sets A and B includes all elements of A and B without the common elements.

# first set
A = {2, 3, 5}

# second set
B = {1, 2, 6}

# perform difference operation using &
print('using ^:', A ^ B)

# using symmetric_difference()
print('using symmetric_difference():', A.symmetric_difference(B)) 

# using ^: {1, 3, 5, 6}
# using symmetric_difference(): {1, 3, 5, 6}


# Check if two sets are equal
# first set
A = {1, 3, 5}

# second set
B = {3, 5, 1}

# perform difference operation using &
if A == B:
    print('Set A and Set B are equal')
else:
    print('Set A and Set B are not equal')

# Other Python Set Methods
# There are many set methods, some of which we have already used above. Here is a list of all the methods that are available with the set objects:

# Method	Description
# add()	Adds an element to the set
# clear()	Removes all elements from the set
# copy()	Returns a copy of the set
# difference()	Returns the difference of two or more sets as a new set
# difference_update()	Removes all elements of another set from this set
# discard()	Removes an element from the set if it is a member. (Do nothing if the element is not in set)
# intersection()	Returns the intersection of two sets as a new set
# intersection_update()	Updates the set with the intersection of itself and another
# isdisjoint()	Returns True if two sets have a null intersection
# issubset()	Returns True if another set contains this set
# issuperset()	Returns True if this set contains another set
# pop()	Removes and returns an arbitrary set element. Raises KeyError if the set is empty
# remove()	Removes an element from the set. If the element is not a member, raises a KeyError
# symmetric_difference()	Returns the symmetric difference of two sets as a new set
# symmetric_difference_update()	Updates a set with the symmetric difference of itself and another
# union()	Returns the union of sets in a new set
# update()	Updates the set with the union of itself and others



# Python Dictionary
# creating a dictionary
country_capitals = {
  "Germany": "Berlin", 
  "Canada": "Ottawa", 
  "England": "London"
}

# printing the dictionary
print(country_capitals)
# {'Germany': 'Berlin', 'Canada': 'Ottawa', 'England': 'London'}

# Keys of a dictionary must be immutable

country_capitals = {
  "Germany": "Berlin", 
  "Canada": "Ottawa", 
  "England": "London"
}

# access the value of keys
print(country_capitals["Germany"])    # Output: Berlin
print(country_capitals["England"])    # Output: London


country_capitals = {
  "Germany": "Berlin", 
  "Canada": "Ottawa", 
}

# add an item with "Italy" as key and "Rome" as its value
country_capitals["Italy"] = "Rome"

print(country_capitals)
# {'Germany': 'Berlin', 'Canada': 'Ottawa', 'Italy': 'Rome'}

country_capitals = {
  "Germany": "Berlin", 
  "Canada": "Ottawa", 
}

# delete item having "Germany" key
del country_capitals["Germany"]

print(country_capitals)
# {'Canada': 'Ottawa'}

country_capitals = {
  "Germany": "Berlin", 
  "Canada": "Ottawa", 
}

# clear the dictionary
country_capitals.clear()

print(country_capitals)  

# Output
# {}

country_capitals = {
  "Germany": "Berlin", 
  "Italy": "Naples", 
  "England": "London"
}

# change the value of "Italy" key to "Rome"
country_capitals["Italy"] = "Rome"

print(country_capitals)
# {'Germany': 'Berlin', 'Italy': 'Rome', 'England': 'London'}


country_capitals = {
  "United States": "Washington D.C.", 
  "Italy": "Rome" 
}

# print dictionary keys one by one
for country in country_capitals:
    print(country)

print()

# print dictionary values one by one
for country in country_capitals:
    capital = country_capitals[country]
    print(capital)


country_capitals = {"England": "London", "Italy": "Rome"}

# get dictionary's length
print(len(country_capitals))   # Output: 2

numbers = {10: "ten", 20: "twenty", 30: "thirty"}

# get dictionary's length
print(len(numbers))            # Output: 3

countries = {}

# get dictionary's length
print(len(countries))          # Output: 0


# Python Dictionary Methods
# Here are some of the commonly used dictionary methods.

# Function	Description
# pop()	Removes the item with the specified key.
# update()	Adds or changes dictionary items.
# clear()	Remove all the items from the dictionary.
# keys()	Returns all the dictionary's keys.
# values()	Returns all the dictionary's values.
# get()	Returns the value of the specified key.
# popitem()	Returns the last inserted key and value as a tuple.
# copy()	Returns a copy of the dictionary.

# Dictionary Membership Test
file_types = {
    ".txt": "Text File",
    ".pdf": "PDF Document",
    ".jpg": "JPEG Image",
}

# use of in and not in operators
print(".pdf" in file_types)       # Output: True
print(".mp3" in file_types)       # Output: False
print(".mp3" not in file_types)   # Output: True





