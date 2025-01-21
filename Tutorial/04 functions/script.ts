// function to find square of a number
function findSquare(num) {

    // return square
    return num * num; 
}

// call the function and store the result
let square = findSquare(3);

console.log(`Square: ${square}`);

// JavaScript Library Functions
// JavaScript provides some built-in functions that can be directly used in our program. We don't need to create these functions; we just need to call them.

// Some common JavaScript library functions are:

// Library Function	Description
// console.log()	Prints the string inside the quotation marks.
// Math.sqrt()	Returns the square root of a number.
// Math.pow()	Returns the power of a number.
// toUpperCase()	Returns the string converted to uppercase.
// toLowerCase()	Returns the string converted to lowercase.

// Math.sqrt() computes the square root
let squareRoot = Math.sqrt(4);
console.log("Square Root of 4 is", squareRoot);

// Math.pow() computes the power
let power = Math.pow(2, 3);
console.log("2 to the power of 3 is", power);

// toUpperCase() converts text to uppercase
let band = "Iron Maiden";
let bandUpper = band.toUpperCase();
console.log(`Favorite Band: ${bandUpper}`);


// Function Expressions
// store a function in the square variable
let square = function(num) {
    return num * num;
};

console.log(square(5));  

// Output: 25


// Also Read:

// JavaScript Default Parameters
// JavaScript Arrow Function
// JavaScript CallBack Function


// Variables can be declared in different scopes:

// Global Scope
// Local (Function) Scope
// Block-Level Scope


// declare global variable
var message = "Hello";
function display_scopes() {
    // declare variable in local scope
    let message = "local";

    if (true) {

        // declare block-level variable
        let message = "block-level";

        console.log(`inner scope: ${message}`);
    }

    console.log(`outer scope: ${message}`);
}

display_scopes();


// JavaScript Hoisting
// In JavaScript, hoisting is a behavior in which a function or a variable can be used before declaration.

// use test variable before declaring
console.log(test);

// declare and initialize test variable
var test = 5;

// Output: undefined


// JavaScript Recursion
// Recursion is a programming technique where a function calls itself repeatedly to solve a problem. For example,

// Program to countdown till 1

// recursive function
function counter(count) {

    // display count
    console.log(count);

    // condition for stopping
    if(count > 1) {

        // decrease count
        count = count - 1;

        // call counter with new value of count
        counter(count);
    } else {

        // terminate execution
        return;
    };
};

// access function
counter(5);

// recursive function
function factorial(num) {

    // base case
    // recurse only if num is greater than 0
    if (num > 1) {
        return num * factorial(num - 1);
    }
    else {
        return 1;
    };
};

let x = 3;

// store result of factorial() in variable
let y = factorial(x);

console.log(`The factorial of ${x} is ${y}`);

