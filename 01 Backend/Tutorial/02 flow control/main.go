// Go Booleans (Relational and Logical Operators)

Example: Relational Operator in Go
// Program to illustrate the working of Relational Operators




  number1 := 12
  number2 := 20
  var result bool

  // equal to operator
  result = (number1 == number2)

  fmt.Printf("%d == %d returns %t \n", number1, number2, result)

  // not equal to operator
  result = (number1 != number2)

  fmt.Printf("%d != %d returns %t \n", number1, number2, result)

  // greater than operator
  result = (number1 > number2)

  fmt.Printf("%d > %d returns %t \n", number1, number2, result)

  // less than operator
  result = (number1 < number2)

  fmt.Printf("%d < %d returns %t \n", number1, number2, result)


//   Example: Logical Operator in Go
  // Program to illustrate the working of Logical Operator
  

  
	number1 := 6
	number2 := 12
	number3 := 6
	var result bool
  
	// returns false because number1 > number2 is false
	result = (number1 > number2) && (number1 == number3)
  
	fmt.Printf("Result of AND operator is %t \n", result)
  
	// returns true because number1 == number3 is true
	result = (number1 > number2) || (number1 == number3)
  
	fmt.Printf("Result of OR operator is %t \n", result)
	
	// returns false because number1 == number3 is true
	result = !(number1 == number3);
  
	fmt.Printf("Result of NOT operator is %t \n", result)


	// Go Boolean Expression
	number1 := 5
	number2 := 8

	result := number1 > number2
  

	// Example: Nested if statement in Golang
	
	
	  number1 := 12
	  number2 := 20
	
	  // outer if statement
	  if number1 >= number2 {
	
	  // inner if statement
	  if number1 == number2 {
		fmt.Printf("Result: %d == %d", number1, number2)
		// inner else statement
	  } else {
		fmt.Printf("Result: %d > %d", number1, number2)
	  } 
	
	  // outer else statement
	  } else {
		fmt.Printf("Result: %d < %d", number1, number2)
	  }
	

	//   Go switch

	// Program to check if the day is a weekend or a weekday

	// Go switch with multiple cases
  dayOfWeek := "Sunday"

  switch dayOfWeek {
    case "Saturday", "Sunday":
      fmt.Println("Weekend")

    case "Monday","Tuesday","Wednesday","Thursday","Friday":
      fmt.Println("Weekday")

    default:
      fmt.Println("Invalid day")
  }



  	// Program to check the day of a week using optional statement

	//   Go switch optional statement

  // switch with statement
  switch day := 4; day {

    case 1:
      fmt.Println("Sunday")

    case 2:
      fmt.Println("Monday")

    case 3:
      fmt.Println("Tuesday")

    case 4:
      fmt.Println("Wednesday")

    case 5:
      fmt.Println("Thursday")

    case 6:
      fmt.Println("Friday") 
   
    case 7:
      fmt.Println("Saturday")

    default:
      fmt.Println("Invalid Day!")
  }



//   Example 2: Golang for loop
  // Program to print numbers for natural numbers 1 + 2 + 3 + ... +n
  

	var n, sum = 10, 0
	
	for i := 1 ; i <= n; i++ {
	  sum += i    // sum = sum + i  
	}
  
	fmt.Println("sum =", sum)
  


	// Create multiplication table using while loop
// Program to create a multiplication table of 5 using while loop


  multiplier := 1

  // run while loop for 10 times
  for multiplier <= 10 {

    // find the product
    product := 5 * multiplier

    // print the multiplication table in format 5 * 1 = 5
    fmt.Printf("5 * %d = %d\n", multiplier, product)
    multiplier++
  }




//   Go do...while Loop
  // Program to print number from 1 to 5
  
	number := 1
  
	// loop that runs infinitely
	for {
  
	  // condition to terminate the loop
	  if number > 5 {
		break;
	  }
  
	  fmt.Printf("%d\n", number);
	  number ++
  
	}
  
	Go for range with Array
	We can use the for range loop to access the individual index and element of an array. For example,
	
	// Program using range with array
	
	
	 

	 
	  // array of numbers
	  numbers := [5]int{21, 24, 27, 30, 33}
	 
	  // use range to iterate over the elements of array
	  for index, item := range numbers {
		fmt.Printf("numbers[%d] = %d \n", index, item)
	  }
	
	

	range with string in Golang
	In Go, we can also use the for range keyword with string to access individual characters of a string along with their respective index. For example,
	
	// Program using range with string
	
	
	

	  string := "Golang"
	  fmt.Println("Index: Character")
	
	  // i access index of each character
	  // item access each character
	  for i, item := range string {
		fmt.Printf("%d= %c \n", i, item)
	  }
	
	


// 	for range with Go map
// In Go, we can also use the for range keyword with map to access key-value pairs. For example,

// Program using range with map




  // create a map
  subjectMarks := map[string]float32{"Java": 80, "Python": 81, "Golang": 85}
  fmt.Println("Marks obtained:")

  // use for range to iterate through the key-value pair
  for subject, marks := range subjectMarks {
    fmt.Println(subject, ":", marks)
  }




// Access keys of Map using Go range
// We can also use the for range to only access the keys of a map. For example,

// Program to retrieve the keys of a map

  // create a map
  subjectMarks := map[string]float32{"Java": 80, "Python": 81, "Golang": 85}

  fmt.Println("Subjects:")
  for subject := range subjectMarks {
    fmt.Println( subject)
  }


//   Go continue statement with nested loops
	for i := 1; i <= 3; i++ {
	  for j := 1; j <= 3; j++ {
  
		// skips the inner for loop only
		if j==2 {
		  continue  //break
		}
  
	  fmt.Println("i=",  i, "j=",j )
  
	  }
	}
  



}