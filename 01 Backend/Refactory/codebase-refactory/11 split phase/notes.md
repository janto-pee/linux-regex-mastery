
SPLIT PHASE
<!-- Motivation
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-------------------------------------------------------------------------------- -->
When I run into code that’s dealing with two different things, I look for a way to split it
into separate modules. I endeavor to make this split because, if I need to make a
change, I can deal with each topic separately and not have to hold both in my head
together. If I’m lucky, I may only have to change one module without having to
remember the details of the other one at all.
One of the neatest ways to do a split like this is to divide the behavior into two
sequential phases. A good example of this is when you have some processing whose
inputs don’t reflect the model you need to carry out the logic. Before you begin, you can
massage the input into a convenient form for your main processing. Or, you can take
the logic you need to do and break it down into sequential steps, where each step is
significantly different in what it does.
The most obvious example of this is a compiler. It’s a basic task is to take some text
(code in a programming language) and turn it into some executable form (e.g., object
code for a specific hardware). Over time, we’ve found this can be usefully split into a
chain of phases: tokenizing the text, parsing the tokens into a syntax tree, then various
steps of transforming the syntax tree (e.g., for optimization), and finally generating the
object code. Each step has a limited scope and I can think of one step without
understanding the details of others.
Splitting phases like this is common in large software; the various phases in a compiler
can each contain many functions and classes. But I can carry out the basic split­phase
refactoring on any fragment of code—whenever I see an opportunity to usefully
separate the code into different phases. The best clue is when different stages of the
fragment use different sets of data and functions. By turning them into separate
modules I can make this difference explicit, revealing the difference in the code.
<!-- <!-- Mechanics
..........................................................................
..........................................................................
..........................................................................
..........................................................................
..........................................................................

 -->Extract the second phase code into its own function.
Test.
Introduce an intermediate data structure as an additional argument to the extracted
function.
Test.
Examine each parameter of the extracted second phase. If it is used by first phase,
move it to the intermediate data structure. Test after each move.
Sometimes, a parameter should not be used by the second phase. In this case,
extract the results of each usage of the parameter into a field of the intermediate
data structure and use Move Statements to Callers (217) on the line that populates
it.
Apply Extract Function (106) on the first­phase code, returning the intermediate
data structure.
It’s also reasonable to extract the first phase into a transformer object.
Example
I’ll start with code to price an order for some vague and unimportant kind of goods:
Click here to view code image
function priceOrder(product, quantity, shippingMethod) {
const basePrice = product.basePrice * quantity;
const discount = Math.max(quantity ­ product.discountThreshold, 0)
* product.basePrice * product.discountRate;
const shippingPerCase = (basePrice > shippingMethod.discountThreshold)
? shippingMethod.discountedFee : shippingMethod.feePerCase;
const shippingCost = quantity * shippingPerCase;
const price = basePrice ­ discount + shippingCost;
return price;
}
Although this is the usual kind of trivial example, there is a sense of two phases going
on here. The first couple of lines of code use the product information to calculate the
product­oriented price of the order, while the later code uses shipping information to
determine the shipping cost. If I have changes coming up that complicate the pricing
and shipping calculations, but they work relatively independently, then splitting this
code into two phases is valuable.
I begin by applying Extract Function (106) to the shipping calculation.
Click here to view code image
function priceOrder(product, quantity, shippingMethod) {
const basePrice = product.basePrice * quantity;
const discount = Math.max(quantity ­ product.discountThreshold, 0)
* product.basePrice * product.discountRate;
const price = applyShipping(basePrice, shippingMethod, quantity, discount);
return price;
}
function applyShipping(basePrice, shippingMethod, quantity, discount) {
const shippingPerCase = (basePrice > shippingMethod.discountThreshold)
? shippingMethod.discountedFee : shippingMethod.feePerCase;
const shippingCost = quantity * shippingPerCase;
const price = basePrice ­ discount + shippingCost;
return price;
}
I pass in all the data that this second phase needs as individual parameters. In a more
realistic case, there can be a lot of these, but I don’t worry about it as I’ll whittle them
down later.
Next, I introduce the intermediate data structure that will communicate between the
two phases.
Click here to view code image
function priceOrder(product, quantity, shippingMethod) {
const basePrice = product.basePrice * quantity;
const discount = Math.max(quantity ­ product.discountThreshold, 0)
* product.basePrice * product.discountRate;
const priceData = {};
const price = applyShipping(priceData, basePrice, shippingMethod, quantity, dreturn price;
}
function applyShipping(priceData, basePrice, shippingMethod, quantity, discount)const shippingPerCase = (basePrice > shippingMethod.discountThreshold)
? shippingMethod.discountedFee : shippingMethod.feePerCase;
const shippingCost = quantity * shippingPerCase;
const price = basePrice ­ discount + shippingCost;
return price;
}
Now, I look at the various parameters to applyShipping. The first one is basePrice
which is created by the first­phase code. So I move this into the intermediate data
structure, removing it from the parameter list.
Click here to view code image
function priceOrder(product, quantity, shippingMethod) {
const basePrice = product.basePrice * quantity;
const discount = Math.max(quantity ­ product.discountThreshold, 0)
* product.basePrice * product.discountRate;
const priceData = {basePrice: basePrice};
const price = applyShipping(priceData, basePrice, shippingMethod, quantity, dreturn price;
}
function applyShipping(priceData, basePrice, shippingMethod, quantity, discount)const shippingPerCase = (priceData.basePrice > shippingMethod.discountThreshol? shippingMethod.discountedFee : shippingMethod.feePerCase;
const shippingCost = quantity * shippingPerCase;
const price = priceData.basePrice ­ discount + shippingCost;
return price;
}
The next parameter in the list is shippingMethod. This one I leave as is, since it isn’t
used by the first­phase code.
After this, I have quantity. This is used by the first phase but not created by it, so I
could actually leave this in the parameter list. My usual preference, however, is to move
as much as I can to the intermediate data structure.
Click here to view code image
function priceOrder(product, quantity, shippingMethod) {
const basePrice = product.basePrice * quantity;
const discount = Math.max(quantity ­ product.discountThreshold, 0)
* product.basePrice * product.discountRate;
const priceData = {basePrice: basePrice, quantity: quantity};
const price = applyShipping(priceData, shippingMethod, quantity, discount);
return price;
}
function applyShipping(priceData, shippingMethod, quantity, discount) {
const shippingPerCase = (priceData.basePrice > shippingMethod.discountThreshol? shippingMethod.discountedFee : shippingMethod.feePerCase;
const shippingCost = priceData.quantity * shippingPerCase;
const price = priceData.basePrice ­ discount + shippingCost;
return price;
}
I do the same with discount.
Click here to view code image
function priceOrder(product, quantity, shippingMethod) {
const basePrice = product.basePrice * quantity;
const discount = Math.max(quantity ­ product.discountThreshold, 0)
* product.basePrice * product.discountRate;
const priceData = {basePrice: basePrice, quantity: quantity, discount:discountconst price = applyShipping(priceData, shippingMethod, discount);
return price;
}
function applyShipping(priceData, shippingMethod, discount) {
const shippingPerCase = (priceData.basePrice > shippingMethod.discountThreshol? shippingMethod.discountedFee : shippingMethod.feePerCase;
const shippingCost = priceData.quantity * shippingPerCase;
const price = priceData.basePrice ­ priceData.discount + shippingCost;
return price;
}
Once I’ve gone through all the function parameters, I have the intermediate data
structure fully formed. So I can extract the first­phase code into its own function,
returning this data.
Click here to view code image
function priceOrder(product, quantity, shippingMethod) {
const priceData = calculatePricingData(product, quantity);
const price = applyShipping(priceData, shippingMethod);
return price;
}
function calculatePricingData(product, quantity) {
const basePrice = product.basePrice * quantity;
const discount = Math.max(quantity ­ product.discountThreshold, 0)
* product.basePrice * product.discountRate;
return {basePrice: basePrice, quantity: quantity, discount:discount};
}
function applyShipping(priceData, shippingMethod) {
const shippingPerCase = (priceData.basePrice > shippingMethod.discountThreshol? shippingMethod.discountedFee : shippingMethod.feePerCase;
const shippingCost = priceData.quantity * shippingPerCase;
const price = priceData.basePrice ­ priceData.discount + shippingCost;
return price;
}
I can’t resist tidying out those final constants.
Click here to view code image
function priceOrder(product, quantity, shippingMethod) {
const priceData = calculatePricingData(product, quantity);
return applyShipping(priceData, shippingMethod);
}
function calculatePricingData(product, quantity) {
const basePrice = product.basePrice * quantity;
const discount = Math.max(quantity ­ product.discountThreshold, 0)
* product.basePrice * product.discountRate;
return {basePrice: basePrice, quantity: quantity, discount:discount};
}
function applyShipping(priceData, shippingMethod) {
const shippingPerCase = (priceData.basePrice > shippingMethod.discountThreshol? shippingMethod.discountedFee : shippingMethod.feePerCase;
const shippingCost = priceData.quantity * shippingPerCase;
return priceData.basePrice ­ priceData.discount + shippingCost;
}
Chapter 7
Encapsulation
Perhaps the most important criteria to be used in decomposing modules is to identify
secrets that modules should hide from the rest of the system [Parnas]. Data structures
are the most common secrets, and I can hide data structures by encapsulating them
with Encapsulate Record (162) and Encapsulate Collection (170). Even primitive data
values can be encapsulated with Replace Primitive with Object (174)—the magnitude of
second­order benefits from doing this often surprises people. Temporary variables
often get in the way of refactoring—I have to ensure they are calculated in the right
order and their values are available to other parts of the code that need them. Using
Replace Temp with Query (178) is a great help here, particularly when splitting up an
overly long function.
Classes were designed for information hiding. In the previous chapter, I described a
way to form them with Combine Functions into Class (144). The common extract/inline
operations also apply to classes with Extract Class (182) and Inline Class (186).
As well as hiding the internals of classes, it’s often useful to hide connections between
classes, which I can do with Hide Delegate (189). But too much hiding leads to bloated
interfaces, so I also need its reverse: Remove Middle Man (192).
Classes and modules are the largest forms of encapsulation, but functions also
encapsulate their implementation. Sometimes, I may need to make a wholesale change
to an algorithm, which I can do by wrapping it in a function with Extract Function
(106) and applying Substitute Algorithm (195).