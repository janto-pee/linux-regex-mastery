## EDITINGNOTIVATIE
EXTRACT CLASS
inverse of: Inline Class (186)
<!-- Motivation
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-------------------------------------------------------------------------------- -->
You’ve probably read guidelines that a class should be a crisp abstraction, only handle a
few clear responsibilities, and so on. In practice, classes grow. You add some operations
here, a bit of data there. You add a responsibility to a class feeling that it’s not worth a
separate class—but as that responsibility grows and breeds, the class becomes too
complicated. Soon, your class is as crisp as a microwaved duck.
Imagine a class with many methods and quite a lot of data. A class that is too big to
understand easily. You need to consider where it can be split—and split it. A good sign
is when a subset of the data and a subset of the methods seem to go together. Other
good signs are subsets of data that usually change together or are particularly
dependent on each other. A useful test is to ask yourself what would happen if you
remove a piece of data or a method. What other fields and methods would become
nonsense?
One sign that often crops up later in development is the way the class is sub­typed. You
may find that subtyping affects only a few features or that some features need to be
subtyped one way and other features a different way.
<!-- <!-- Mechanics
..........................................................................
..........................................................................
..........................................................................
..........................................................................
..........................................................................

 -->Decide how to split the responsibilities of the class.
Create a new child class to express the split­off responsibilities.
If the responsibilities of the original parent class no longer match its name, rename
the parent.
Create an instance of the child class when constructing the parent and add a link
from parent to child.
Use Move Field (207) on each field you wish to move. Test after each move.
Use Move Function (198) to move methods to the new child. Start with lower­level
methods (those being called rather than calling). Test after each move.
Review the interfaces of both classes, remove unneeded methods, change names to
better fit the new circumstances.
Decide whether to expose the new child. If so, consider applying Change Reference
to Value (252) to the child class.
Example
Example
I start with a simple person class:
class Person…
Click here to view code image
get name() {return this._name;}
set name(arg) {this._name = arg;}
get telephoneNumber() {return `(${this.officeAreaCode}) ${this.officeNumber}`;}
get officeAreaCode() {return this._officeAreaCode;}
set officeAreaCode(arg) {this._officeAreaCode = arg;}
get officeNumber() {return this._officeNumber;}
set officeNumber(arg) {this._officeNumber = arg;}
Here. I can separate the telephone number behavior into its own class. I start by
defining an empty telephone number class:
class TelephoneNumber {
}
That was easy! Next, I create an instance of telephone number when constructing the
person:
class Person…
Click here to view code image
constructor() {
this._telephoneNumber = new TelephoneNumber();
}
class TelephoneNumber…
Click here to view code image
get officeAreaCode() {return this._officeAreaCode;}
set officeAreaCode(arg) {this._officeAreaCode = arg;}
I then use Move Field (207) on one of the fields.
class Person…
Click here to view code image
get officeAreaCode() {return this._telephoneNumber.officeAreaCode;}
set officeAreaCode(arg) {this._telephoneNumber.officeAreaCode = arg;}
I test, then move the next field.
class TelephoneNumber…
Click here to view code image
get officeNumber() {return this._officeNumber;}
set officeNumber(arg) {this._officeNumber = arg;}
class Person…
Click here to view code image
get officeNumber() {return this._telephoneNumber.officeNumber;}
set officeNumber(arg) {this._telephoneNumber.officeNumber = arg;}
Test again, then move the telephone number method.
class TelephoneNumber…
Click here to view code image
get telephoneNumber() {return `(${this.officeAreaCode}) ${this.officeNumber}`;}
class Person…
Click here to view code image
get telephoneNumber() {return this._telephoneNumber.telephoneNumber;}
Now I should tidy things up. Having “office” as part of the telephone number code
makes no sense, so I rename them.
class TelephoneNumber…
Click here to view code image
get areaCode() {return this._areaCode;}
set areaCode(arg) {this._areaCode = arg;}
get number() {return this._number;}
set number(arg) {this._number = arg;}
class Person…
Click here to view code image
get officeAreaCode() {return this._telephoneNumber.areaCode;}
set officeAreaCode(arg) {this._telephoneNumber.areaCode = arg;}
get officeNumber() {return this._telephoneNumber.number;}
set officeNumber(arg) {this._telephoneNumber.number = arg;}
The telephone number method on the telephone number class also doesn’t make much
sense, so I apply Rename Function (124).
class TelephoneNumber…
Click here to view code image
toString() {return `(${this.areaCode}) ${this.number}`;}
class Person…
Click here to view code image
get telephoneNumber() {return this._telephoneNumber.toString();}
Telephone numbers are generally useful, so I think I’ll expose the new object to clients.
I can replace those “office” methods with accessors for the telephone number. But this
way, the telephone number will work better as a Value Object [mf­vo], so I would apply
Change Reference to Value (252) first (that refactoring’s example shows how I’d do that
for the telephone number).
