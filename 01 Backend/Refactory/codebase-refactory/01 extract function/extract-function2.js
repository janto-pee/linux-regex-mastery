// USING LOCAL VARIABLE

function printOwing(invoice) {
    let outstanding = 0
    printBanner()
    // calculate outstanding
    for (const o of invoice.orders) {
        outstanding += o.amount
    }
    // record due date
    const today = Clock.today
    invoice.dueDate = new Date(today.getFullYear(), today.getMonth(), today.getDate())
    //print details
    console.log(`name: ${invoice.customer}`)
    console.log(`amount: ${outstanding}`)
    console.log(`due: ${invoice.dueDate.toLocaleDateString()}`)
}
// I can extract the printing of details passing two parameters:
// Click here to view code image
function printOwing(invoice) {
    let outstanding = 0
    printBanner()
    // calculate outstanding
    for (const o of invoice.orders) {
        outstanding += o.amount
    }
    // record due date
    const today = Clock.today
    invoice.dueDate = new Date(today.getFullYear(), today.getMonth(), today.getDatprintDetails(invoice, outstanding))
    printDetails(invoice, outstanding)
}
function printDetails(invoice, outstanding) {
    console.log(`name: ${invoice.customer}`)
    console.log(`amount: ${outstanding}`)
    console.log(`due: ${invoice.dueDate.toLocaleDateString()}`)
}
// The same is true if the local variable is a structure (such as an array, record, or object)
// and I modify that structure. So, I can similarly extract the setting of the due date:
// Click here to view code image
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
function recordDueDate(invoice) {
    const today = Clock.today
    invoice.dueDate = new Date(today.getFullYear(), today.getMonth(), today.getDate())
}