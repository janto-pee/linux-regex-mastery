# Python if...else Statement

number = 5

# outer if statement
if number >= 0:
    # inner if statement
    if number == 0:
      print('Number is 0')
    
    # inner else statement
    else:
        print('Number is positive')

# outer else statement
else:
    print('Number is negative')


# Python for Loop
languages = ['Swift', 'Python', 'Go']

# access elements of the list one by one
for lang in languages:
    print(lang)


language = 'Python'

# iterate over each character in language
for x in language:
    print(x)
   


languages = ['Swift', 'Python', 'Go', 'C++']

for lang in languages:
    if lang == 'Go':
        break # continue
    print(lang)

# outer loop 
attributes = ['Electric', 'Fast']
cars = ['Tesla', 'Porsche', 'Mercedes']

for attribute in attributes:
    for car in cars:
        print(attribute, car)
    
    # this statement is outside the inner loop
    print("-----")
  


# Python while Loop
# In Python, we use a while loop to repeat a block of code until a certain condition is met. For example,

# Print numbers until the user enters 0
number = int(input('Enter a number: '))

# iterate until the user enters 0
while number != 0:
    print(f'You entered {number}.')
    number = int(input('Enter a number: '))

print('The end.')


# Infinite while Loop
# If the condition of a while loop always evaluates to True, the loop runs continuously, forming an infinite while loop. For example,

# age = 32

# # The test condition is always True
# while age > 18:
#     print('You can vote')

# Python pass Statement
# Suppose we have a loop or a function that is not implemented yet, but we want to implement it in the future. In such cases, we can use the pass statement.
# Using pass With Conditional Statement
n = 10

# use pass inside if statement
if n > 10:
    pass

print('Hello')




