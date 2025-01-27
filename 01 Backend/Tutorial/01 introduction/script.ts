// JavaScript Variables and Constants
// Initialize Variables in JavaScript

// declare variable num
let num;

// assign 5 to num
num = 5;

// declare variable num1 and assign 5 to it
let num1 = 5;



// Change the Value of Variables


// assign 5 to variable score
let score = 5; 
console.log(score); // 5

// change the value of score to 3
score = 3; 
console.log(score); // 3

// Variables cannot start with numbers. For example,

// JavaScript Constants
// A constant is a type of variable whose value cannot be changed.
// assign 5 to num
/*
const num = 5;

// assign 10 to num
num = 10;  
console.log(num) // Error! constant cannot be changed
*/


// JavaScript console.log()

let message = "Hello, JavaScript!";
console.log(message);

// Output: Hello, JavaScript!

// JavaScript Type Conversion

// Implicit Conversion - Automatic type conversion.
// Explicit Conversion - Manual type conversion

// numeric string used with + gives string type
let result;

// convert number to string
result = "3" + 2; 
console.log(result, "-", typeof(result));

result = "3" + true; 
console.log(result, "-", typeof(result));

result = "3" + null; 
console.log(result, "-", typeof(result));

// JavaScript Explicit Conversion

// convert string to number
result = Number("5");
console.log(result, "-", typeof(result));

// convert boolean to string
result = String(true);
console.log(result, "-", typeof(result));

// convert number to boolean
result = Boolean(0);
console.log(result, "-", typeof(result));


// JavaScript Operator Types
// Here is a list of different JavaScript operators you will learn in this tutorial:

// Arithmetic Operators
// Assignment Operators
// Comparison Operators
// Logical Operators
// Bitwise Operators
// String Operators
// Miscellaneous Operators



// Example 1: Arithmetic Operators in JavaScript

let x = 5;

// addition operator
console.log("Addition: x + 3 = ", x + 3);

// subtraction operator
console.log("Subtraction: x - 3 =", x - 3);

// multiplication operator
console.log("Multiplication: x * 3 =", x * 3);

// division operator
console.log("Division: x / 3 =", x / 3);

// remainder operator
console.log("Remainder: x % 3 =", x % 3);

// increment operator
console.log("Increment: ++x =", ++x);

// decrement operator
console.log("Decrement: --x =", --x);

// exponentiation operator
console.log("Exponentiation: x ** 3 =", x ** 3);

// 2. JavaScript Assignment Operators


// Example 2: Assignment Operators in JavaScript
// assignment operator
let a = 7;
console.log("Assignment: a = 7, a =", a);

// addition assignment operator
a += 5;  // a = a + 5
console.log("Addition Assignment: a += 5, a =", a);

// subtraction assignment operator
a -= 5;  // a = a - 5
console.log("Subtraction Assignment: a -= 5, a =", a);

// multiplication assignment operator
a *= 2;  // a = a * 2
console.log("Multiplication Assignment: a *= 2, a =", a);

// division assignment operator
a /= 2;  // a = a / 2
console.log("Division Assignment: a /= 2, a =", a);

// remainder assignment operator
a %= 2;  // a = a % 2
console.log("Remainder Assignment: a %= 2, a =", a);

// exponentiation assignment operator
a **= 2;  // a = a**2
console.log("Exponentiation Assignment: a **= 7, a =", a);


// 3. JavaScript Comparison Operators
/*
const a = 3, b = 2;
console.log(a > b);
*/
// Output: true 
// ==	Equal to	3 == 5 gives us false
// !=	Not equal to	3 != 4 gives us true
// >	Greater than	4 > 4 gives us false
// <	Less than	3 < 3 gives us false
// >=	Greater than or equal to	4 >= 4 gives us true
// <=	Less than or equal to	3 <= 3 gives us true
// ===	Strictly equal to	3 === "3" gives us false
// !==	Strictly not equal to	3 !== "3" gives us true
// equal to operator

// Example 3: Comparison Operators in JavaScript
console.log("Equal to: 2 == 2 is", 2 == 2);

// not equal operator
console.log("Not equal to: 3 != 3 is", 3 != 3);
/*
// strictly equal to operator
console.log("Strictly equal to: 2 === '2' is", 2 === '2');

// strictly not equal to operator
console.log("Strictly not equal to: 2 !== '2' is", 2 !== '2');
*/

// greater than operator
console.log("Greater than: 3 > 3 is", 3 > 3);

// less than operator
console.log("Less than: 2 > 2 is", 2 > 2);

// greater than or equal to operator
console.log("Greater than or equal to: 3 >= 3 is", 3 >= 3);

// less than or equal to operator
console.log("Less than or equal to: 2 <= 2 is", 2 <= 2);

// Example 4: Logical Operators in JavaScript
let xy = 3;

// logical AND
console.log((xy < 5) && (xy > 0));  // true
console.log((xy < 5) && (xy > 6));  // false

// logical OR
console.log((xy > 2) || (xy > 5));  // true
console.log((xy > 3) || (xy < 0));  // false

// logical NOT
console.log(!(xy == 3));  // false
console.log(!(xy < 2));  // true


// NOT on true
console.log(!true);  // false

// NOT on false
console.log(!false);  // true

// comparison example
console.log(!(2 < 3));  // false











