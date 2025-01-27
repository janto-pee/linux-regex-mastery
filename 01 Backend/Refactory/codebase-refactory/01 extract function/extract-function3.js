function printOwing(invoice) {
    let outstanding = 0
    printBanner()
    // calculate outstanding
    for (const o of invoice.orders) {
        outstanding += o.amount
    }
    recordDueDate(invoice)
    printDetails(invoice, outstanding)
}
// I’ve shown the previous refactorings all in one step, since they were straightforward,
// but this time I’ll take it one step at a time from the mechanics.
// First, I’ll slide the declaration next to its use.
// Click here to view code image
function printOwing(invoice) {
    printBanner()
    // calculate outstanding
    let outstanding = 0
    for (const o of invoice.orders) {
        outstanding += o.amount
    }
    recordDueDate(invoice)
    printDetails(invoice, outstanding)
}
// I then copy the code I want to extract into a target function.
// Click here to view code image
function printOwing(invoice) {
    printBanner()
    // calculate outstanding
    let outstanding = 0
    for (const o of invoice.orders) {
        outstanding += o.amount
    }
    recordDueDate(invoice)
    printDetails(invoice, outstanding)
}
function calculateOutstanding(invoice) {
    let outstanding = 0
    for (const o of invoice.orders) {
        outstanding += o.amount
    }
    return outstanding
}