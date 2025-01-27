function rating(aDriver) {
return moreThanFiveLateDeliveries(aDriver) ? 2 : 1
}
function moreThanFiveLateDeliveries(aDriver) {
return aDriver.numberOfLateDeliveries > 5
}

// I can just take the return expression of the called function and paste it into the caller to
// replace the call.

function rating(aDriver) {
return aDriver.numberOfLateDeliveries > 5 ? 2 : 1
}
// But it can be a little more involved than that, requiring me to do more work to fit the
// code into its new home. Consider the case where I start with this slight variation on the
// earlier initial code.
// Click here to view code image
function rating(aDriver) {
return moreThanFiveLateDeliveries(aDriver) ? 2 : 1
}
function moreThanFiveLateDeliveries(dvr) {
return dvr.numberOfLateDeliveries > 5
}
// Almost the same, but now the declared argument on
// moreThanFiveLateDeliveries is different to the name of the passed­in argument.
// So I have to fit the code a little when I do the inline.
function rating(aDriver) {
return aDriver.numberOfLateDeliveries > 5 ? 2 : 1
}
// It can be even more involved than this. Consider this code:
// Click here to view code image
function reportLines(aCustomer) {
const lines = []
gatherCustomerData(lines, aCustomer)
return lines
}
function gatherCustomerData(out, aCustomer) {
out.push(["name", aCustomer.name])
out.push(["location", aCustomer.location])
}
// Inlining gatherCustomerData into reportLines isn’t a simple cut and paste. It’s
// not too complicated, and most times I would still do this in one go, with a bit of fitting.
// But to be cautious, it may make sense to move one line at a time. So I’d start with using
// Move Statements to Callers (217) on the first line (I’d do it the simple way with a cut,
// paste, and fit).
function reportLines(aCustomer) {
const lines = []
lines.push(["name", aCustomer.name])
gatherCustomerData(lines, aCustomer)
return lines
}
function gatherCustomerData(out, aCustomer) {
out.push(["name", aCustomer.name])
out.push(["location", aCustomer.location])
}
// I then continue with the other lines until I’m done.
// Click here to view code image
function reportLines(aCustomer) {
const lines = []
lines.push(["name", aCustomer.name])
lines.push(["location", aCustomer.location])
return lines
}