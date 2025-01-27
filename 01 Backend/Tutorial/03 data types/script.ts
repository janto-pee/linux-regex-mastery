// JavaScript Array
// An array is an object that can store multiple values at once.

const age = [17, 18, 15, 19, 14];

// Create an Array
// We can create an array by placing elements inside an array literal [], separated by commas. For example,

const numbers = [10, 30, 40, 60, 80];
// empty array
const emptyArray = [];

// array of strings
const dailyActivities = ["eat", "work", "sleep"];

// array with mixed data types
const mixedArray = ["work", 1, true];
// Note: Unlike many other programming languages, JavaScript allows us to create arrays with mixed data types.

// Access Elements of an Array

let numbers = [10, 30, 40, 60, 80];

// access first element
console.log(numbers[0]);  // 10

// access third element
console.log(numbers[2]);  // 40

let dailyActivities = ["eat", "sleep"];

// add an element at the end
dailyActivities.push("exercise");

console.log(dailyActivities);

// Output: [ 'eat', 'sleep', 'exercise' ]

let dailyActivities = ["eat", "sleep"];

// add an element at the beginning
dailyActivities.unshift("work"); 

console.log(dailyActivities);

// Output: [ 'work', 'eat', 'sleep' ]

// let dailyActivities = [ "eat", "work", "sleep"];

// change the second element
// use array index 1
dailyActivities[1] = "exercise";

console.log(dailyActivities);

// Output: [ 'eat', 'exercise', 'sleep' ]

// let numbers = [1, 2, 3, 4, 5];

// remove one element
// starting from index 2
numbers.splice(2, 1);

console.log(numbers);

// Output: [ 1, 2, 4, 5 ]
// In this example, we removed the element at index 2 (the third element) using the splice() method.
// concat()	Joins two or more arrays and returns a result.
// toString()	Converts an array to a string of (comma-separated) array values.
// indexOf()	Searches an element of an array and returns its position (index).
// find()	Returns the first value of the array element that passes a given test.
// findIndex()	Returns the first index of the array element that passes a given test.
// forEach()	Calls a function for each element.
// includes()	Checks if an array contains a specified element.
// sort()	Sorts the elements alphabetically in strings and ascending order in numbers.
// slice()	Selects part of an array and returns it as a new array.
// splice()	Removes or replaces existing elements and/or adds new elements.


// multidimensional array
// contains 3 separate arrays as elements
const data = [[1, 2, 3], [1, 3, 4], [4, 5, 6]];

console.log(data);

// Output : [ [ 1, 2, 3 ], [ 1, 3, 4 ], [ 4, 5, 6 ] ]

// Use Existing Arrays as Elements
// declare three arrays
let student1 = ['Jack', 24];
let student2 = ['Sara', 23];
let student3 = ['Peter', 24];

// create multidimensional array
// using student1, student2, and student3
let studentsData = [student1, student2, student3];

// print the multidimensional array
console.log(studentsData);

// Output: [ [ 'Jack', 24 ], [ 'Sara', 23 ], [ 'Peter', 24 ] ]


let x = [
    ['Jack', 24],
    ['Sara', 23], 
    ['Peter', 24]
    ];
    
    // access the first item 
    console.log(x[0]);  // [ 'Jack', 24 ]
    
    // access the first item of the first inner array
    console.log(x[0][0]);  // Jack
    
    // access the second item of the third inner array
    console.log(x[2][1]);  // 24

    let studentsData = [["Jack", 24], ["Sara", 23]];

    // add "hello" as the 3rd element
    // of the 2nd inner array
    studentsData[1][2] = "hello";
    
    console.log(studentsData);
    
    // Output: [ [ 'Jack', 24 ], [ 'Sara', 23, 'hello' ] ]

    let studentsData = [["Jack", 24], ["Sara", 23]];

    // add element to the end of the outer array
    studentsData.push(["Peter", 24]);
    
    console.log(studentsData);
    
    // add "hello" as the final element
    // of the 2nd inner array
    studentsData[1].push("hello");
    
    console.log(studentsData);

    let studentsData = [['Jack', 24], ['Sara', 23],];

    // remove one element
    // starting from index 0
    studentsData.splice(0,1);
    
    console.log(studentsData);
    
    // Output: [ [ 'Sara', 23 ] ]


    // Iterate Over Multidimensional Array
    let studentsData = [["Jack", 24], ["Sara", 23]];

    // loop over outer array
    for(let i = 0; i < studentsData.length; i++) {
    
        // loop over inner array elements
        for(let j = 0; j < studentsData[i].length; j++) {
            console.log(studentsData[i][j]);
        }
    }



    // JavaScript String
    let name = "John"

// strings example
let name1 = 'Peter';
let name2 = "Jack";
let result = `The names are ${name1} and ${name2}`;

console.log(result);

// Output: The names are Peter and Jack

// Access String Characters

let message = "hello";

// use index 1 to access
// 2nd character of message
console.log(message[1]);  // e

// use charAt(1) to get the
// 2nd character of message
console.log(message.charAt(1));  // e
// 1. JavaScript Strings are Immutable


// charAt()	Returns the character at the specified index.
// concat()	Joins two or more strings.
// replace()	Replace a string with another string.
// split()	Converts the string to an array of strings.
// substr()	Returns a part of a string by taking the starting position and length of the substring.
// substring()	Returns a part of the string from the specified start index (inclusive) to the end index (exclusive).
// slice()	Returns a part of the string from the specified start index (inclusive) to the end index (exclusive).
// toLowerCase()	Returns the passed string in lowercase.
// toUpperCase()	Returns the passed string in uppercase.
// trim()	Removes whitespace from the strings.
// includes()	Searches for a string and returns a boolean value.
// search()	Searches for a string and returns the position of a match.


let text1 = "hello";
let text2 = "world";
let text3 = "     JavaScript    ";

// concatenate two strings
let result1 = text1.concat(' ', text2);
console.log(result1);  // hello world

// convert the text to uppercase
let result2 = text1.toUpperCase();
console.log(result2);  // HELLO

// remove whitespace from the string
let result3 = text3.trim();
console.log(result3);  // JavaScript

// convert the string to an array
let result4 = text1.split();
console.log(result4);  // [ 'hello' ]

// slice the string
let result5= text1.slice(1, 3);
console.log(result5);  // el

// JavaScript for...in loop
// The JavaScript for...in loop iterates over the keys of an object

const salaries = {
    Jack: 24000,
    Paul: 34000,
    Monica: 55000
};

// use for...in to loop through
// properties of salaries
for (let i in salaries) {

    // access object key using [ ]
    // add a $ symbol before the key
    let salary = "$" + salaries[i];

    // display the values
    console.log(`${i}: ${salary}`);
};



Example: JavaScript Number Methods
// check if num1 is integer
let num1 = 12;
console.log(Number.isInteger(num1)); // true

// check if num2 is NaN
let num2 = NaN;
console.log(Number.isNaN(num2)); // true

// display up to two decimal points
let num3 = 5.1234;
console.log(num3.toFixed(2)); // 5.12

let num = 4 - "hello";
console.log(num); // NaN

// isNaN()	Determines whether the passed value is NaN.
// isFinite()	Determines whether the passed value is a finite number.
// isInteger()	Determines whether the passed value is an integer.
// isSafeInteger()	Determines whether the passed value is a safe integer.
// parseFloat()	Converts the numeric floating string to a floating-point number.
// parseInt()	Converts the numeric string to an integer.
// toExponential()	Returns a string value for a number in exponential notation.
// toFixed()	Returns a string value for a number in fixed-point notation.
// toPrecision()	Returns a string value for a number to a specified precision.
// toString()	Returns a string value in a specified radix (base).
// valueOf()	Returns the number's value.
// toLocaleString()	Returns a string with a language-sensitive representation of a number.








































