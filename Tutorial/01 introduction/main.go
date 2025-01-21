// Go Variables
package main
import "fmt"

func main() {
 
  // explicitly declare the data type
  var number1 int = 10
  fmt.Println(number1)

 // assign a value without declaring the data type
  var number2 = 20
  fmt.Println(number2)

  // shorthand notation to define variable
  number3 := 30
  fmt.Println(number3)  


	//   Changing Value of a Variable

	// initial value
	number := 10
	fmt.Println("Initial number value", number) // prints 10

	// change variable value
	number = 100
	fmt.Println("The changed value", number)  // prints 100


	// Creating Multiple Variables at Once
	var name, age = "Palistha", 22

	// The same code above can also be written as:

	name, age := "Palistha", 22

// 	Constant in Go
// Constants are the fixed values that cannot be changed once declared

const lightSpeed = 299792458 // initial value

// Error! Constants cannot be changed
lightSpeed = 299792460



// Go Print Statement
// fmt.Print()
// fmt.Println()
// fmt.Printf()

	fmt.Print("Hello, ")
  fmt.Print("World!")
//   Hello World!

name := "John" 
fmt.Print("Name: ", name)
// Name: John

currentSalary := 50000

  fmt.Println("Hello")
  fmt.Println("World!")
  fmt.Println("Current Salary:", currentSalary)

//   Hello
//   World!
//   Current Salary: 50000


// integer	%d
// float	%g
// string	%s
// bool	%t
currentAge := 21
fmt.Printf("Age = %d", currentAge)
// Annual Salary:  65000.5

var name = "John"
  age := 23

  fmt.Printf("%s is %d years old.", name, age)
//   John is 23 years old.

// Printing Without Package
println("Using println instead of fmt.Println")
print("Using print instead of fmt.Print")


// Go Take Input scan()
// fmt.Scan()
// fmt.Scanln()
// fmt.Scanf()

// takes input value for name
fmt.Print("Enter your name: ")
fmt.Scan(&name)
// Enter your name: Rosie
// Name: Rosie

 // take name and age input
 fmt.Println("Enter your name and age:")
 fmt.Scan(&name, &age)
   
 // print input values
 fmt.Printf("Name: %s\nAge: %d", name, age)
//  Enter your name and age:
//  Maria
//  27
//  Name: Maria
//  Age: 27

// Go fmt.Scanln()
// We use the Scanln() function to get input values up to the new line
fmt.Scanln(&name, &age)

// Go fmt.Scanf()
// take name and age input using format specifier
fmt.Println("Enter your name and age:")
fmt.Scanf("%s %d", &name, &age) 

fmt.Printf("Name: %s\nAge: %d", name, age)

var temperature float32
  var sunny bool

  // take float input
  fmt.Println("Enter the current temperature:")
  fmt.Scanf("%g", &temperature)

  // take boolean input
  fmt.Println("Is the day sunny?")
  fmt.Scanf("%t", &sunny)

  fmt.Printf("Current temperature: %g\nIs the day Sunny? %t", temperature, sunny)


 /* multi line comment
  */
//   Go Operators
//   major categories:

//   Arithmetic operators
//   Assignment operator
//   Relational operators
//   Logical operators

// Example 1: Addition, Subtraction and Multiplication Operators


  num1 := 6
  num2 := 2

  // + adds two variables
  sum := num1 + num2
  fmt.Printf("%d + %d = %d\n", num1, num2, sum)

  // - subtract two variables
  difference := num1 - num2
  fmt.Printf("%d - %d = %d\n",num1, num2,  difference)

  // * multiply two variables
  product := num1 * num2
  fmt.Printf("%d * %d is %d\n",num1, num2,  product)

//   Example 2: Golang Division Operator
  
	num1 := 11
	num2 := 4
  
	// / divide two integer variables
	quotient := num1 / num2
	fmt.Printf(" %d / %d = %d\n", num1, num2, quotient)
  
	 // / divide two floating point variables
	 result := num1 / num2
	 fmt.Printf(" %g / %g = %g\n", num1, num2, result)
  
// % modulo-divides two variables
remainder := num1 % num2
fmt.Println(remainder )

num++
  fmt.Println(num)  // 6

  // decrement of num by 1
  num--
  fmt.Println(num)  // 4


//   Go Assignment Operators


  // = operator to assign the value of num to result
  result = num
  fmt.Println(result)    // 6

//   Compound Assignment Operators
number := 2
number += 6
// += (addition assignment)	a += b	a = a + b
// -= (subtraction assignment)	a -= b	a = a - b
// *= (multiplication assignment)	a *= b	a = a * b
// /= (division assignment)	a /= b	a = a / b
// %= (modulo assignment)	a %= b		a = a % b

// Relational Operators in Golang
5 == 6

// == (equal to)	a == b	returns true if a and b are equal
// != (not equal to)	a != b	returns true if a and b are not equal
// > (greater than)	a > b	returns true if a is greater than b
// < (less than)	a < b	returns true if a is less than b
// >= (greater than or equal to)	a >= b	returns true if a is either greater than or equal to b
// <= (less than or equal to)	a <= b	returns true is a is either less than or equal to b

// Logical Operators in Go

// && (Logical AND)	exp1 && exp2	returns true if both expressions exp1 and exp2 are true
// || (Logical OR)	exp1 || exp2	returns true if any one of the expressions is true.
// ! (Logical NOT)	!exp	returns true if exp is false and returns false if exp is true.


// Go Type Casting
ar floatValue float = 9.8

// convert float to int
var intValue int = int(floatValue) //explicit type casting

// Go Explicit Type Casting
var floatValue float32 = 5.45

  // type conversion from float to int
  var intValue int = int(floatValue)
 
  fmt.Printf("Float Value is %g\n", floatValue)
  fmt.Printf("Integer Value is %d", intValue)

  var intValue int = 2

  // type conversion from int to float
  var floatValue float32 = float32(intValue)
 
  
  fmt.Printf("Integer Value is %d\n", intValue)
  fmt.Printf("Float Value is %f", floatValue)


//   Implicit Type Casting in Go
var number int = 4.34

  fmt.Printf("Number is %g", number)
//   ./prog.go:8:7: constant 4.34 truncated to integer
var number1 int = 20
var number2 float32 = 5.7
var sum float32

// addition of different data types
sum = float32(number1) + number2

fmt.Printf("Sum is %g",sum)




}