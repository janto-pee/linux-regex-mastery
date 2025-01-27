## EDITINGNOTIVATIE
REPLACE PRIMITIVE WITH OBJECT
formerly: Replace Data Value with Object
formerly: Replace Type Code with Class
<!-- Motivation
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-------------------------------------------------------------------------------- -->
Often, in early stages of development you make decisions about representing simple
facts as simple data items, such as numbers or strings. As development proceeds, those
simple items aren’t so simple anymore. A telephone number may be represented as a
string for a while, but later it will need special behavior for formatting, extracting the
area code, and the like. This kind of logic can quickly end up being duplicated around
the code base, increasing the effort whenever it needs to be used.
As soon as I realize I want to do something other than simple printing, I like to create a
new class for that bit of data. At first, such a class does little more than wrap the
primitive—but once I have that class, I have a place to put behavior specific to its needs.
These little values start very humble, but once nurtured they can grow into useful tools.
They may not look like much, but I find their effects on a code base can be surprisingly
large. Indeed many experienced developers consider this to be one of the most valuable
refactorings in the toolkit—even though it often seems counterintuitive to a new
programmer.
<!-- <!-- Mechanics
..........................................................................
..........................................................................
..........................................................................
..........................................................................
..........................................................................

 -->Apply Encapsulate Variable (132) if it isn’t already.
Create a simple value class for the data value. It should take the existing value in its
constructor and provide a getter for that value.
Run static checks.
Change the setter to create a new instance of the value class and store that in the
field, changing the type of the field if present.
Change the getter to return the result of invoking the getter of the new class.
Test.
Consider using Rename Function (124) on the original accessors to better reflect
what they do.
Consider clarifying the role of the new object as a value or reference object by
applying Change Reference to Value (252) or Change Value to Reference (256).
Example
I begin with a simple order class that reads its data from a simple record structure. One
of its properties is a priority, which it reads as a simple string.
class Order…
Click here to view code image
constructor(data) {
this.priority = data.priority;
// more initialization
Some client codes uses it like this:
client…
Click here to view code image
highPriorityCount = orders.filter(o => "high" === o.priority
|| "rush" === o.priority)
.length;
Whenever I’m fiddling with a data value, the first thing I do is use Encapsulate
Variable (132) on it.
class Order…
Click here to view code image
get priority() {return this._priority;}
set priority(aString) {this._priority = aString;}
The constructor line that initializes the priority will now use the setter I define here.
This self­encapsulates the field so I can preserve its current use while I manipulate the
data itself.
I create a simple value class for the priority. It has a constructor for the value and a
conversion function to return a string.
Click here to view code image
class Priority {
constructor(value) {this._value = value;}
toString() {return this._value;}
}
I prefer using a conversion function (toString) rather than a getter (value) here.
For clients of the class, asking for the string representation should feel more like a
conversion than getting a property.
I then modify the accessors to use this new class.
class Order…
Click here to view code image
get priority() {return this._priority.toString();}
set priority(aString) {this._priority = new Priority(aString);}
Now that I have a priority class, I find the current getter on the order to be misleading.
It doesn’t return the priority—but a string that describes the priority. My immediate
move is to use Rename Function (124).
class Order…
Click here to view code image
get priorityString() {return this._priority.toString();}
set priority(aString) {this._priority = new Priority(aString);}
client…
Click here to view code image
highPriorityCount = orders.filter(o => "high" === o.priorityString
|| "rush" === o.priorityString)
.length;
In this case, I’m happy to retain the name of the setter. The name of the argument
communicates what it expects.
Now I’m done with the formal refactoring. But as I look at who uses the priority, I
consider whether they should use the priority class themselves. As a result, I provide a
getter on order that provides the new priority object directly.
class Order…
Click here to view code image
get priority() {return this._priority;}
get priorityString() {return this._priority.toString();}
set priority(aString) {this._priority = new Priority(aString);}
client…
Click here to view code image
highPriorityCount = orders.filter(o => "high" === o.priority.toString()
|| "rush" === o.priority.toString())
.length;
As the priority class becomes useful elsewhere, I would allow clients of the order to use
the setter with a priority instance, which I do by adjusting the priority constructor.
class Priority…
Click here to view code image
constructor(value) {
if (value instanceof Priority) return value;
this._value = value;
}
The point of all this is that now, my new priority class can be useful as a place for new
behavior—either new to the code or moved from elsewhere. Here’s some simple code to
add validation of priority values and comparison logic:
class Priority…
Click here to view code image
constructor(value) {
if (value instanceof Priority) return value;
if (Priority.legalValues().includes(value))
this._value = value;
else
throw new Error(`<${value}> is invalid for Priority`);
}
toString() {return this._value;}
get _index() {return Priority.legalValues().findIndex(s => s === this._value);}
static legalValues() {return ['low', 'normal', 'high', 'rush'];}
equals(other) {return this._index === other._index;}
higherThan(other) {return this._index > other._index;}
lowerThan(other) {return this._index < other._index;}
As I do this, I decide that a priority should be a value object, so I provide an equals
method and ensure that it is immutable.
Now I’ve added that behavior, I can make the client code more meaningful:
client…
Click here to view code image
highPriorityCount = orders.filter(o => o.priority.higherThan(new Priority("norma.length;
