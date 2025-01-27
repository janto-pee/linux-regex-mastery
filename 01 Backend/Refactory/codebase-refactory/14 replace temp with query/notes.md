## EDITINGNOTIVATIE
REPLACE TEMP WITH QUERY
<!-- Motivation
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-------------------------------------------------------------------------------- -->

One use of temporary variables is to capture the value of some code in order to refer to
it later in a function. Using a temp allows me to refer to the value while explaining its
meaning and avoiding repeating the code that calculates it. But while using a variable is
handy, it can often be worthwhile to go a step further and use a function instead.
If I’m working on breaking up a large function, turning variables into their own
functions makes it easier to extract parts of the function, since I no longer need to pass
in variables into the extracted functions. Putting this logic into functions often also sets
up a stronger boundary between the extracted logic and the original function, which
helps me spot and avoid awkward dependencies and side effects.
Using functions instead of variables also allows me to avoid duplicating the calculation
logic in similar functions. Whenever I see variables calculated in the same way in
different places, I look to turn them into a single function.
This refactoring works best if I’m inside a class, since the class provides a shared
context for the methods I’m extracting. Outside of a class, I’m liable to have too many
parameters in a top­level function which negates much of the benefit of using a
function. Nested functions can avoid this, but they limit my ability to share the logic
between related functions.
Only some temporary variables are suitable for Replace Temp with Query. The variable
needs to be calculated once and then only be read afterwards. In the simplest case, this
means the variable is assigned to once, but it’s also possible to have several assignments
in a more complicated lump of code—all of which has to be extracted into the query.
Furthermore, the logic used to calculate the variable must yield the same result when
the variable is used later—which rules out variables used as snapshots with names like
oldAddress.
<!-- <!-- Mechanics
..........................................................................
..........................................................................
..........................................................................
..........................................................................
..........................................................................

 -->Check that the variable is determined entirely before it’s used, and the code that
calculates it does not yield a different value whenever it is used.
If the variable isn’t read­only, and can be made read­only, do so.
Test.
Extract the assignment of the variable into a function.
If the variable and the function cannot share a name, use a temporary name for the
function.
Ensure the extracted function is free of side effects. If not, use Separate Query from
Modifier (306).
Test.
Use Inline Variable (123) to remove the temp.
Example
Here is a simple class:
class Order…
Click here to view code image
constructor(quantity, item) {
this._quantity = quantity;
this._item = item;
}
get price() {
var basePrice = this._quantity * this._item.price;
var discountFactor = 0.98;
if (basePrice > 1000) discountFactor ­= 0.03;
return basePrice * discountFactor;
}
}
I want to replace the temps basePrice and discountFactor with methods.
Starting with basePrice, I make it const and run tests. This is a good way of
checking that I haven’t missed a reassignment—unlikely in such a short function but
common when I’m dealing with something larger.
class Order…
Click here to view code image
constructor(quantity, item) {
this._quantity = quantity;
this._item = item;
}
get price() {
const basePrice = this._quantity * this._item.price;
var discountFactor = 0.98;
if (basePrice > 1000) discountFactor ­= 0.03;
return basePrice * discountFactor;
}
}
I then extract the right­hand side of the assignment to a getting method.
class Order…
Click here to view code image
get price() {
const basePrice = this.basePrice;
var discountFactor = 0.98;
if (basePrice > 1000) discountFactor ­= 0.03;
return basePrice * discountFactor;
}
get basePrice() {
return this._quantity * this._item.price;
}
I test, and apply Inline Variable (123).
class Order…
Click here to view code image
get price() {
const basePrice = this.basePrice;
var discountFactor = 0.98;
if (this.basePrice > 1000) discountFactor ­= 0.03;
return this.basePrice * discountFactor;
}
I then repeat the steps with discountFactor, first using Extract Function (106).
class Order…
Click here to view code image
get price() {
const discountFactor = this.discountFactor;
return this.basePrice * discountFactor;
}
get discountFactor() {
var discountFactor = 0.98;
if (this.basePrice > 1000) discountFactor ­= 0.03;
return discountFactor;
}
In this case I need my extracted function to contain both assignments to
discountFactor. I can also set the original variable to be const.
Then, I inline:
Click here to view code image
get price() {
return this.basePrice * this.discountFactor;
}
