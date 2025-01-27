## EDITINGNOTIVATIE
HIDE DELEGATE
inverse of: Remove Middle Man (192)
<!-- Motivation
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-------------------------------------------------------------------------------- -->
One of the keys—if not the key—to good modular design is encapsulation.
Encapsulation means that modules need to know less about other parts of the system.
Then, when things change, fewer modules need to be told about the change—which
makes the change easier to make.
When we are first taught about object orientation, we are told that encapsulation means
hiding our fields. As we become more sophisticated, we realize there is more that we
can encapsulate.
If I have some client code that calls a method defined on an object in a field of a server
object, the client needs to know about this delegate object. If the delegate changes its
interface, changes propagate to all the clients of the server that use the delegate. I can
remove this dependency by placing a simple delegating method on the server that hides
the delegate. Then any changes I make to the delegate propagate only to the server and
not to the clients.
<!-- <!-- Mechanics
..........................................................................
..........................................................................
..........................................................................
..........................................................................
..........................................................................

 -->For each method on the delegate, create a simple delegating method on the server.
Adjust the client to call the server. Test after each change.
If no client needs to access the delegate anymore, remove the server’s accessor for
the delegate.
Test.
Example
I start with a person and a department.
class Person…
Click here to view code image
constructor(name) {
this._name = name;
}
get name() {return this._name;}
get department() {return this._department;}
set department(arg) {this._department = arg;}
class Department…
Click here to view code image
get chargeCode() {return this._chargeCode;}
set chargeCode(arg) {this._chargeCode = arg;}
get manager() {return this._manager;}
set manager(arg) {this._manager = arg;}
Some client code wants to know the manager of a person. To do this, it needs to get the
department first.
client code…
Click here to view code image
manager = aPerson.department.manager;
This reveals to the client how the department class works and that the department is
responsible for tracking the manager. I can reduce this coupling by hiding the
department class from the client. I do this by creating a simple delegating method on
person:
class Person…
Click here to view code image
get manager() {return this._department.manager;}
I now need to change all clients of person to use this new method:
client code…
Click here to view code image
manager = aPerson.department.manager;
Once I’ve made the change for all methods of department and for all the clients of
person, I can remove the department accessor on person.
