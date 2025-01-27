
EXTRACT VARIABLE
formerly: Introduce Explaining Variable
inverse of: Inline Variable (123)
<!-- Motivation
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-------------------------------------------------------------------------------- -->
Expressions can become very complex and hard to read. In such situations, local
variables may help break the expression down into something more manageable. In
particular, they give me an ability to name a part of a more complex piece of logic. This
allows me to better understand the purpose of what’s happening.
Such variables are also handy for debugging, since they provide an easy hook for a
debugger or print statement to capture.
If I’m considering Extract Variable, it means I want to add a name to an expression in
my code. Once I’ve decided I want to do that, I also think about the context of that
name. If it’s only meaningful within the function I’m working on, then Extract Variable
is a good choice—but if it makes sense in a broader context, I’ll consider making the
name available in that broader context, usually as a function. If the name is available
more widely, then other code can use that expression without having to repeat the
expression, leading to less duplication and a better statement of my intent.
The downside of promoting the name to a broader context is extra effort. If it’s
significantly more effort, I’m likely to leave it till later when I can use Replace Temp
with Query (178). But if it’s easy, I like to do it now so the name is immediately
available in the code. As a good example of this, if I’m working in a class, then Extract
Function (106) is very easy to do.
<!-- <!-- Mechanics
..........................................................................
..........................................................................
..........................................................................
..........................................................................
..........................................................................

 -->Ensure that the expression you want to extract does not have side effects.
Declare an immutable variable. Set it to a copy of the expression you want to name.
Replace the original expression with the new variable.
Test.
If the expression appears more than once, replace each occurrence with the variable,
testing after each replacement.
Example
I start with a simple calculation
Click here to view code image
function price(order) {
//price is base price ­ quantity discount + shipping
return order.quantity * order.itemPrice ­
Math.max(0, order.quantity ­ 500) * order.itemPrice * 0.05 +
Math.min(order.quantity * order.itemPrice * 0.1, 100);
}
Simple as it may be, I can make it still easier to follow. First, I recognize that the base
price is the multiple of the quantity and the item price.
Click here to view code image
function price(order) {
//price is base price ­ quantity discount + shipping
return order.quantity * order.itemPrice ­
Math.max(0, order.quantity ­ 500) * order.itemPrice * 0.05 +
Math.min(order.quantity * order.itemPrice * 0.1, 100);
}
Once that understanding is in my head, I put it in the code by creating and naming a
variable for it.
Click here to view code image
function price(order) {
//price is base price ­ quantity discount + shipping
const basePrice = order.quantity * order.itemPrice;
return order.quantity * order.itemPrice ­
Math.max(0, order.quantity ­ 500) * order.itemPrice * 0.05 +
Math.min(order.quantity * order.itemPrice * 0.1, 100);
}
Of course, just declaring and initializing a variable doesn’t do anything; I also have to
use it, so I replace the expression that I used as its source.
Click here to view code image
function price(order) {
//price is base price ­ quantity discount + shipping
const basePrice = order.quantity * order.itemPrice;
return basePrice ­
Math.max(0, order.quantity ­ 500) * order.itemPrice * 0.05 +
Math.min(order.quantity * order.itemPrice * 0.1, 100);
}
That same expression is used later on, so I can replace it with the variable there too.
Click here to view code image
function price(order) {
//price is base price ­ quantity discount + shipping
const basePrice = order.quantity * order.itemPrice;
return basePrice ­
Math.max(0, order.quantity ­ 500) * order.itemPrice * 0.05 +
Math.min(basePrice * 0.1, 100);
}
The next line is the quantity discount, so I can extract that too.
Click here to view code image
function price(order) {
//price is base price ­ quantity discount + shipping
const basePrice = order.quantity * order.itemPrice;
const quantityDiscount = Math.max(0, order.quantity ­ 500) * order.itemPrice *return basePrice ­
quantityDiscount +
Math.min(basePrice * 0.1, 100);
}
Finally, I finish with the shipping. As I do that, I can remove the comment, too, because
it no longer says anything the code doesn’t say.
Click here to view code image
function price(order) {
const basePrice = order.quantity * order.itemPrice;
const quantityDiscount = Math.max(0, order.quantity ­ 500) * order.itemPrice *const shipping = Math.min(basePrice * 0.1, 100);
return basePrice ­ quantityDiscount + shipping;
}
Example: With a Class
Here’s the same code, but this time in the context of a class:
Click here to view code image
class Order {
constructor(aRecord) {
this._data = aRecord;
}
get quantity() {return this._data.quantity;}
get itemPrice() {return this._data.itemPrice;}
get price() {
return this.quantity * this.itemPrice ­
Math.max(0, this.quantity ­ 500) * this.itemPrice * 0.05 +
Math.min(this.quantity * this.itemPrice * 0.1, 100);
}
}
In this case, I want to extract the same names, but I realize that the names apply to the
Order as a whole, not just the calculation of the price. Since they apply to the whole
order, I’m inclined to extract the names as methods rather than variables.
Click here to view code image
class Order {
constructor(aRecord) {
this._data = aRecord;
}
get quantity() {return this._data.quantity;}
get itemPrice() {return this._data.itemPrice;}
get price() {
return this.basePrice ­ this.quantityDiscount + this.shipping;
}
get basePrice() {return this.quantity * this.itemPrice;}
get quantityDiscount() {return Math.max(0, this.quantity ­ 500) * this.itemPriget shipping() {return Math.min(this.basePrice * 0.1, 100);}
}
This is one of the great benefits of objects—they give you a reasonable amount of
context for logic to share other bits of logic and data. For something as simple as this, it
doesn’t matter so much, but with a larger class it becomes very useful to call out
common hunks of behavior as their own abstractions with their own names to refer to
them whenever I’m working with the object.