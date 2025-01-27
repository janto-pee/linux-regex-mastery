
RENAME VARIABLE
<!-- Motivation
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-------------------------------------------------------------------------------- -->
Naming things well is the heart of clear programming. Variables can do a lot to explain
what I’m up to—if I name them well. But I frequently get my names wrong—sometimes
because I’m not thinking carefully enough, sometimes because my understanding of the
problem improves as I learn more, and sometimes because the program’s purpose
changes as my users’ needs change.
Even more than most program elements, the importance of a name depends on how
widely it’s used. A variable used in a one­line lambda expression is usually easy to
follow—I often use a single letter in that case since the variable’s purpose is clear from
its context. Parameters for short functions can often be terse for the same reason,
although in a dynamically typed language like JavaScript, I do like to put the type into
the name (hence parameter names like aCustomer).
Persistent fields that last beyond a single function invocation require more careful
naming. This is where I’m likely to put most of my attention.
<!-- <!-- Mechanics
..........................................................................
..........................................................................
..........................................................................
..........................................................................
..........................................................................

 -->If the variable is used widely, consider Encapsulate Variable (132).
Find all references to the variable, and change every one.
If there are references from another code base, the variable is a published variable,
and you cannot do this refactoring.
If the variable does not change, you can copy it to one with the new name, then
change gradually, testing after each change.
Test.
Example
The simplest case for renaming a variable is when it’s local to a single function: a temp
or argument. It’s too trivial for even an example: I just find each reference and change
it. After I’m done, I test to ensure I didn’t mess up.
Problems occur when the variable has a wider scope than just a single function. There
may be a lot of references all over the code base:
let tpHd = "untitled";
Some references access the variable:
result += `<h1>${tpHd}</h1>`;
Others update it:
tpHd = obj['articleTitle'];
My usual response to this is apply Encapsulate Variable (132).
Click here to view code image
result += `<h1>${title()}</h1>`;
setTitle(obj['articleTitle']);
function title() {return tpHd;}
function setTitle(arg) {tpHd = arg;}
At this point, I can rename the variable.
Click here to view code image
let _title = "untitled";
function title() {return _title;}
function setTitle(arg) {_title = arg;}
I could continue by inlining the wrapping functions so all callers are using the variable
directly. But I’d rarely want to do this. If the variable is used widely enough that I feel
the need to encapsulate it in order to change its name, it’s worth keeping it
encapsulated behind functions for the future.
In cases where I was going to inline, I’d call the getting function getTitle and not use
an underscore for the variable name when I rename it.
Renaming a Constant
If I’m renaming a constant (or something that acts like a constant to clients) I can avoid
encapsulation, and still do the rename gradually, by copying. If the original declaration
looks like this:
Click here to view code image
const cpyNm = "Acme Gooseberries";
I can begin the renaming by making a copy:
Click here to view code image
const companyName = "Acme Gooseberries";
const cpyNm = companyName;
With the copy, I can gradually change references from the old name to the new name.
When I’m done, I remove the copy. I prefer to declare the new name and copy to the old
name if it makes it a tad easier to remove the old name and put it back again should a
test fail.
This works for constants as well as for variables that are read­only to clients (such as an
exported variable in JavaScript).