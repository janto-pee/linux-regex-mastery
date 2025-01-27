
// Example: No Variables Out of Scope
// In the simplest case, Extract Function is trivially easy.
// Click here to view code image
function printOwing(invoice) {
    let outstanding = 0
    console.log("***********************")
    console.log("**** Customer Owes ****")
    console.log("***********************")
    // calculate outstanding
    for (const o of invoice.orders) {
        outstanding += o.amount
    }
    // record due date
    const today = Clock.today
    invoice.dueDate = new Date(today.getFullYear(), today.getMonth(), today.getDate)
    //print details
    console.log(`name: ${invoice.customer}`)
    console.log(`amount: ${outstanding}`)
    console.log(`due: ${invoice.dueDate.toLocaleDateString()}`)
}
// You may be wondering what the Clock.today is about. It is a Clock Wrapper [mfcw]—an object that wraps calls to the system clock. I avoid putting direct calls to
// things like Date.now() in my code, because it leads to nondeterministic tests and
// makes it dif icult to reproduce error conditions when diagnosing failures.
// It’s easy to extract the code that prints the banner. I just cut, paste, and put in a call:
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
    invoice.dueDate = new Date(today.getFullYear(), today.getMonth(), today.getDate)
    //print details
    console.log(`name: ${invoice.customer}`)
    console.log(`amount: ${outstanding}`)
    console.log(`due: ${invoice.dueDate.toLocaleDateString()}`)
}
function printBanner() {
    console.log("***********************")
    console.log("**** Customer Owes ****")
    console.log("***********************")
}
// Similarly, I can take the printing of details and extract that too:
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
    invoice.dueDate = new Date(today.getFullYear(), today.getMonth(), today.getDatprintDetails())
    printDetails()

    function printDetails() {
        console.log(`name: ${invoice.customer}`)
        console.log(`amount: ${outstanding}`)
        console.log(`due: ${invoice.dueDate.toLocaleDateString()}`)
    }
}