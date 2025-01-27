## EDITINGNOTIVATIE
ENCAPSULATE RECORD
formerly: Replace Record with Data Class

<!-- Motivation
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-------------------------------------------------------------------------------- -->
This is why I often favor objects over records for mutable data. With objects, I can hide
what is stored and provide methods for all three values. The user of the object doesn’t
need to know or care which is stored and which is calculated. This encapsulation also
helps with renaming: I can rename the field while providing methods for both the new
and the old names, gradually updating callers until they are all done.
I just said I favor objects for mutable data. If I have an immutable value, I can just have
all three values in my record, using an enrichment step if necessary. Similarly, it’s easy
to copy the field when renaming.
I can have two kinds of record structures: those where I declare the legal field names
and those that allow me to use whatever I like. The latter are often implemented
through a library class called something like hash, map, hashmap, dictionary, or
associative array. Many languages provide convenient syntax for creating hashmaps,
which makes them useful in many programming situations. The downside of using
them is they are aren’t explicit about their fields. The only way I can tell if they use
start/end or start/length is by looking at where they are created and used. This isn’t a
problem if they are only used in a small section of a program, but the wider their scope
of usage, the greater problem I get from their implicit structure. I could refactor such
implicit records into explicit ones—but if I need to do that, I’d rather make them classes
instead.
It’s common to pass nested structures of lists and hashmaps which are often serialized
into formats like JSON or XML. Such structures can be encapsulated too, which helps if
their formats change later on or if I’m concerned about updates to the data that are
hard to keep track of.
<!-- <!-- Mechanics
..........................................................................
..........................................................................
..........................................................................
..........................................................................
..........................................................................

 -->Use Encapsulate Variable (132) on the variable holding the record.
Give the functions that encapsulate the record names that are easily searchable.
Replace the content of the variable with a simple class that wraps the record. Define
an accessor inside this class that returns the raw record. Modify the functions that
encapsulate the variable to use this accessor.
Test.
Provide new functions that return the object rather than the raw record.
For each user of the record, replace its use of a function that returns the record with
a function that returns the object. Use an accessor on the object to get at the field
data, creating that accessor if needed. Test after each change.
If it’s a complex record, such as one with a nested structure, focus on clients that
update the data first. Consider returning a copy or read­only proxy of the data for
clients that only read the data.
Remove the class’s raw data accessor and the easily searchable functions that
returned the raw record.
Test.
If the fields of the record are themselves structures, consider using Encapsulate
Record and Encapsulate Collection (170) recursively.
Example
I’ll start with a constant that is widely used across a program.
Click here to view code image
const organization = {name: "Acme Gooseberries", country: "GB"};
This is a JavaScript object which is being used as a record structure by various parts of
the program, with accesses like this:
Click here to view code image
result += `<h1>${organization.name}</h1>`;
and
organization.name = newName;
The first step is a simple Encapsulate Variable (132).
Click here to view code image
function getRawDataOfOrganization() {return organization;}
example reader…
Click here to view code image
result += `<h1>${getRawDataOfOrganization().name}</h1>`;
example writer…
Click here to view code image
getRawDataOfOrganization().name = newName;
It’s not quite a standard Encapsulate Variable (132), since I gave the getter a name
deliberately chosen to be both ugly and easy to search for. This is because I intend its
life to be short.
Encapsulating a record means going deeper than just the variable itself; I want to
control how it’s manipulated. I can do this by replacing the record with a class.
class Organization…
class Organization {
constructor(data) {
this._data = data;
}
}
top level
Click here to view code image
const organization = new Organization({name: "Acme Gooseberries", country: "GB"}function getRawDataOfOrganization() {return organization._data;}
function getOrganization() {return organization;}
Now that I have an object in place, I start looking at the users of the record. Any one
that updates the record gets replaced with a setter.
class Organization…
Click here to view code image
set name(aString) {this._data.name = aString;}
client…
getOrganization().name = newName;
Similarly, I replace any readers with the appropriate getter.
class Organization…
Click here to view code image
get name() {return this._data.name;}
client…
Click here to view code image
result += `<h1>${getOrganization().name}</h1>`;
After I’ve done that, I can follow through on my threat to give the ugly sounding
function a short life.
Click here to view code image
function getRawDataOfOrganization() {return organization._data;}
function getOrganization() {return organization;}
I’d also be inclined to fold the _data field directly into the object.
Click here to view code image
class Organization {
constructor(data) {
this._name = data.name;
this._country = data.country;
}
get name() {return this._name;}
set name(aString) {this._name = aString;}
get country() {return this._country;}
set country(aCountryCode) {this._country = aCountryCode;}
}
This has the advantage of breaking the link to the input data record. This might be
useful if a reference to it runs around, which would break encapsulation. Should I not
fold the data into individual fields, I would be wise to copy _data when I assign it.
Example: Encapsulating a Nested Record
The above example looks at a shallow record, but what do I do with data that is deeply
nested, e.g., coming from a JSON document? The core refactoring steps still apply, and
I have to be equally careful with updates, but I do get some options around reads.
As an example, here is some slightly more nested data: a collection of customers, kept
in a hashmap indexed by their customer ID.
Click here to view code image
"1920": {
name: "martin",
id: "1920",
usages: {
"2016": {
"1": 50,
"2": 55,
// remaining months of the year
},
"2015": {
"1": 70,
"2": 63,
// remaining months of the year
}
}
},
"38673": {
name: "neal",
id: "38673",
// more customers in a similar form
With more nested data, reads and writes can be digging into the data structure.
sample update…
Click here to view code image
customerData[customerID].usages[year][month] = amount;
sample read…
Click here to view code image
function compareUsage (customerID, laterYear, month) {
const later = customerData[customerID].usages[laterYear][month];
const earlier = customerData[customerID].usages[laterYear ­ 1][month];
return {laterAmount: later, change: later ­ earlier};
}
To encapsulate this data, I also start with Encapsulate Variable (132).
Click here to view code image
function getRawDataOfCustomers() {return customerData;}
function setRawDataOfCustomers(arg) {customerData = arg;}
sample update…
Click here to view code image
getRawDataOfCustomers()[customerID].usages[year][month] = amount;
sample read…
Click here to view code image
function compareUsage (customerID, laterYear, month) {
const later = getRawDataOfCustomers()[customerID].usages[laterYear][month];
const earlier = getRawDataOfCustomers()[customerID].usages[laterYear ­ 1][montreturn {laterAmount: later, change: later ­ earlier};
}
I then make a class for the overall data structure.
class CustomerData {
constructor(data) {
this._data = data;
}
}
top level…
Click here to view code image
function getCustomerData() {return customerData;}
function getRawDataOfCustomers() {return customerData._data;}
function setRawDataOfCustomers(arg) {customerData = new CustomerData(arg);}
The most important area to deal with is the updates. So, while I look at all the callers of
getRawDataOfCustomers, I’m focused on those where the data is changed. To
remind you, here’s the update again:
sample update…
Click here to view code image
getRawDataOfCustomers()[customerID].usages[year][month] = amount;
The general mechanics now say to return the full customer and use an accessor,
creating one if needed. I don’t have a setter on the customer for this update, and this
one digs into the structure. So, to make one, I begin by using Extract Function (106) on
the code that digs into the data structure.
sample update…
Click here to view code image
setUsage(customerID, year, month, amount);
top level…
Click here to view code image
function setUsage(customerID, year, month, amount) {
getRawDataOfCustomers()[customerID].usages[year][month] = amount;
}
I then use Move Function (198) to move it into the new customer data class.
sample update…
Click here to view code image
getCustomerData().setUsage(customerID, year, month, amount);
class CustomerData…
Click here to view code image
setUsage(customerID, year, month, amount) {
this._data[customerID].usages[year][month] = amount;
}
When working with a big data structure, I like to concentrate on the updates. Getting
them visible and gathered in a single place is the most important part of the
encapsulation.
At some point, I will think I’ve got them all—but how can I be sure? There’s a couple of
ways to check. One is to modify getRawDataOfCustomers to return a deep copy of
the data; if my test coverage is good, one of the tests should break if I missed a
modification.
top level…
Click here to view code image
function getCustomerData() {return customerData;}
function getRawDataOfCustomers() {return customerData.rawData;}
function setRawDataOfCustomers(arg) {customerData = new CustomerData(arg);}
class CustomerData…
Click here to view code image
get rawData() {
return _.cloneDeep(this._data);
}
I’m using the lodash library to make a deep copy.
Another approach is to return a read­only proxy for the data structure. Such a proxy
could raise an exception if the client code tries to modify the underlying object. Some
languages make this easy, but it’s a pain in JavaScript, so I’ll leave it as an exercise for
the reader. I could also take a copy and recursively freeze it to detect any modifications.
Dealing with the updates is valuable, but what about the readers? Here there are a few
options.
The first option is to do the same thing as I did for the setters. Extract all the reads into
their own functions and move them into the customer data class.
class CustomerData…
Click here to view code image
usage(customerID, year, month) {
return this._data[customerID].usages[year][month];
}
top level…
Click here to view code image
function compareUsage (customerID, laterYear, month) {
const later = getCustomerData().usage(customerID, laterYear, month);
const earlier = getCustomerData().usage(customerID, laterYear ­ 1, month)
return {laterAmount: later, change: later ­ earlier};
}
The great thing about this approach is that it gives customerData an explicit API that
captures all the uses made of it. I can look at the class and see all their uses of the data.
But this can be a lot of code for lots of special cases. Modern languages provide good
affordances for digging into a list­and­hash [mf­lh] data structure, so it’s useful to give
clients just such a data structure to work with.
If the client wants a data structure, I can just hand out the actual data. But the problem
with this is that there’s no way to prevent clients from modifying the data directly,
which breaks the whole point of encapsulating all the updates inside functions.
Consequently, the simplest thing to do is to provide a copy of the underlying data, using
the rawData method I wrote earlier.
class CustomerData…
Click here to view code image
get rawData() {
return _.cloneDeep(this._data);
}
top level…
Click here to view code image
function compareUsage (customerID, laterYear, month) {
const later = getCustomerData().rawData[customerID].usages[laterYear][month]const earlier = getCustomerData().rawData[customerID].usages[laterYear ­ 1][moreturn {laterAmount: later, change: later ­ earlier};
}
But although it’s simple, there are downsides. The most obvious problem is the cost of
copying a large data structure, which may turn out to be a performance problem. As
with anything like this, however, the performance cost might be acceptable—I would
want to measure its impact before I start to worry about it. There may also be confusion
if clients expect modifying the copied data to modify the original. In those cases, a readonly proxy or freezing the copied data might provide a helpful error should they do this.
Another option is more work, but offers the most control: Apply Encapsulate Record
recursively. With this, I turn the customer record into its own class, apply Encapsulate
Collection (170) to the usages, and create a usage class. I can then enforce control of
updates by using accessors, perhaps applying Change Reference to Value (252) on the
usage objects. But this can be a lot of effort for a large data structure—and not really
needed if I don’t access that much of the data structure. Sometimes, a judicious mix of
getters and new classes may work, using a getter to dig deep into the structure but
returning an object that wraps the structure rather than the unencapsulated data. I
wrote about this kind of thing in an article “Refactoring Code to Load a Document” [mfref­doc].
