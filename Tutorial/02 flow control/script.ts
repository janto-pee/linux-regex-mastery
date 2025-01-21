// JavaScript Comparison and Logical Operators

// Nested if...else Statement
let marks = 60;

// outer if...else statement
// student passed if marks 40 or above
// otherwise, student failed

if (marks >= 40) {

    // inner if...else statement
    // Distinction if marks is 80 or above

    if (marks >= 80) {
        console.log("Distinction");
    }
    else {
        console.log("Passed");
    }
}

else {
    console.log("Failed");
}

// Output: Passed





// Example 2: Display Sum of n Natural Numbers
// program to display the sum of natural numbers

let sum = 0;
const n = 100

// loop from i = 1 to i = n
// in each iteration, i is increased by 1
for (let i = 1; i <= n; i++) {
    sum += i;  // sum = sum + i
}

console.log(`sum: ${sum}`);

// Output: sum: 5050





// Example 2: JavaScript break With while Loop
We can terminate a while loop using the break statement. For example,

// Program to find the sum of positive numbers
// the while loop runs infinitely
// loop terminates only when user enters a negative number

let sum = 0;

// infinite loop
while (true) {

    // get number input
    let num = Number(prompt("Enter a number: "));

    // terminate the loop if num is negative
    if (num < 0)
        break;
    }

    // otherwise, add num to sum
    else {
        sum += num;
    }
}

// print the sum
console.log(`Sum: ${sum}`);



// Example 4: Sum of Positive Numbers
let sum = 0, num = 0;

do {

    // add all positive numbers
    sum += num;

    // take input from the user
    num = parseInt(prompt("Enter a number: "));

    // loop terminates if num is negative
} while (num >= 0);

// last, display sum
console.log(`The sum is ${sum}`);




// JavaScript continue Statement
// display odd numbers

for (let i = 1; i <= 5; i++) {
    // skip the iteration if i is even
    if (i % 2 === 0) {
        continue;
    }
    console.log(i);
}

// Output:
// 1
// 3
// 5


// Example 2: JavaScript continue With while Loop
var num = 1;

while (num <= 10) {

    // skip iteration if num is even
    if (num % 2 === 0) {
        ++num;
        continue;
    }

    console.log(num);
    ++num;
}


// JavaScript switch...case Statement

// take user input for two numbers
let number1 = Number(prompt("Enter the value of number1: "));
let number2 = Number(prompt("Enter the value of number2: "));

// take user input to select an operator 
const operator = prompt("Enter a operator ( either +, -, * or / ): ");

switch(operator) {

    case "+":
        result = number1 + number2;
        console.log(`${number1} + ${number2} = ${result}`);
        break;

    case "-":
        result = number1 - number2;
        console.log(`${number1} - ${number2} = ${result}`);
        break;

    case "*":
        result = number1 * number2;
        console.log(`${number1} * ${number2} = ${result}`);
        break;

    case "/":
        result = number1 / number2;
        console.log(`${number1} / ${number2} = ${result}`);
        break;

    default:
        console.log("Invalid operator");
}




































































































































































































