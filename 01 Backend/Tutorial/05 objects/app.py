# Python Classes
# A class is considered a blueprint of objects.

# We can think of the class as a sketch (prototype) of a house. It contains all the details about the floors, doors, windows, etc.

# Based on these descriptions, we build the house; the house is the object.

# Since many houses can be made from the same description, we can create many objects from a class.

# Example 1: Python Class and Objects
# define a class
class Bike:
    name = ""
    gear = 0

# create object of class
bike1 = Bike()

# access attributes and assign new values
bike1.gear = 11
bike1.name = "Mountain Bike"

print(f"Name: {bike1.name}, Gears: {bike1.gear} ")



# Create Multiple Objects of Python Class
# We can also create multiple objects from a single class. For example,

# define a class
class Employee:
    # define a property
    employee_id = 0

# create two objects of the Employee class
employee1 = Employee()
employee2 = Employee()

# access property using employee1
employee1.employeeID = 1001
print(f"Employee ID: {employee1.employeeID}")

# access properties using employee2
employee2.employeeID = 1002
print(f"Employee ID: {employee2.employeeID}")


# Python Methods
# create a class
class Room:
    length = 0.0
    breadth = 0.0
    
    # method to calculate area
    def calculate_area(self):
        print("Area of Room =", self.length * self.breadth)

# create object of Room class
study_room = Room()

# assign values to all the properties 
study_room.length = 42.5
study_room.breadth = 30.8

# access method inside class
study_room.calculate_area()


# Python Constructors
class Bike:

    # constructor function    
    def __init__(self, name = ""):
        self.name = name

bike1 = Bike()





# Python Inheritance
# Being an object-oriented language, Python supports class inheritance. It allows us to create a new class from an existing one.

# The newly created class is known as the subclass (child or derived class).
# The existing class from which the child class inherits is known as the superclass (parent or base class).

# Example: Python Inheritance

class Animal:

    # attribute and method of the parent class
    name = ""
    
    def eat(self):
        print("I can eat")

# inherit from Animal
class Dog(Animal):

    # new method in subclass
    def display(self):
        # access name attribute of superclass using self
        print("My name is ", self.name)

# create an object of the subclass
labrador = Dog()

# access superclass attribute and method 
labrador.name = "Rohu"
labrador.eat()

# call subclass method 
labrador.display()


# Method Overriding in Python Inheritance

# Example: Method Overriding
class Animal:

    # attributes and method of the parent class
    name = ""
    
    def eat(self):
        print("I can eat")

# inherit from Animal
class Dog(Animal):

    # override eat() method
    def eat(self):
        print("I like to eat bones")

# create an object of the subclass
labrador = Dog()

# call the eat() method on the labrador object
labrador.eat()


# The super() Function in Inheritance
# Previously we saw that the same method (function) in the subclass overrides the method in the superclass.

# However, if we need to access the superclass method from the subclass, we use the super() function. For example,

class Animal:

    name = ""
    
    def eat(self):
        print("I can eat")

# inherit from Animal
class Dog(Animal):
    
    # override eat() method
    def eat(self):
        
        # call the eat() method of the superclass using super()
        super().eat()
        
        print("I like to eat bones")

# create an object of the subclass
labrador = Dog()

labrador.eat()


# Python Multiple Inheritance
# A class can be derived from more than one superclass in Python. This is called multiple inheritance.

# For example, a class Bat is derived from superclasses Mammal and WingedAnimal. It makes sense because bat is a mammal as well as a winged animal.

# Example: Python Multiple Inheritance
class Mammal:
    def mammal_info(self):
        print("Mammals can give direct birth.")

class WingedAnimal:
    def winged_animal_info(self):
        print("Winged animals can flap.")

class Bat(Mammal, WingedAnimal):
    pass

# create an object of Bat class
b1 = Bat()

b1.mammal_info()
b1.winged_animal_info()


# Python Multilevel Inheritance
# In Python, not only can we derive a class from the superclass but you can also derive a class from the derived class. This form of inheritance is known as multilevel inheritance.


# Example: Python Multilevel Inheritance
class SuperClass:

    def super_method(self):
        print("Super Class method called")

# define class that derive from SuperClass
class DerivedClass1(SuperClass):
    def derived1_method(self):
        print("Derived class 1 method called")

# define class that derive from DerivedClass1
class DerivedClass2(DerivedClass1):

    def derived2_method(self):
        print("Derived class 2 method called")

# create an object of DerivedClass2
d2 = DerivedClass2()

d2.super_method()  # Output: "Super Class method called"

d2.derived1_method()  # Output: "Derived class 1 method called"

d2.derived2_method()  # Output: "Derived class 2 method called"


# Method Resolution Order (MRO) in Python

# If two superclasses have the same method (function) name and the derived class calls that method, Python uses the MRO to search for the right method to call. For example,

class SuperClass1:
    def info(self):
        print("Super Class 1 method called")

class SuperClass2:
    def info(self):
        print("Super Class 2 method called")

class Derived(SuperClass1, SuperClass2):
    pass

d1 = Derived()
d1.info()  

# Output: "Super Class 1 method called"


# Polymorphism in Python
# What is Polymorphism?
# The literal meaning of polymorphism is the condition of occurrence in different forms.

# Polymorphism is a very important concept in programming. It refers to the use of a single type entity (method, operator or object) to represent different types in different scenarios.

# Let's take an example:

num1 = 1
num2 = 2
print(num1+num2)

str1 = "Python"
str2 = "Programming"
print(str1+" "+str2)

print(len("Programiz"))
print(len(["Python", "Java", "C"]))
print(len({"Name": "John", "Address": "Nepal"}))


# Class Polymorphism in Python

# Example 3: Polymorphism in Class Methods
class Cat:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def info(self):
        print(f"I am a cat. My name is {self.name}. I am {self.age} years old.")

    def make_sound(self):
        print("Meow")


class Dog:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def info(self):
        print(f"I am a dog. My name is {self.name}. I am {self.age} years old.")

    def make_sound(self):
        print("Bark")


cat1 = Cat("Kitty", 2.5)
dog1 = Dog("Fluffy", 4)

for animal in (cat1, dog1):
    animal.make_sound()
    animal.info()
    animal.make_sound()


# Example 4: Method Overriding
from math import pi


class Shape:
    def __init__(self, name):
        self.name = name

    def area(self):
        pass

    def fact(self):
        return "I am a two-dimensional shape."

    def __str__(self):
        return self.name


class Square(Shape):
    def __init__(self, length):
        super().__init__("Square")
        self.length = length

    def area(self):
        return self.length**2

    def fact(self):
        return "Squares have each angle equal to 90 degrees."


class Circle(Shape):
    def __init__(self, radius):
        super().__init__("Circle")
        self.radius = radius

    def area(self):
        return pi*self.radius**2


a = Square(4)
b = Circle(7)
print(b)
print(b.fact())
print(a.fact())
print(b.area())


# Python Operator Overloading
# Python Special Functions
# In Python, methods that have two underscores, __, before and after their names have a special meaning. For example, __add__(), __len__() etc.

# These special methods can be used to implement certain features or behaviors.

# Let's use the __add__() method to add two numbers instead of using the + operator.

number1 = 5

# similar to number2 = number1 + 6
number2 = number1.__add__(6)
    
print(number2)  # 11


# Example: Add Two Coordinates (Without Overloading)

class Point:
    def __init__(self, x = 0, y = 0):
        self.x = x
        self.y = y
    
    def add_points(self, other):
        x = self.x + other.x
        y = self.y + other.y
        return Point(x, y)
    
    
p1 = Point(1, 2)
p2 = Point(2, 3)

p3 = p1.add_points(p2)

print((p3.x, p3.y))   # Output: (3, 5)


# Example: Add Two Coordinates (With Overloading)

class Point:
    def __init__(self, x = 0, y = 0):
        self.x = x
        self.y = y
    
    def __add__(self, other):
        x = self.x + other.x
        y = self.y + other.y
        return Point(x, y)
    
    
p1 = Point(1, 2)
p2 = Point(2, 3)

# this statment calls the __add__() method
p3 = p1 + p2

print((p3.x, p3.y))   # Output: (3, 5)



# Don't Misuse Operators
# In the above program, we could have easily used the + operator for subtraction like this:


def __add__(self, other):
    x = self.x - other.x
    y = self.y - other.y
    return Point(x, y)
