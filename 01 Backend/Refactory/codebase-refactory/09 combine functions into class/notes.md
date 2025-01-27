
COMBINE FUNCTIONS INTO CLASS
<!-- Motivation
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-------------------------------------------------------------------------------- -->
Classes are a fundamental construct in most modern programming languages. They
bind together data and functions into a shared environment, exposing some of that data
and function to other program elements for collaboration. They are the primary
construct in object­oriented languages, but are also useful with other approaches too.
When I see a group of functions that operate closely together on a common body of data
(usually passed as arguments to the function call), I see an opportunity to form a class.
Using a class makes the common environment that these functions share more explicit,
allows me to simplify function calls inside the object by removing many of the
arguments, and provides a reference to pass such an object to other parts of the system.
In addition to organizing already formed functions, this refactoring also provides a
good opportunity to identify other bits of computation and refactor them into methods
on the new class.
Another way of organizing functions together is Combine Functions into Transform
(149). Which one to use depends more on the broader context of the program. One
significant advantage of using a class is that it allows clients to mutate the core data of
the object, and the derivations remain consistent.
As well as a class, functions like this can also be combined into a nested function.
Usually I prefer a class to a nested function, as it can be difficult to test functions nested
within another. Classes are also necessary when there is more than one function in the
group that I want to expose to collaborators.
Languages that don’t have classes as a first­class element, but do have first­class
functions, often use the Function As Object [mf­fao] to provide this capability.
<!-- <!-- Mechanics
..........................................................................
..........................................................................
..........................................................................
..........................................................................
..........................................................................

 -->Apply Encapsulate Record (162) to the common data record that the functions
share.
If the data that is common between the functions isn’t already grouped into a record
structure, use Introduce Parameter Object (140) to create a record to group it
together.
Take each function that uses the common record and use Move Function (198) to
move it into the new class.
Any arguments to the function call that are members can be removed from the
argument list.
Each bit of logic that manipulates the data can be extracted with Extract Function
(106) and then moved into the new class.
Example
I grew up in England, a country renowned for its love of Tea. (Personally, I don’t like
most tea they serve in England, but have since acquired a taste for Chinese and
Japanese teas.) So my author’s fantasy conjures up a state utility for providing tea to
the population. Every month they read the tea meters, to get a record like this:
Click here to view code image
reading = {customer: "ivan", quantity: 10, month: 5, year: 2017};
I look through the code that processes these records, and I see lots of places where
similar calculations are done on the data. So I find a spot that calculates the base
charge:
client 1…
Click here to view code image
const aReading = acquireReading();
const baseCharge = baseRate(aReading.month, aReading.year) * aReading.quantity;
Being England, everything essential must be taxed, so it is with tea. But the rules allow
at least an essential level of tea to be free of taxation.
client 2…
Click here to view code image
const aReading = acquireReading();
const base = (baseRate(aReading.month, aReading.year) * aReading.quantity);
const taxableCharge = Math.max(0, base ­ taxThreshold(aReading.year));
I’m sure that, like me, you noticed that the formula for the base charge is duplicated
between these two fragments. If you’re like me, you’re already reaching for Extract
Function (106). Interestingly, it seems our work has been done for us elsewhere.
client 3…
Click here to view code image
const aReading = acquireReading();
const basicChargeAmount = calculateBaseCharge(aReading);
function calculateBaseCharge(aReading) {
return baseRate(aReading.month, aReading.year) * aReading.quantity;
}
Given this, I have a natural impulse to change the two earlier bits of client code to use
this function. But the trouble with top­level functions like this is that they are often easy
to miss. I’d rather change the code to give the function a closer connection to the data it
processes. A good way to do this is to turn the data into a class.
To turn the record into a class, I use Encapsulate Record (162).
Click here to view code image
class Reading {
constructor(data) {
this._customer = data.customer;
this._quantity = data.quantity;
this._month = data.month;
this._year = data.year;
}
get customer() {return this._customer;}
get quantity() {return this._quantity;}
get month() {return this._month;}
get year() {return this._year;}
}
To move the behavior, I’ll start with the function I already have:
calculateBaseCharge. To use the new class, I need to apply it to the data as soon as
I’ve acquired it.
client 3…
Click here to view code image
const rawReading = acquireReading();
const aReading = new Reading(rawReading);
const basicChargeAmount = calculateBaseCharge(aReading);
I then use Move Function (198) to move calculateBaseCharge into the new class.
class Reading…
Click here to view code image
get calculateBaseCharge() {
return baseRate(this.month, this.year) * this.quantity;
}
client 3…
Click here to view code image
const rawReading = acquireReading();
const aReading = new Reading(rawReading);
const basicChargeAmount = aReading.calculateBaseCharge;
While I’m at it, I use Rename Function (124) to make it something more to my liking.
Click here to view code image
get baseCharge() {
return baseRate(this.month, this.year) * this.quantity;
}
client 3…
Click here to view code image
const rawReading = acquireReading();
const aReading = new Reading(rawReading);
const basicChargeAmount = aReading.baseCharge;
With this naming, the client of the reading class can’t tell whether the base charge is a
field or a derived value. This is a Good Thing—the Uniform Access Principle [mf­ua].
I now alter the first client to call the method rather than repeat the calculation.
client 1…
Click here to view code image
const rawReading = acquireReading();
const aReading = new Reading(rawReading);
const baseCharge = aReading.baseCharge;
There’s a strong chance I’ll use Inline Variable (123) on the baseCharge variable
before the day is out. But more relevant to this refactoring is the client that calculates
the taxable amount. My first step here is to use the new base charge property.
client 2…
Click here to view code image
const rawReading = acquireReading();
const aReading = new Reading(rawReading);
const taxableCharge = Math.max(0, aReading.baseCharge ­ taxThreshold(aReading.ye
I use Extract Function (106) on the calculation for the taxable charge.
Click here to view code image
function taxableChargeFn(aReading) {
return Math.max(0, aReading.baseCharge ­ taxThreshold(aReading.year));
}
client 3…
Click here to view code image
const rawReading = acquireReading();
const aReading = new Reading(rawReading);
const taxableCharge = taxableChargeFn(aReading);
Then I apply Move Function (198).
class Reading…
Click here to view code image
get taxableCharge() {
return Math.max(0, this.baseCharge ­ taxThreshold(this.year));
}
client 3…
Click here to view code image
const rawReading = acquireReading();
const aReading = new Reading(rawReading);
const taxableCharge = aReading.taxableCharge;
Since all the derived data is calculated on demand, I have no problem should I need to
update the stored data. In general, I prefer immutable data, but many circumstances
force us to work with mutable data (such as JavaScript, a language ecosystem that
wasn’t designed with immutability in mind). When there is a reasonable chance the
data will be updated somewhere in the program, then a class is very helpful.