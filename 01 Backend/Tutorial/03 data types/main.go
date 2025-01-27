// Program to create an array and prints its elements

package main
import "fmt"

// var array_variable = [size]datatype{elements of array}

func main() {
   
  // declare array variable of type integer
  // defined size [size=5]
  var arrayOfInteger = [5]int{1, 5, 8, 0, 3}

  fmt.Println(arrayOfInteger)

//   Declare an array of undefined size
	// declare array variable of type string
  // undefined size
  var arrayOfString = [...]string{"Hello", "Programiz"}
  fmt.Println(arrayOfString)

  languages := [3]string{"Go", "Java", "C++"}

  // access element at index 0
  fmt.Println(languages[0]) // Go

  // access element at index 2
   fmt.Println(languages[2]) // C++







	//    Initialize an Array in Golang

	// declare an array
	var arrayOfIntegers[3] int
	
	// elements are assigned using index
	arrayOfIntegers[0] = 5
	arrayOfIntegers[1] = 10
	arrayOfIntegers[2] = 15

	fmt.Println(arrayOfIntegers)

		// initialize the elements of index 0 and 3 only
		arrayOfIntegers := [5]int{0: 7, 3: 9}

		fmt.Println(arrayOfIntegers)




		// change the element of index 2
		weather := [3]string{"Rainy", "Sunny", "Cloudy"}

  weather[2] = "Stromy"

  fmt.Println(weather)


   // create an array
   var arrayOfIntegers = [...]int{1, 5, 8, 0, 3, 10}
 
   // find the length of array using len()
   length := len(arrayOfIntegers)
  
   fmt.Println("The length of array is", length)


   age := [...]int{12, 4, 5}

  // loop through the array
  for i := 0; i < len(age); i++ {
    fmt.Println(age[i])
  }


  // create a 2 dimensional array
  arrayInteger := [2][2]int{{1, 2}, {3, 4}}

  // access the values of 2d array
  for i := 0; i < 2; i++ {
    for j := 0; j < 2; j++ {
      fmt.Println(arrayInteger[i][j])
    }
  }


	//   Go Slice
	//   Slice is a collection of similar types of data, just like arrays.

	// However, unlike arrays, slice doesn't have a fixed size. We can add or remove elements from the array.
	//   Create slice in Golang

	numbers := []int{1, 2, 3, 4, 5}
	/*
	Note: If we provide size inside the [] notation, it becomes an array. For example,

	// this is an array
	numbers := [5]int{1, 2, 3, 4, 5}

	// this is a slice
	numbers := []int{1, 2, 3, 4, 5}
	*/


	// Example: Create Slice from Array in Go
// Program to create a slice from an array


  // an integer array
  numbers := [8]int{10, 20, 30, 40, 50, 60, 70, 80}

  // create slice from an array
  sliceNumbers := numbers[4 : 7]

  fmt.Println(sliceNumbers)

	//   [50, 60, 70]


	// Adds Element to a Slice
	primeNumbers := []int{2, 3}
  
	// add elements 5, 7 to the slice
	primeNumbers = append(primeNumbers, 5, 7)
	fmt.Println("Prime Numbers:", primeNumbers)


  // Program to add elements of one slice to another
	// create two slices
	evenNumbers := []int{2, 4}
	oddNumbers := []int{1, 3}  
	
	// add elements of oddNumbers to evenNumbers
	evenNumbers = append(evenNumbers, oddNumbers...)
	fmt.Println("Numbers:", evenNumbers)


	// Copy Golang Slice
	 // create two slices
	 primeNumbers := []int{2, 3, 5, 7}
	 numbers := []int{1, 2, 3}
   
	 // copy elements of primeNumbers to numbers
	 copy(numbers, primeNumbers)
   
	 // print numbers
	 fmt.Println("Numbers:", numbers)
	//  copy(numbers, primeNumbers)

	// Find the Length of a Slice
	// create a slice of numbers
	numbers := []int{1, 5, 8, 0, 3}

	// find the length of the slice
	length := len(numbers)
  
	fmt.Println("Length:", numbers)


	// Program that loops over a slice using for loop

  numbers := []int{2, 4, 6, 8, 10}

  // for loop that iterates through the slice
  for i := 0; i < len(numbers); i++ {
    fmt.Println(numbers[i])
  }


//   Go map
//   In Go, the map data structure stores elements in key/value pairs. Here, keys are unique identifiers that are associated with each value on a map.
  
//   Create a map in Golang
  
//   The syntax to create a Go map is:
  
  subjectMarks := map[string]float32{"Golang": 85, "Java": 80, "Python": 81}



  
	// create a map
	flowerColor := map[string]string{"Sunflower": "Yellow", "Jasmine": "White", "Hibiscus": "Red"}
  
	// access value for key Sunflower
	fmt.Println(flowerColor["Sunflower"])  // Yellow
  
	// access value for key Hibiscus
	fmt.Println(flowerColor["Hibiscus"])  // Red
  
  

	

  // create a map
  capital := map[string]string{ "Nepal": "Kathmandu", "US": "New York"}
  fmt.Println("Initial Map: ", capital)

  // change value of US to Washington DC
  capital["US"] = "Washington DC"

  fmt.Println("Updated Map: ", capital)


	

  // create a map
  students := map[int]string{1: "John", 2: "Lily"}
  fmt.Println("Initial Map: ", students)

  // add element with key 3
  students[3] = "Robin"

  // add element with key 5
  students[5] = "Julie"

  fmt.Println("Updated Map: ", students)






  // create a map
  personAge := map[string]int{"Hermione": 21, "Harry": 20, "John": 25}
  fmt.Println("Initial Map: ", personAge)

  // remove element of map with key John
  delete(personAge, "John")

  fmt.Println("Updated Map: ", personAge)





  // create a map
  squaredNumber := map[int]int{2: 4, 3: 9, 4: 16, 5: 25}

  // for-range loop to iterate through each key-value of map
  for number, squared := range squaredNumber {
    fmt.Printf("Square of %d is %d\n", number, squared)
  }



//   Go struct
// A struct is used to store variables of different data types. For example,

// Suppose we want to store the name and age of a person. We can create two variables: name and age and store value.

// However, suppose we want to store the same information of multiple people.

// In this case, creating variables for a person might be a tedious task. We can create a struct that stores the name and age to overcome this.

// And, we can use this same struct for every person.

// Declare Go Struct
type Person struct {
	name string
	age  int
  }
  // create an instance of struct
  var person1 Person
  	// define the value of name and age
person1 = Person("John", 25)

// We can also directly define a struct while creating an instance of the struct. For example,

person1 := Person("John", 25)


/*
package main
import "fmt"

func main() {

  // declare a struct
  type Person struct {
    name string
    age  int
  }

  // assign value to struct while creating an instance
  person1 := Person{ "John", 25}
  fmt.Println(person1)

  // define an instance
  var person2 Person

  // assign value to struct variables
  person2 = Person {
    name: "Sara",
    age: 29,
  }

  fmt.Println(person2)
}
*/

/*
// Program to access the individual elements of struct

package main
import "fmt"

func main() {

  // declare a struct
  type Rectangle struct {
    length  int
    breadth int
}

  // declare instance rect1 and defining the struct
  rect := Rectangle{22, 12}

  // access the length of the struct
  fmt.Println("Length:", rect.length)

  // access the breadth of the struct
  fmt.Println("Breadth:", rect.breadth)
  
  area := rect.length * rect.breadth
  fmt.Println("Area:", area)

}

*/

/*
// Program to use function as a field  of struct

package main
import "fmt"

// initialize the function Rectangle
type Rectangle func(int, int) int

// create structure
type rectanglePara struct {
  length  int
  breadth int
  color   string

  // function as a field of struct
  rect Rectangle
}

func main() {

  // assign values to struct variables
  result := rectanglePara{
    length:  10,
    breadth: 20,
    color:   "Red",
    rect: func(length int, breadth int) int {
      return length * breadth
    },
  }

  fmt.Println("Color of Rectangle: ", result.color)
  fmt.Println("Area of Rectangle: ", result.rect(result.length, result.breadth))
}

*/


// Go String
// Program to create a string in Golang


  // create string using var
  var message1 = "Hello,"

  // create string using shorthand notation
  message2 := "Welcome to Programiz"

  fmt.Println(message1)
  fmt.Println(message2)

  	//  represent string with `  `    
  message := `I love Go Programming`


//   Access Characters of String in Go
   // create and initialize a string
   name := "Programiz"

   // access first character
   fmt.Printf("%c\n", name[0])  // P
 
   // access fourth character
   fmt.Printf("%c\n", name[3])  // g
 
   // access last character
   fmt.Printf("%c", name[8])  // z

   // use len() function to count length
  stringLength := len(message)

  message1 := "I love"
  message2 := "Go programming"
    
  // concatenation using + operator
  result := message1 + " " + message2


//   Golang String Methods
// In Go, the strings package provides various methods that can be used to perform different operations on strings.

// Functions	Descriptions
// Compare()	compares two strings
// Contains()	checks if a substring is present inside a string
// Replaces()	replaces a substring with another substring
// ToLower()	converts a string to lowercase
// ToUpper()	converts a string to uppercase
// Split()	splits a string into multiple substrings

  // use the escape character
message := "This article is about \"String\" in Go Programming."



































}