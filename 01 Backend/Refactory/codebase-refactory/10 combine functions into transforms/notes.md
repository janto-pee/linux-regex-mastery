
COMBINE FUNCTIONS INTO TRANSFORM
COMBINE FUNCTIONS INTO TRANSFORM
<!-- Motivation
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-------------------------------------------------------------------------------- -->
Software often involves feeding data into programs that calculate various derived
information from it. These derived values may be needed in several places, and those
calculations are often repeated wherever the derived data is used. I prefer to bring all of
these derivations together, so I have a consistent place to find and update them and
avoid any duplicate logic.
One way to do this is to use a data transformation function that takes the source data as
input and calculates all the derivations, putting each derived value as a field in the
output data. Then, to examine the derivations, all I need do is look at the transform
function.
An alternative to Combine Functions into Transform is Combine Functions into Class
(144) that moves the logic into methods on a class formed from the source data. Either
of these refactorings are helpful, and my choice will often depend on the style of
programming already in the software. But there is one important difference: Using a
class is much better if the source data gets updated within the code. Using a transform
stores derived data in the new record, so if the source data changes, I will run into
inconsistencies.
One of the reasons I like to do combine functions is to avoid duplication of the
derivation logic. I can do that just by using Extract Function (106) on the logic, but it’s
often difficult to find the functions unless they are kept close to the data structures they
operate on. Using a transform (or a class) makes it easy to find and use them.
<!-- <!-- Mechanics
..........................................................................
..........................................................................
..........................................................................
..........................................................................
..........................................................................

 -->Create a transformation function that takes the record to be transformed and
returns the same values.
This will usually involve a deep copy of the record. It is often worthwhile to write a
test to ensure the transform does not alter the original record.
Pick some logic and move its body into the transform to create a new field in the
record. Change the client code to access the new field.
If the logic is complex, use Extract Function (106) first.
Test.
Repeat for the other relevant functions.
Example
Where I grew up, tea is an important part of life—so much that I can imagine a special
utility that provides tea to the populace that’s regulated like a utility. Every month, the
utility gets a reading of how much tea a customer has acquired.
Click here to view code image
reading = {customer: "ivan", quantity: 10, month: 5, year: 2017};
Code in various places calculates various consequences of this tea usage. One such
calculation is the base monetary amount that’s used to calculate the charge for the
customer.
client 1…
Click here to view code image
const aReading = acquireReading();
const baseCharge = baseRate(aReading.month, aReading.year) * aReading.quantity;
Another is the amount that should be taxed—which is less than the base amount since
the government wisely considers that every citizen should get some tea tax free.
client 2…
Click here to view code image
const aReading = acquireReading();
const base = (baseRate(aReading.month, aReading.year) * aReading.quantity);
const taxableCharge = Math.max(0, base ­ taxThreshold(aReading.year));
Looking through this code, I see these calculations repeated in several places. Such
duplication is asking for trouble when they need to change (and I’d bet it’s “when” not
“if”). I can deal with this repetition by using Extract Function (106) on these
calculations, but such functions often end up scattered around the program making it
hard for future developers to realize they are there. Indeed, looking around I discover
such a function, used in another area of the code.
client 3…
Click here to view code image
const aReading = acquireReading();
const basicChargeAmount = calculateBaseCharge(aReading);
function calculateBaseCharge(aReading) {
return baseRate(aReading.month, aReading.year) * aReading.quantity;
}
One way of dealing with this is to move all of these derivations into a transformation
step that takes the raw reading and emits a reading enriched with all the common
derived results.
I begin by creating a transformation function that merely copies the input object.
Click here to view code image
function enrichReading(original) {
const result = _.cloneDeep(original);
return result;
}
I’m using the cloneDeep from lodash to create a deep copy.
When I’m applying a transformation that produces essentially the same thing but with
additional information, I like to name it using “enrich”. If it were producing something
I felt was different, I would name it using “transform”.
I then pick one of the calculations I want to change. First, I enrich the reading it uses
with the current one that does nothing yet.
client 3…
Click here to view code image
const rawReading = acquireReading();
const aReading = enrichReading(rawReading);
const basicChargeAmount = calculateBaseCharge(aReading);
I use Move Function (198) on calculateBaseCharge to move it into the enrichment
calculation.
Click here to view code image
function enrichReading(original) {
const result = _.cloneDeep(original);
result.baseCharge = calculateBaseCharge(result);
return result;
}
Within the transformation function, I’m happy to mutate a result object, instead of
copying each time. I like immutability, but most common languages make it difficult to
work with. I’m prepared to go through the extra effort to support it at boundaries, but
will mutate within smaller scopes. I also pick my names (using aReading as the
accumulating variable) to make it easier to move the code into the transformer
function.
I change the client that uses that function to use the enriched field instead.
client 3…
Click here to view code image
const rawReading = acquireReading();
const aReading = enrichReading(rawReading);
const basicChargeAmount = aReading.baseCharge;
Once I’ve moved all calls to calculateBaseCharge, I can nest it inside
enrichReading. That would make it clear that clients that need the calculated base
charge should use the enriched record.
One trap to beware of here. When I write enrichReading like this, to return the
enriched reading, I’m implying that the original reading record isn’t changed. So it’s
wise for me to add a test.
Click here to view code image
it('check reading unchanged', function() {
const baseReading = {customer: "ivan", quantity: 15, month: 5, year: 2017};
const oracle = _.cloneDeep(baseReading);
enrichReading(baseReading);
assert.deepEqual(baseReading, oracle);
});
I can then change client 1 to also use the same field.
client 1…
Click here to view code image
const rawReading = acquireReading();
const aReading = enrichReading(rawReading);
const baseCharge = aReading.baseCharge;
There is a good chance I can then use Inline Variable (123) on baseCharge too.
Now I turn to the taxable amount calculation. My first step is to add in the
transformation function.
Click here to view code image
const rawReading = acquireReading();
const aReading = enrichReading(rawReading);
const base = (baseRate(aReading.month, aReading.year) * aReading.quantity);
const taxableCharge = Math.max(0, base ­ taxThreshold(aReading.year));
I can immediately replace the calculation of the base charge with the new field. If the
calculation was complex, I could Extract Function (106) first, but here it’s simple
enough to do in one step.
Click here to view code image
const rawReading = acquireReading();
const aReading = enrichReading(rawReading);
const base = aReading.baseCharge;
const taxableCharge = Math.max(0, base ­ taxThreshold(aReading.year));
Once I’ve tested that that works, I apply Inline Variable (123):
Click here to view code image
const rawReading = acquireReading();
const aReading = enrichReading(rawReading);
const taxableCharge = Math.max(0, aReading.baseCharge ­ taxThreshold(aReading.yeand move that computation into the transformer:
Click here to view code image
function enrichReading(original) {
const result = _.cloneDeep(original);
result.baseCharge = calculateBaseCharge(result);
result.taxableCharge = Math.max(0, result.baseCharge ­ taxThreshold(result.yeareturn result;
}
I modify the original code to use the new field.
Click here to view code image
const rawReading = acquireReading();
const aReading = enrichReading(rawReading);
const taxableCharge = aReading.taxableCharge;
Once I’ve tested that, it’s likely I would be able to use Inline Variable (123) on
taxableCharge.
One big problem with an enriched reading like this is: What happens should a client
change a data value? Changing, say, the quantity field would result in data that’s
inconsistent. To avoid this in JavaScript, my best option is to use Combine Functions
into Class (144) instead. If I’m in a language with immutable data structures, I don’t
have this problem, so its more common to see transforms in those languages. But even
in languages without immutability, I can use transforms if the data appears in a readonly context, such as deriving data to display on a web page.