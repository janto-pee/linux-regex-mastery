
INTRODUCE PARAMETER OBJECT
<!-- Motivation
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-------------------------------------------------------------------------------- -->
I often see groups of data items that regularly travel together, appearing in function
after function. Such a group is a data clump, and I like to replace it with a single data
structure.
Grouping data into a structure is valuable because it makes explicit the relationship
between the data items. It reduces the size of parameter lists for any function that uses
the new structure. It helps consistency since all functions that use the structure will use
the same names to get at its elements.
But the real power of this refactoring is how it enables deeper changes to the code.
When I identify these new structures, I can reorient the behavior of the program to use
these structures. I will create functions that capture the common behavior over this
data—either as a set of common functions or as a class that combines the data structure
with these functions. This process can change the conceptual picture of the code,
raising these structures as new abstractions that can greatly simplify my understanding
of the domain. When this works, it can have surprisingly powerful effects—but none of
this is possible unless I use Introduce Parameter Object to begin the process.
<!-- <!-- Mechanics
..........................................................................
..........................................................................
..........................................................................
..........................................................................
..........................................................................

 -->If there isn’t a suitable structure already, create one.
I prefer to use a class, as that makes it easier to group behavior later on. I usually
like to ensure these structures are value objects [mf­vo].
Test.
Use Change Function Declaration (124) to add a parameter for the new structure.
Test.
Adjust each caller to pass in the correct instance of the new structure. Test after
each one.
For each element of the new structure, replace the use of the original parameter
with the element of the structure. Remove the parameter. Test.
Example
I’ll begin with some code that looks at a set of temperature readings and determines
whether any of them fall outside of an operating range. Here’s what the data looks like
for the readings:
Click here to view code image
const station = { name: "ZB1",
readings: [
{temp: 47, time: "2016­11­10 09:10"},
{temp: 53, time: "2016­11­10 09:20"},
{temp: 58, time: "2016­11­10 09:30"},
{temp: 53, time: "2016­11­10 09:40"},
{temp: 51, time: "2016­11­10 09:50"},
]
};
I have a function to find the readings that are outside a temperature range.
Click here to view code image
function readingsOutsideRange(station, min, max) {
return station.readings
.filter(r => r.temp < min || r.temp > max);
}
It might be called from some code like this:
caller
Click here to view code image
alerts = readingsOutsideRange(station,
operatingPlan.temperatureFloor,
operatingPlan.temperatureCeiling);
Notice how the calling code pulls the two data items as a pair from another object and
passes the pair into readingsOutsideRange. The operating plan uses different
names to indicate the start and end of the range compared to
readingsOutsideRange. A range like this is a common case where two separate data
items are better combined into a single object. I’ll begin by declaring a class for the
combined data.
Click here to view code image
class NumberRange {
constructor(min, max) {
this._data = {min: min, max: max};
}
get min() {return this._data.min;}
get max() {return this._data.max;}
}
I declare a class, rather than just using a basic JavaScript object, because I usually find
this refactoring to be a first step to moving behavior into the newly created object. Since
a class makes sense for this, I go right ahead and use one directly. I also don’t provide
any update methods for the new class, as I’ll probably make this a Value Object [mf­vo].
Most times I do this refactoring, I create value objects.
I then use Change Function Declaration (124) to add the new object as a parameter to
readingsOutsideRange.
Click here to view code image
function readingsOutsideRange(station, min, max, range) {
return station.readings
.filter(r => r.temp < min || r.temp > max);
}
In JavaScript, I can leave the caller as is, but in other languages I’d have to add a null
for the new parameter which would look something like this:
caller
Click here to view code image
alerts = readingsOutsideRange(station,
operatingPlan.temperatureFloor,
operatingPlan.temperatureCeiling,
null);
At this point I haven’t changed any behavior, and tests should still pass. I then go to
each caller and adjust it to pass in the correct date range.
caller
Click here to view code image
const range = new NumberRange(operatingPlan.temperatureFloor, operatingPlan.tempalerts = readingsOutsideRange(station,
operatingPlan.temperatureFloor,
operatingPlan.temperatureCeiling,
range);
I still haven’t altered any behavior yet, as the parameter isn’t used. All tests should still
work.
Now I can start replacing the usage of the parameters. I’ll start with the maximum.
Click here to view code image
function readingsOutsideRange(station, min, max, range) {
return station.readings
.filter(r => r.temp < min || r.temp > range.max);
}
caller
Click here to view code image
const range = new NumberRange(operatingPlan.temperatureFloor, operatingPlan.tempalerts = readingsOutsideRange(station,
operatingPlan.temperatureFloor,
operatingPlan.temperatureCeiling,
range);
I can test at this point, then remove the other parameter.
Click here to view code image
function readingsOutsideRange(station, min, range) {
return station.readings
.filter(r => r.temp < range.min || r.temp > range.max);
}
caller
Click here to view code image
const range = new NumberRange(operatingPlan.temperatureFloor, operatingPlan.tempalerts = readingsOutsideRange(station,
operatingPlan.temperatureFloor,
range);
That completes this refactoring. However, replacing a clump of parameters with a real
object is just the setup for the really good stuff. The great benefits of making a class like
this is that I can then move behavior into the new class. In this case, I’d add a method
for range that tests if a value falls within the range.
Click here to view code image
function readingsOutsideRange(station, range) {
return station.readings
.filter(r => !range.contains(r.temp));
}
class NumberRange…
Click here to view code image
contains(arg) {return (arg >= this.min && arg <= this.max);}
This is a first step to creating a range [mf­range] that can take on a lot of useful
behavior. Once I’ve identified the need for a range in my code, I can be constantly on
the lookout for other cases where I see a max/min pair of numbers and replace them
with a range. (One immediate possibility is the operating plan, replacing
temperatureFloor and temperatureCeiling with a temperatureRange.) As I
look at how these pairs are used, I can move more useful behavior into the range class,
simplifying its usage across the code base. One of the first things I may add is a valuebased equality method to make it a true value object.