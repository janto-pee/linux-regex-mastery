// Program to define a function

package main
import "fmt"

// define a function
func greet() {
  fmt.Println("Good Morning")
}

func main() {
 
  // function call
  greet()

}


package main 
import "fmt"

// function to add two numbers
func addNumbers() {
  n1 := 12
  n2 := 8

  sum := n1 + n2
  fmt.Println("Sum:", sum)
}

func main() {
  // function call
  addNumbers()
}


// Example: Function Parameters
// Program to illustrate function parameters

package main
import "fmt"

// define a function with 2 parameters
func addNumbers(n1 int, n2 int) {
  sum := n1 + n2
  fmt.Println("Sum:", sum)
}

func main() {

  // pass parameters in function call
  addNumbers(21, 13)

}



// Example: Function Return Value
package main
import "fmt"

// function definition
func addNumbers(n1 int, n2 int) int {
  sum := n1 + n2
  return sum
}

func main() {

  // function call
  result := addNumbers(21, 13)

  fmt.Println("Sum:",result)
}

// Return Multiple Values from Go Function
// In Go, we can also return multiple values from a function. For example,

// Program to return multiple values from function

package main
import "fmt"

// function definition
func calculate(n1 int, n2 int) (int, int) {
  sum := n1 + n2
  difference := n1 - n2

  // return two values
  return sum, difference
}

func main() {

  // function call
  sum, difference := calculate(21, 13)

  fmt.Println("Sum:", sum, "Difference:", difference)
}


// Go Variable Scope
// Based on the scope, we can classify Go variables into two types:

// Local Variables
// Global Variables

// Program to illustrate global variable


package main
import "fmt"

// declare global variable before main function
var sum int

func addNumbers () {

  // local variable
  sum = 9 + 5
}


func main() {

  addNumbers()

  // can access sum
  fmt.Println("Sum is", sum)

}


// Go Recursion
// In computer programming, a recursive function calls itself. For example,
// Example: Recursion in Golang
package main
import "fmt"

func countDown(number int) {

  // display the number
  fmt.Println(number)

  // recursive call by decreasing number
  countDown(number - 1)

  }

func main() {
  countDown(3)
}


// Example: Go program to calculate the sum of positive numbers
package main
import "fmt"

func sum(number int) int {

  // condition to break recursion
  if number == 0 {
    return 0
  } else {
    return number + sum(number-1)
  }
}

func main() {
  var num = 50

  // function call
  var result = sum(num)

  fmt.Println("Sum:", result)
}



Factorial of a number using Go Recursion
package main
import "fmt"

func factorial (num int) int {

  // condition to break recursion
  if num == 0 {
    return 1
  } else {
    // condition for recursion call
    return num * factorial (num-1)
   }
}

func main() {
  var number = 3
  
  // function call
  var result = factorial (number)

  fmt.Println("The factorial of 3 is", result)
}



// Go Anonymous Function
// Example: Go Anonymous Function

package main
import "fmt"

func main() {

  // anonymous function
  var greet = func() {
    fmt.Println("Hello, how are you")
  }

  // function call
  greet()

}


// Program to pass arguments in an anonymous function

package main
import "fmt"

func main() {

  // anonymous function with arguments
  var sum = func(n1, n2 int) {
    sum := n1 + n2
    fmt.Println("Sum is:", sum)
  } 

  // function call
  sum(5, 3)

}


// Example: Return Value From Anonymous Function

// Program to return the area of a rectangle

package main
import "fmt"

func main() {

  // anonymous function
  area := func(length, breadth int) int {
    return length * breadth
  } 

  // function call using variable name
  fmt.Println("The area of rectangle is", area(3,4))

}


// Anonymous Function as Arguments to Other Functions

package main
import "fmt"

var sum = 0

// regular function to calculate square of numbers
func findSquare(num int) int {
  square := num * num
  return square
}

func main() {

  // anonymous function that returns sum of numbers
  sum := func(number1 int, number2 int) int {
    return number1 + number2
}

  // function call
  result := findSquare(sum(6, 9))
  fmt.Println("Result is:", result)

}


// Return an Anonymous Function in Go
// Program to return an anonymous function 

package main
import "fmt"

// function that returns an anonymous function
func displayNumber() func() int {

  number := 10
  return func() int {
    number++
    return number
  }
}

func main() {

  a := displayNumber()

  fmt.Println(a())

}



// Go Closure
// Go closure is a nested function that allows us to access variables of the outer function even after the outer function is closed.

// Go Closures
// As we have already discussed, closure is a nested function that helps us access the outer function's variables even after the outer function is closed. Let's see an example.

package main
import "fmt"

// outer function
func greet() func() string {

  // variable defined outside the inner function
  name := "John"
  
  // return a nested anonymous function
  return func() string {
    name = "Hi " + name
    return name
  }
}

func main() {

  // call the outer function
  message := greet()

  // call the inner function
  fmt.Println(message())

}



// Example: Print Odd Numbers using Golang Closure
package main
import "fmt"

func calculate() func() int {
  num := 1

  // returns inner function
  return func() int {
    num = num + 2
    return num
  }

}

func main() {

  // call the outer function
  odd := calculate()

  // call the inner function
  fmt.Println(odd())
  fmt.Println(odd())
  fmt.Println(odd())

  // call the outer function again
  odd2 := calculate()
  fmt.Println(odd2())

}


// Closure helps in Data Isolation
package main
import "fmt"

func displayNumbers() func() int {
  number := 0

  // inner function
  return func() int {
  number++
  return number
  }

}

func main() {

  // returns a closure 
  num1 := displayNumbers()

  fmt.Println(num1())
  fmt.Println(num1())
  fmt.Println(num1())

  // returns a new closure
  num2 := displayNumbers()
  fmt.Println(num2())
  fmt.Println(num2())

}

















