// tmplate literals

const firstName = "Jack";
const lastName = "Sparrow";

console.log("Hello " + firstName + " " + lastName);

// Output: Hello Jack Sparrow

Now, you can simply do this:

const firstName = "Jack";
const lastName = "Sparrow";

console.log(`Hello ${firstName} ${lastName}`);

// Output: Hello Jack Sparrow




Default Parameter Values
In ES6, you can pass default values for function parameters. For example,

// function to find sum of two numbers
function sum(numA, numB = 5) {

    // default value of numB is 5
    console.log(numA + numB);
};

// pass 10 to numA but
// don't pass value to numB
// numB takes default value 5
sum(10);  // 15

// pass 5 to numA and 15 to numB 
sum(5, 15);  // 20


// JavaScript Arrow Function
// function expression
let product = function(x, y) {
    return x * y;
 };
 
 result = product(5, 10);
 
 console.log(result);  // 50


// function expression using arrow function
let product = (x, y) => x * y;

result = product(5, 10);

console.log(result);  // 50




// constructor function
function Person(name) {
    this.name = name;
};

// create objects
var p1 = new Person("John");
var p2 = new Person("Rachel");

// print object properties
console.log(p1.name);  // John
console.log(p2.name);  // Rachel



// JavaScript Classes
// constructor function
function Person(name) {
    this.name = name;
};

// create objects
var p1 = new Person("John");
var p2 = new Person("Rachel");

// print object properties
console.log(p1.name);  // John
console.log(p2.name);  // Rachel


// declare a class
class Person {

    // constructor function
    constructor(name) {
        this.name = name;
    };
};

// create objects
let p1 = new Person("John");
let p2 = new Person("Rachel");

// print object properties
console.log(p1.name);  // John
console.log(p2.name);  // Rachel


// JavaScript Destructuring
// object of hospital
const hospital = {
    doctors: 23,
    patients: 44,
};

// assign individual values
let doctors = hospital.doctors;
let patients = hospital.patients;

console.log(doctors);  // 23
console.log(patients);  // 44

const hospital = {
    doctors: 23,
    patients: 44,
};

// use ES6 destructuring syntax
let { doctors, patients } = hospital;

console.log(doctors);  // 23
console.log(patients);  // 44


// JavaScript Promise
// define a promise
let countValue = new Promise(function (resolve, reject) {
    setTimeout(function () {
        resolve("Promise resolved!");
    }, 5000);
});

// executes when promise resolves
countValue.then(function successValue(result) {
    console.log(result);
});

// Output: Promise resolved!

// JavaScript Rest Parameter
// You can use the rest parameter ... to represent an infinite number of arguments as an array. For example,

// function with ...args rest parameter
function show(a, b, ...args) {
    console.log("a:", a);
    console.log("b:", b);
    console.log("args:", args);
}

// call function with extra parameters
show(1, 2, 3, 4, 5);


// Spread Operator
// You can use the spread operator ... to unpack an array or object. For example,

let numArr = [1, 2, 3];

// without spread operator
console.log([numArr, 4, 5]);  // [[1, 2, 3], 4, 5]

// with spread operator
console.log([...numArr, 4, 5]);  // [1, 2, 3, 4, 5]



