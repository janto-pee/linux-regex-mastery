# Python Directory and Files Management
# A directory is a collection of files and subdirectories. A directory inside a directory is known as a subdirectory.

# Python has the os module that provides us with many useful methods to work with directories (and files as well).

# Get Current Directory in Python
# We can get the present working directory using the getcwd() method of the os module.

# This method returns the current working directory in the form of a string. For example,

import os

print(os.getcwd())

# Output: C:\Program Files\PyScripter


# Changing Directory in Python
# In Python, we can change the current working directory by using the chdir() method.
import os

# change directory
os.chdir('C:\\Python33')

print(os.getcwd())

# Output: C:\Python33


# List Directories and Files in Python
# All files and sub-directories inside a directory can be retrieved using the listdir() method.

os.listdir()
os.listdir('G:\\')

# Making a New Directory in Python
os.mkdir('test')

os.listdir()
['test']


# Renaming a Directory or a File
import os

os.listdir()
['test']

# rename a directory
os.rename('test','new_one')

os.listdir()
['new_one']


# Removing Directory or File in Python
import os

# delete "myfile.txt" file
os.remove("myfile.txt")

# Now let's use rmdir() to delete an empty directory,

import os

# delete the empty directory "mydir"
os.rmdir("mydir") 


# In order to remove a non-empty directory, we can use the rmtree() method inside the shutil module. For example,

import shutil

# delete "mydir" directory and all of its contents
shutil.rmtree("mydir")


# Python CSV: Read and Write CSV Files
# The CSV (Comma Separated Values) format is a common and straightforward way to store tabular data. To represent a CSV file, it should have the .csv file extension.
import csv

with open('people.csv', 'r') as file:
    reader = csv.reader(file)

    for row in reader:
        print(row)


# Write to CSV Files with Python

import csv
with open('protagonist.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(["SN", "Movie", "Protagonist"])
    writer.writerow([1, "Lord of the Rings", "Frodo Baggins"])
    writer.writerow([2, "Harry Potter", "Harry Potter"])


# Read CSV Files
# To read the CSV file using pandas, we can use the read_csv() function.

import pandas as pd
pd.read_csv("people.csv")

# Write to a CSV Files
import pandas as pd

# creating a data frame
df = pd.DataFrame([['Jack', 24], ['Rose', 22]], columns = ['Name', 'Age'])

# writing data frame to a CSV file
df.to_csv('person.csv')


We can read the contents of the file with the following program:

import csv
with open('innovators.csv', 'r') as file:
    reader = csv.reader(file)
    for row in reader:
        print(row)

Example 2: Read CSV file Having Tab Delimiter
import csv
with open('innovators.csv', 'r') as file:
    reader = csv.reader(file, delimiter = '\t')
    for row in reader:
        print(row)


Example 3: Read CSV files with initial spaces
We can read the CSV file as follows:

import csv
with open('people.csv', 'r') as csvfile:
    reader = csv.reader(csvfile, skipinitialspace=True)
    for row in reader:
        print(row)


# Example 4: Read CSV files with quotes
import csv
with open('person1.csv', 'r') as file:
    reader = csv.reader(file, quoting=csv.QUOTE_ALL, skipinitialspace=True)
    for row in reader:
        print(row)



# Example 5: Read CSV files using dialect
import csv
csv.register_dialect('myDialect',
                     delimiter='|',
                     skipinitialspace=True,
                     quoting=csv.QUOTE_ALL)

with open('office.csv', 'r') as csvfile:
    reader = csv.reader(csvfile, dialect='myDialect')
    for row in reader:
        print(row)


# Example 6: Python csv.DictReader()
import csv
with open("people.csv", 'r') as file:
    csv_file = csv.DictReader(file)
    for row in csv_file:
        print(dict(row))


# Using csv.Sniffer class
# Example 7: Using csv.Sniffer() to deduce the dialect of CSV files

import csv
with open('office.csv', 'r') as csvfile:
    sample = csvfile.read(64)
    has_header = csv.Sniffer().has_header(sample)
    print(has_header)

    deduced_dialect = csv.Sniffer().sniff(sample)

with open('office.csv', 'r') as csvfile:
    reader = csv.reader(csvfile, deduced_dialect)

    for row in reader:
        print(row)


# Writing CSV files in Python
# Basic Usage of csv.writer()

# Example 1: Write into CSV files with csv.writer()
# Suppose we want to write a CSV file with the following entries:

# SN,Name,Contribution
# 1,Linus Torvalds,Linux Kernel
# 2,Tim Berners-Lee,World Wide Web
# 3,Guido van Rossum,Python Programming
# Here's how we do it.

import csv
with open('innovators.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(["SN", "Name", "Contribution"])
    writer.writerow([1, "Linus Torvalds", "Linux Kernel"])
    writer.writerow([2, "Tim Berners-Lee", "World Wide Web"])
    writer.writerow([3, "Guido van Rossum", "Python Programming"])


# Example 2: Writing Multiple Rows with writerows()
# If we need to write the contents of the 2-dimensional list to a CSV file, here's how we can do it.

import csv
row_list = [["SN", "Name", "Contribution"],
             [1, "Linus Torvalds", "Linux Kernel"],
             [2, "Tim Berners-Lee", "World Wide Web"],
             [3, "Guido van Rossum", "Python Programming"]]
with open('protagonist.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerows(row_list)


# Example 3: Write CSV File Having Pipe Delimiter

import csv
data_list = [["SN", "Name", "Contribution"],
             [1, "Linus Torvalds", "Linux Kernel"],
             [2, "Tim Berners-Lee", "World Wide Web"],
             [3, "Guido van Rossum", "Python Programming"]]
with open('innovators.csv', 'w', newline='') as file:
    writer = csv.writer(file, delimiter='|')
    writer.writerows(data_list)


# Example 4: Write CSV files with quotes
import csv
row_list = [
    ["SN", "Name", "Quotes"],
    [1, "Buddha", "What we think we become"],
    [2, "Mark Twain", "Never regret anything that made you smile"],
    [3, "Oscar Wilde", "Be yourself everyone else is already taken"]
]
with open('quotes.csv', 'w', newline='') as file:
    writer = csv.writer(file, quoting=csv.QUOTE_NONNUMERIC, delimiter=';')
    writer.writerows(row_list)


# Example 5: Writing CSV files with custom quoting character
import csv
row_list = [
    ["SN", "Name", "Quotes"],
    [1, "Buddha", "What we think we become"],
    [2, "Mark Twain", "Never regret anything that made you smile"],
    [3, "Oscar Wilde", "Be yourself everyone else is already taken"]
]
with open('quotes.csv', 'w', newline='') as file:
    writer = csv.writer(file, quoting=csv.QUOTE_NONNUMERIC,
                        delimiter=';', quotechar='*')
    writer.writerows(row_list)


# Dialects in CSV module
# Dialect helps in grouping together many specific formatting patterns like delimiter, skipinitialspace, quoting, escapechar into a single dialect name.

# It can then be passed as a parameter to multiple writer or reader instances.

# Example 6: Write CSV file using dialect
import csv
row_list = [
    ["ID", "Name", "Email"],
    ["A878", "Alfonso K. Hamby", "alfonsokhamby@rhyta.com"],
    ["F854", "Susanne Briard", "susannebriard@armyspy.com"],
    ["E833", "Katja Mauer", "kmauer@jadoop.com"]
]
csv.register_dialect('myDialect',
                     delimiter='|',
                     quoting=csv.QUOTE_ALL)
with open('office.csv', 'w', newline='') as file:
    writer = csv.writer(file, dialect='myDialect')
    writer.writerows(row_list)


# Example 7: Python csv.DictWriter()
# The objects of csv.DictWriter() class can be used to write to a CSV file from a Python dictionary.

import csv

with open('players.csv', 'w', newline='') as file:
    fieldnames = ['player_name', 'fide_rating']
    writer = csv.DictWriter(file, fieldnames=fieldnames)

    writer.writeheader()
    writer.writerow({'player_name': 'Magnus Carlsen', 'fide_rating': 2870})
    writer.writerow({'player_name': 'Fabiano Caruana', 'fide_rating': 2822})
    writer.writerow({'player_name': 'Ding Liren', 'fide_rating': 2801})


# CSV files with lineterminator
# Example 8: Using escapechar in csv writer

import csv
row_list = [
    ['Book', 'Quote'],
    ['Lord of the Rings',
        '"All we have to decide is what to do with the time that is given us."'],
    ['Harry Potter', '"It matters not what someone is born, but what they grow to be."']
]
with open('book.csv', 'w', newline='') as file:
    writer = csv.writer(file, escapechar='/', quoting=csv.QUOTE_NONE)
    writer.writerows(row_list)




