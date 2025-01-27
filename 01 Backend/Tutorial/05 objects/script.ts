// JavaScript Objects
// JavaScript object is a variable that can store multiple data in key-value pairs.

// create person object
const person = {
    name: "John",
    age: 20
};

console.log(person);

// Output: { name: "John", age: 20 }
// const person = { name: "John", age: 20 };

const dog = {
    name: "Rocky",
};
// access property
console.log(dog.name);

// Output: Rocky

const cat = {
    name: "Luna",
};

// access property
console.log(cat["name"]);

// Output: Luna

const person = {
    name: "Bobby",
    hobby: "Dancing",
};

// modify property
person.hobby = "Singing";

// display the object
console.log(person);

// Output: { name: 'Bobby', hobby: 'Singing' }

const student = {
    name: "John",
    age: 20,
};

// add properties
student.rollNo = 14;
student.faculty = "Science";

// display the object
console.log(student);

// Output: { name: 'John', age: 20, rollNo: 14, faculty: 'Science' }

const employee = {
    name: "Tony",
    position: "Officer",
    salary: 30000,
};

// delete object property
delete employee.salary

// display the object
console.log(employee);

// Output: { name: 'Tony', position: 'Officer' }

// JavaScript Object Methods
const person = {
    name: "Bob",
    age: 30,

    // use function as value
    greet: function () {
        console.log("Bob says Hi!");
    }
};

// call object method
person.greet();  // Bob says Hi!


// JavaScript Methods and this Keyword

// dog object
const dog = {
    name: "Rocky",

    // bark method
    bark: function () {
        console.log("Woof!");
    }
};

// access method
dog.bark();

// Output: Woof!

// JavaScript this Keyword
// person object
const person = {
    name: "John",
    age: 30,

    // method
    introduce: function () {
        console.log(`My name is ${this.name} and I'm ${this.age} years old.`);
    }
};

// access the introduce() method
person.introduce();

// Output: My name is John and I'm 30 years old.

// Add Methods to an Object
// student object
let student = {
    name: "John"
};

// add new method
student.greet = function () {
    console.log("Hello");
};

// access greet() method
student.greet();

// Output: Hello

// Add Methods to an Object
// console.log()	Console	Displays messages or variables in the browser's console.
// prompt()	Window	Displays a dialog box that prompts the user for input.
// concat()	String	Concatenates the arguments to the calling string.
// toFixed()	Number	Rounds off a number into a fixed number of digits.
// sort()	Array	Sorts the elements of an array in specific order.
// random()	Math	Returns a pseudo-random float number between 0 and 1.


// JavaScript Constructor Function

// constructor function with parameters
function Person (person_name, person_age, person_gender) {

    // assign parameter values to the calling object
     this.name = person_name,
     this.age = person_age,
     this.gender = person_gender,
 
     this.greet = function () {
         return (`Hi ${this.name}`);
     }
 }
 
 // create objects and pass arguments
 const person1 = new Person("John", 23, "male");
 const person2 = new Person("Sam", 25, "female");
 
 // access properties
 console.log(person1.name); // John
 console.log(person2.name); // Sam


 Example: JavaScript Built-In Constructors
// use Object() constructor to create object
const person = new Object({ name: "John", age: 30 });

// use String() constructor to create string object
const name = new String ("John");

// use Number() constructor to create number object
const number = new Number (57);

// use Boolean() constructor to create boolean object
const count = new Boolean(true);

console.log(person);
console.log(name);
console.log(number);
console.log(count);




// JavaScript Getter and Setter
// JavaScript Getter
const student = {

    // data property
    firstName: 'Monica',
    
    // accessor property(getter)
    get getName() {
        return this.firstName;
    }
};

// accessing data property
console.log(student.firstName); // Monica

// accessing getter methods
console.log(student.getName); // Monica

// trying to access as a method
console.log(student.getName()); // error



const student = {
    firstName: 'Monica',
    
    //accessor property(setter)
    set changeName(newName) {
        this.firstName = newName;
    }
};

console.log(student.firstName); // Monica

// change(set) object property using a setter
student.changeName = 'Sarah';

console.log(student.firstName); // Sarah


JavaScript Object.defineProperty()
In JavaScript, you can also use Object.defineProperty() method to add getters and setters. For example,

const student = {
    firstName: 'Monica'
}

// getting property
Object.defineProperty(student, "getName", {
    get : function () {
        return this.firstName;
    }
});

// setting property
Object.defineProperty(student, "changeName", {
    set : function (value) {
        this.firstName = value;
    }
});

console.log(student.firstName); // Monica

// changing the property value
student.changeName = 'Sarah';

console.log(student.firstName); // Sarah


// JavaScript Prototype
// In JavaScript, prototypes allow properties and methods to be shared among instances of the function or object. For example,
function Car() {
    console.log("Car instance created!");
};

// add a property to prototype
Car.prototype.color = "Red";

// add a method to the prototype
Car.prototype.drive = function () {
    console.log(`Driving the car painted in ${this.color}...`);
};

// display the added property
console.log(`The car's color is: ${Car.prototype.color}`);

// call the added method
Car.prototype.drive();

function Car(model, year) {
    this.model = model;
    this.year = year;
};

// create multiple objects
let c1 = new Car("Mustang", 1964);
let c2 = new Car("Corolla", 1966);

// add property
Car.prototype.color = "Red";

// add method
Car.prototype.drive = function() {
    console.log(`Driving ${this.model}`);
};

// display added property using c1 and c2 objects
console.log(`${c1.model} color: ${c1.color}`);  
console.log(`${c2.model} color: ${c2.color}`);  

// display added method using c1 and c2 objects
c1.drive();
c2.drive();


// JavaScript Prototype Chaining
// JavaScript always searches for properties in the objects of the constructor function first. Then, it searches in the prototype.

// This process is known as prototype chaining. For example,

function Car() {
    this.color = "Red";
};

// add property that already exists
Car.prototype.color = "Blue";

// add a new property
Car.prototype.wheels = 4;

const c1 = new Car();

console.log(`The car's color is ${c1.color}.`); 
console.log(`The car has ${c1.wheels} wheels.`);










