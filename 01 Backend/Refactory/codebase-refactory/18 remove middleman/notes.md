## EDITINGNOTIVATIE
REMOVE MIDDLE MAN
inverse of: Hide Delegate (189)
<!-- Motivation
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-------------------------------------------------------------------------------- -->
In the for Hide Delegate (189), I talked about the advantages of
encapsulating the use of a delegated object. There is a price for this. Every time the
client wants to use a new feature of the delegate, I have to add a simple delegating
method to the server. After adding features for a while, I get irritated with all this
forwarding. The server class is just a middle man (Middle Man (81)), and perhaps it’s
time for the client to call the delegate directly. (This smell often pops up when people
get overenthusiastic about following the Law of Demeter, which I’d like a lot more if it
were called the Occasionally Useful Suggestion of Demeter.)
It’s hard to figure out what the right amount of hiding is. Fortunately, with Hide
Delegate (189) and Remove Middle Man, it doesn’t matter so much. I can adjust my
code as time goes on. As the system changes, the basis for how much I hide also
changes. A good encapsulation six months ago may be awkward now. Refactoring
means I never have to say I’m sorry—I just fix it.
<!-- <!-- Mechanics
..........................................................................
..........................................................................
..........................................................................
..........................................................................
..........................................................................

 -->Create a getter for the delegate.
For each client use of a delegating method, replace the call to the delegating method
by chaining through the accessor. Test after each replacement.
If all calls to a delegating method are replaced, you can delete the delegating
method.
With automated refactorings, you can use Encapsulate Variable (132) on the
delegate field and then Inline Function (115) on all the methods that use it.
Example
I begin with a person class that uses a linked department object to determine a
manager. (If you’re reading this book sequentially, this example may look eerily
familiar.)
client code…
manager = aPerson.manager;
class Person…
Click here to view code image
get manager() {return this._department.manager;}
class Department…
Click here to view code image
get manager() {return this._manager;}
This is simple to use and encapsulates the department. However, if lots of methods are
doing this, I end up with too many of these simple delegations on the person. That’s
when it is good to remove the middle man. First, I make an accessor for the delegate:
class Person…
Click here to view code image
get department() {return this._department;}
Now I go to each client at a time and modify them to use the department directly.
client code…
Click here to view code image
manager = aPerson.department.manager;
Once I’ve done this with all the clients, I can remove the manager method from
Person. I can repeat this process for any other simple delegations on Person.
I can do a mixture here. Some delegations may be so common that I’d like to keep them
to make client code easier to work with. There is no absolute reason why I should either
hide a delegate or remove a middle man—particular circumstances suggest which
approach to take, and reasonable people can differ on what works best.
If I have automated refactorings, then there’s a useful variation on these steps. First, I
use Encapsulate Variable (132) on department. This changes the manager getter to
use the public department getter:
class Person…
Click here to view code image
get manager() {return this.department.manager;}
The change is rather too subtle in JavaScript, but by removing the underscore from
department I’m using the new getter rather than accessing the field directly.
Then I apply Inline Function (115) on the manager method to replace all the callers at
once.
