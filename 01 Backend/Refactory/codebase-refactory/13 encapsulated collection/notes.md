## EDITINGNOTIVATIE
ENCAPSULATE COLLECTION
<!-- Motivation
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-------------------------------------------------------------------------------- -->
I like encapsulating any mutable data in my programs. This makes it easier to see when
and how data structures are modified, which then makes it easier to change those data
structures when I need to. Encapsulation is often encouraged, particularly by objectoriented developers, but a common mistake occurs when working with collections.
Access to a collection variable may be encapsulated, but if the getter returns the
collection itself, then that collection’s membership can be altered without the enclosing
class being able to intervene.
To avoid this, I provide collection modifier methods—usually add and remove—on the
class itself. This way, changes to the collection go through the owning class, giving me
the opportunity to modify such changes as the program evolves.
Iff the team has the habit to not to modify collections outside the original module, just
providing these methods may be enough. However, it’s usually unwise to rely on such
habits; a mistake here can lead to bugs that are difficult to track down later. A better
approach is to ensure that the getter for the collection does not return the raw
collection, so that clients cannot accidentally change it.
One way to prevent modification of the underlying collection is by never returning a
collection value. In this approach, any use of a collection field is done with specific
methods on the owning class, replacing aCustomer.orders.size with
aCustomer.numberOfOrders. I don’t agree with this approach. Modern languages
have rich collection classes with standardized interfaces, which can be combined in
useful ways such as Collection Pipelines [mf­cp]. Putting in special methods to handle
this kind of functionality adds a lot of extra code and cripples the easy composability of
collection operations.
Another way is to allow some form of read­only access to a collection. Java, for
example, makes it easy to return a read­only proxy to the collection. Such a proxy
forwards all reads to the underlying collection, but blocks all writes—in Java’s case,
throwing an exception. A similar route is used by libraries that base their collection
composition on some kind of iterator or enumerable object—providing that iterator
cannot modify the underlying collection.
Probably the most common approach is to provide a getting method for the collection,
but make it return a copy of the underlying collection. That way, any modifications to
the copy don’t affect the encapsulated collection. This might cause some confusion if
programmers expect the returned collection to modify the source field—but in many
code bases, programmers are used to collection getters providing copies. If the
collection is huge, this may be a performance issue—but most lists aren’t all that big, so
the general rules for performance should apply (Refactoring and Performance (64)).
Another difference between using a proxy and a copy is that a modification of the
source data will be visible in the proxy but not in a copy. This isn’t an issue most of the
time, because lists accessed in this way are usually only held for a short time.
What’s important here is consistency within a code base. Use only one mechanism so
everyone can get used to how it behaves and expect it when calling any collection
accessor function.
<!-- <!-- Mechanics
..........................................................................
..........................................................................
..........................................................................
..........................................................................
..........................................................................

 -->Apply Encapsulate Variable (132) if the reference to the collection isn’t already
encapsulated.
Add functions to add and remove elements from the collection.
If there is a setter for the collection, use Remove Setting Method (331) if possible. If
not, make it take a copy of the provided collection.
Run static checks.
Find all references to the collection. If anyone calls modifiers on the collection,
change them to use the new add/remove functions. Test after each change.
Modify the getter for the collection to return a protected view on it, using a readonly proxy or a copy.
Test.
Example
I start with a person class that has a field for a list of courses.
class Person…
Click here to view code image
constructor (name) {
this._name = name;
this._courses = [];
}
get name() {return this._name;}
get courses() {return this._courses;}
set courses(aList) {this._courses = aList;}
class Course…
Click here to view code image
constructor(name, isAdvanced) {
this._name = name;
this._isAdvanced = isAdvanced;
}
get name() {return this._name;}
get isAdvanced() {return this._isAdvanced;}
Clients use the course collection to gather information on courses.
Click here to view code image
numAdvancedCourses = aPerson.courses
.filter(c => c.isAdvanced)
.length
;
A naive developer would say this class has proper data encapsulation: After all, each
field is protected by accessor methods. But I would argue that the list of courses isn’t
properly encapsulated. Certainly, anyone updating the courses as a single value has
proper control through the setter:
client code…
Click here to view code image
const basicCourseNames = readBasicCourseNames(filename);
aPerson.courses = basicCourseNames.map(name => new Course(name, false));
But clients might find it easier to update the course list directly.
client code…
Click here to view code image
for(const name of readBasicCourseNames(filename)) {
aPerson.courses.push(new Course(name, false));
}
This violates encapsulating because the person class has no ability to take control when
the list is updated in this way. While the reference to the field is encapsulated, the
content of the field is not.
I’ll begin creating proper encapsulation by adding methods to the person class that
allow a client to add and remove individual courses.
class Person…
Click here to view code image
addCourse(aCourse) {
this._courses.push(aCourse);
}
removeCourse(aCourse, fnIfAbsent = () => {throw new RangeError();}) {
const index = this._courses.indexOf(aCourse);
if (index === ­1) fnIfAbsent();
else this._courses.splice(index, 1);
}
With a removal, I have to decide what to do if a client asks to remove an element that
isn’t in the collection. I can either shrug, or raise an error. With this code, I default to
raising an error, but give the callers an opportunity to do something else if they wish.
I then change any code that calls modifiers directly on the collection to use new
methods.
client code…
Click here to view code image
for(const name of readBasicCourseNames(filename)) {
aPerson.addCourse(new Course(name, false));
}
With individual add and remove methods, there is usually no need for setCourses, in
which case I’ll use Remove Setting Method (331) on it. Should the API need a setting
method for some reason, I ensure it puts a copy of the collection in the field.
class Person…
Click here to view code image
set courses(aList) {this._courses = aList.slice();}
All this enables the clients to use the right kind of modifier methods, but I prefer to
ensure nobody modifies the list without using them. I can do this by providing a copy.
class Person…
Click here to view code image
get courses() {return this._courses.slice();}
In general, I find it wise to be moderately paranoid about collections and I’d rather copy
them unnecessarily than debug errors due to unexpected modifications. Modifications
aren’t always obvious; for example, sorting an array in JavaScript modifies the original,
while many languages default to making a copy for an operation that changes a
collection. Any class that’s responsible for managing a collection should always give out
copies—but I also get into the habit of making a copy if I do something that’s liable to
change a collection.
