## EDITINGNOTIVATIE
INLINE CLASS
inverse of: Extract Class (182)
<!-- Motivation
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-------------------------------------------------------------------------------- -->
Inline Class is the inverse of Extract Class (182). I use Inline Class if a class is no longer
pulling its weight and shouldn’t be around any more. Often, this is the result of
refactoring that moves other responsibilities out of the class so there is little left. At that
point, I fold the class into another—one that makes most use of the runt class.
Another reason to use Inline Class is if I have two classes that I want to refactor into a
pair of classes with a different allocation of features. I may find it easier to first use
Inline Class to combine them into a single class, then Extract Class (182) to make the
new separation. This is a general approach when reorganizing things: Sometimes, it’s
easier to move elements one at a time from one context to another, but sometimes it’s
better to use an inline refactoring to collapse the contexts together, then use an extract
refactoring to separate them into different elements.
<!-- <!-- Mechanics
..........................................................................
..........................................................................
..........................................................................
..........................................................................
..........................................................................

 -->In the target class, create functions for all the public functions of the source class.
These functions should just delegate to the source class.
Change all references to source class methods so they use the target class’s
delegators instead. Test after each change.
Move all the functions and data from the source class into the target, testing after
each move, until the source class is empty.
Delete the source class and hold a short, simple funeral service.
Example
Here’s a class that holds a couple of pieces of tracking information for a shipment.
Click here to view code image
class TrackingInformation {
get shippingCompany() {return this._shippingCompany;}
set shippingCompany(arg) {this._shippingCompany = arg;}
get trackingNumber() {return this._trackingNumber;}
set trackingNumber(arg) {this._trackingNumber = arg;}
get display() {
return `${this.shippingCompany}: ${this.trackingNumber}`;
}
}
It’s used as part of a shipment class.
class Shipment…
Click here to view code image
get trackingInfo() {
return this._trackingInformation.display;
}
get trackingInformation() {return this._trackingInformation;}
set trackingInformation(aTrackingInformation) {
this._trackingInformation = aTrackingInformation;
}
While this class may have been worthwhile in the past, I no longer feel it’s pulling its
weight, so I want to inline it into Shipment.
I start by looking at places that are invoking the methods of TrackingInformation.
caller…
Click here to view code image
aShipment.trackingInformation.shippingCompany = request.vendor;
I’m going to move all such functions to Shipment, but I do it slightly differently to how
I usually do Move Function (198). In this case, I start by putting a delegating method
into the shipment, and adjusting the client to call that.
class Shipment…
Click here to view code image
set shippingCompany(arg) {this._trackingInformation.shippingCompany = arg;}
caller…
Click here to view code image
aShipment.trackingInformation.shippingCompany = request.vendor;
I do this for all the elements of tracking information that are used by clients. Once I’ve
done that, I can move all the elements of the tracking information over into the
shipment class.
I start by applying Inline Function (115) to the display method.
class Shipment…
Click here to view code image
get trackingInfo() {
return `${this.shippingCompany}: ${this.trackingNumber}`;
}
I move the shipping company field.
Click here to view code image
get shippingCompany() {return this._trackingInformation._shippingCompany;}
set shippingCompany(arg) {this._trackingInformation._shippingCompany = arg;}
I don’t use the full mechanics for Move Field (207) since in this case I only reference
shippingCompany from Shipment which is the target of the move. I thus don’t need
the steps that put a reference from the source to the target.
I continue until everything is moved over. Once I’ve done that, I can delete the tracking
information class.
class Shipment…
Click here to view code image
get trackingInfo() {
return `${this.shippingCompany}: ${this.trackingNumber}`;
}
get shippingCompany() {return this._shippingCompany;}
set shippingCompany(arg) {this._shippingCompany = arg;}
get trackingNumber() {return this._trackingNumber;}
set trackingNumber(arg) {this._trackingNumber = arg;}
