// JavaScript try...catch...finally Statement
// Types of Errors
// In programming, there can be two types of errors in the code:

// Syntax Error: Error in the syntax. For example, if you write consol.log('your result');, the above program throws a syntax error. The spelling of console is a mistake in the above code.

// Runtime Error: This type of error occurs during the execution of the program. For example,
// calling an invalid function or a variable.


// These errors that occur during runtime are called exceptions. Now, let's see how you can handle these exceptions.


const numerator= 100, denominator = 'a';

try {
     console.log(numerator/denominator);
     console.log(a);
}
catch(error) {
    console.log('An error caught'); 
    console.log('Error message: ' + error);  
}
finally {
     console.log('Finally will execute every time');
}
// Output

// NaN
// An error caught
// Error message: ReferenceError: a is not defined
// Finally will execute every time



// you can use the throw statement to pass user-defined exceptions.

const number = 40;
try {
    if(number > 50) {
        console.log('Success');
    }
    else {

        // user-defined throw statement
        throw new Error('The number is low');
    }

    // if throw executes, the below code does not execute
    console.log('hello');
}
catch(error) {
    console.log('An error caught'); 
    console.log('Error message: ' + error);  
}



// Rethrow an Exception
// You can also use throw statement inside the catch block to rethrow an exception. For example,

const number = 5;
try {
     // user-defined throw statement
     throw new Error('This is the throw');

}
catch(error) {
    console.log('An error caught');
    if( number + 8 > 10) {

        // statements to handle exceptions
         console.log('Error message: ' + error); 
        console.log('Error resolved');
    }
    else {
        // cannot handle the exception
        // rethrow the exception
        throw new Error('The value is low');
    }
}


// JavaScript Modules
// importing greetPerson from greet.js file
import { greetPerson } from './greet.js';

// using greetPerson() defined in greet.js
let displayName = greetPerson('Jack');

console.log(displayName); // Hello Jack


// module.js// exporting the variable
export const name = 'JavaScript Program';

// exporting the function
export function sum(x, y) {
    return x + y;
}

// In main file,

import { name, sum } from './module.js';

console.log(name);
let add = sum(4, 9);
console.log(add); // 13


1. Rename in the module (export file)
// renaming import inside module.js
export {
    function1 as newName1,
    function2 as newName2
};

// when you want to use the module
// import in the main file
import { newName1, newName2 } from './module.js';


// 2. Rename in the import file
// inside module.js
export {
    function1,
    function2
};

// when you want to use the module
// import in the required file with different name

import { function1 as newName1, function2 as newName2 } from './module.js';


// Default Export
// You can also perform default export of the module. For example,

// In the file greet.js:

// default export
export default function greet(name) {
    return `Hello ${name}`;
}

export const age = 23;






