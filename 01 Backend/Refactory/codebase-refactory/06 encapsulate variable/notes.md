
ENCAPSULATE VARIABLE
formerly: Self­Encapsulate Field
formerly: Encapsulate Field
<!-- Motivation
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-------------------------------------------------------------------------------- -->
Refactoring is all about manipulating the elements of our programs. Data is more
awkward to manipulate than functions. Since using a function usually means calling it,
I can easily rename or move a function while keeping the old function intact as a
forwarding function (so my old code calls the old function, which calls the new
function). I’ll usually not keep this forwarding function around for long, but it does
simplify the refactoring.
Data is more awkward because I can’t do that. If I move data around, I have to change
all the references to the data in a single cycle to keep the code working. For data with a
very small scope of access, such as a temporary variable in a small function, this isn’t a
problem. But as the scope grows, so does the difficulty, which is why global data is such
a pain.
So if I want to move widely accessed data, often the best approach is to first encapsulate
it by routing all its access through functions. That way, I turn the difficult task of
reorganizing data into the simpler task of reorganizing functions.
Encapsulating data is valuable for other things too. It provides a clear point to monitor
changes and use of the data; I can easily add validation or consequential logic on the
updates. It is my habit to make all mutable data encapsulated like this and only
accessed through functions if its scope is greater than a single function. The greater the
scope of the data, the more important it is to encapsulate. My approach with legacy
code is that whenever I need to change or add a new reference to such a variable, I
should take the opportunity to encapsulate it. That way I prevent the increase of
coupling to commonly used data.
This principle is why the object­oriented approach puts so much emphasis on keeping
an object’s data private. Whenever I see a public field, I consider using Encapsulate
Variable (in that case often called Encapsulate Field) to reduce its visibility. Some go
further and argue that even internal references to fields within a class should go
through accessor functions—an approach known as self­encapsulation. On the whole, I
find self­encapsulation excessive—if a class is so big that I need to self­encapsulate its
fields, it needs to be broken up anyway. But self­encapsulating a field is a useful step
before splitting a class.
Keeping data encapsulated is much less important for immutable data. When the data
doesn’t change, I don’t need a place to put in validation or other logic hooks before
updates. I can also freely copy the data rather than move it—so I don’t have to change
references from old locations, nor do I worry about sections of code getting stale data.
Immutability is a powerful preservative.
<!-- <!-- Mechanics
..........................................................................
..........................................................................
..........................................................................
..........................................................................
..........................................................................

 --><!-- <!-- Mechanics
..........................................................................
..........................................................................
..........................................................................
..........................................................................
..........................................................................

 -->Create encapsulating functions to access and update the variable.
Run static checks.
For each reference to the variable, replace with a call to the appropriate
encapsulating function. Test after each replacement.
Restrict the visibility of the variable.
Sometimes it’s not possible to prevent access to the variable. If so, it may be useful
to detect any remaining references by renaming the variable and testing.
Test.
If the value of the variable is a record, consider Encapsulate Record (162).
Example
Consider some useful data held in a global variable.
Click here to view code image
let defaultOwner = {firstName: "Martin", lastName: "Fowler"};
Like any data, it’s referenced with code like this:
Click here to view code image
spaceship.owner = defaultOwner;
and updated like this:
Click here to view code image
defaultOwner = {firstName: "Rebecca", lastName: "Parsons"};
To do a basic encapsulation on this, I start by defining functions to read and write the
data.
Click here to view code image
function getDefaultOwner() {return defaultOwner;}
function setDefaultOwner(arg) {defaultOwner = arg;}
I then start working on references to defaultOwner. When I see a reference, I replace
it with a call to the getting function.
Click here to view code image
spaceship.owner = getDefaultOwner();
When I see an assignment, I replace it with the setting function.
Click here to view code image
setDefaultOwner({firstName: "Rebecca", lastName: "Parsons"});
I test after each replacement.
Once I’m done with all the references, I restrict the visibility of the variable. This both
checks that there aren’t any references that I’ve missed, and ensures that future
changes to the code won’t access the variable directly. I can do that in JavaScript by
moving both the variable and the accessor methods to their own file and only exporting
the accessor methods.
defaultOwner.js…
Click here to view code image
let defaultOwner = {firstName: "Martin", lastName: "Fowler"};
export function getDefaultOwner() {return defaultOwner;}
export function setDefaultOwner(arg) {defaultOwner = arg;}
If I’m in a situation where I cannot restrict the access to a variable, it may be useful to
rename the variable and retest. That won’t prevent future direct access, but naming the
variable something meaningful and awkward such as
__privateOnly_defaultOwner may help.
I don’t like the use of get prefixes on getters, so I’ll rename to remove it.
defaultOwner.js…
Click here to view code image
let defaultOwnerData = {firstName: "Martin", lastName: "Fowler"};
export function getdefaultOwner() {return defaultOwnerData;}
export function setDefaultOwner(arg) {defaultOwnerData = arg;}
A common convention in JavaScript is to name a getting function and setting function
the same and differentiate them due the presence of an argument. I call this practice
Overloaded Getter Setter [mf­ogs] and strongly dislike it. So, even though I don’t like
the get prefix, I will keep the set prefix.
Encapsulating the Value
The basic refactoring I’ve outlined here encapsulates a reference to some data structure,
allowing me to control its access and reassignment. But it doesn’t control changes to
that structure.
Click here to view code image
const owner1 = defaultOwner();
assert.equal("Fowler", owner1.lastName, "when set");
const owner2 = defaultOwner();
owner2.lastName = "Parsons";
assert.equal("Parsons", owner1.lastName, "after change owner2"); // is this ok?
The basic refactoring encapsulates the reference to the data item. In many cases, this is
all I want to do for the moment. But I often want to take the encapsulation deeper to
control not just changes to the variable but also to its contents.
For this, I have a couple of options. The simplest one is to prevent any changes to the
value. My favorite way to handle this is by modifying the getting function to return a
copy of the data.
defaultOwner.js…
Click here to view code image
let defaultOwnerData = {firstName: "Martin", lastName: "Fowler"};
export function defaultOwner() {return Object.assign({}, defaultOwnerData)export function setDefaultOwner(arg) {defaultOwnerData = arg;}
I use this approach particularly often with lists. If I return a copy of the data, any clients
using it can change it, but that change isn’t reflected in the shared data. I have to be
careful with using copies, however: Some code may expect to change shared data. If
that’s the case, I’m relying on my tests to detect a problem. An alternative is to prevent
changes—and a good way of doing that is Encapsulate Record (162).
Click here to view code image
let defaultOwnerData = {firstName: "Martin", lastName: "Fowler"};
export function defaultOwner() {return new Person(defaultOwnerData);}
export function setDefaultOwner(arg) {defaultOwnerData = arg;}
class Person {
constructor(data) {
this._lastName = data.lastName;
this._firstName = data.firstName
}
get lastName() {return this._lastName;}
get firstName() {return this._firstName;}
// and so on for other properties
Now, any attempt to reassign the properties of the default owner will cause an error.
Different languages have different techniques to detect or prevent changes like this, so
depending on the language I’d consider other options.
Detecting and preventing changes like this is often worthwhile as a temporary measure.
I can either remove the changes, or provide suitable mutating functions. Then, once
they are all dealt with, I can modify the getting method to return a copy.
So far I’ve talked about copying on getting data, but it may be worthwhile to make a
copy in the setter too. That will depend on where the data comes from and whether I
need to maintain a link to reflect any changes in that original data. If I don’t need such
a link, a copy prevents accidents due to changes on that source data. Taking a copy may
be superfluous most of the time, but copies in these cases usually have a negligible
effect on performance; on the other hand, if I don’t do them, there is a risk of a long and
difficult bout of debugging in the future.
Remember that the copying above, and the class wrapper, both only work one level
deep in the record structure. Going deeper requires more levels of copies or object
wrapping.
As you can see, encapsulating data is valuable, but often not straightforward. Exactly
what to encapsulate—and how to do it—depends on the way the data is being used and
the changes I have in mind. But the more widely it’s used, the more it’s worth my
attention to encapsulate properly.