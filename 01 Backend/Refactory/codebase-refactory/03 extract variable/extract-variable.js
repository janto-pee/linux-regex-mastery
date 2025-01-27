

function price(order) {
    //price is base price ­ quantity discount + shipping
    return order.quantity * order.itemPrice - Math.max(0, order.quantity - 500) * order.itemPrice * 0.05 + Math.min(order.quantity * order.itemPrice * 0.1, 100)
}
// Simple as it may be, I can make it still easier to follow. First, I recognize that the base
// price is the multiple of the quantity and the item price.
// Click here to view code image
function price(order) {
    //price is base price ­ quantity discount + shipping
    return order.quantity * order.itemPrice - Math.max(0, order.quantity - 500) * order.itemPrice * 0.05 + Math.min(order.quantity * order.itemPrice * 0.1, 100)
}
// Once that understanding is in my head, I put it in the code by creating and naming a
// variable for it.
function price(order) {
    //price is base price ­ quantity discount + shipping
    const basePrice = order.quantity * order.itemPrice
    return order.quantity * order.itemPrice - Math.max(0, order.quantity - 500) * order.itemPrice * 0.05 + Math.min(order.quantity * order.itemPrice * 0.1, 100)
}
// Of course, just declaring and initializing a variable doesn’t do anything I also have to
// use it, so I replace the expression that I used as its source.
// Click here to view code image
function price(order) {
    //price is base price ­ quantity discount + shipping
    const basePrice = order.quantity * order.itemPrice
    return basePrice ­
    Math.max(0, order.quantity - 500) * order.itemPrice * 0.05 + Math.min(order.quantity * order.itemPrice * 0.1, 100)
}
// That same expression is used later on, so I can replace it with the variable there too.
// Click here to view code image
function price(order) {
    //price is base price ­ quantity discount + shipping
    const basePrice = order.quantity * order.itemPrice
    return basePrice ­
    Math.max(0, order.quantity - 500) * order.itemPrice * 0.05 + Math.min(basePrice * 0.1, 100)
}
// The next line is the quantity discount, so I can extract that too.
// Click here to view code image
function price(order) {
    //price is base price ­ quantity discount + shipping
    const basePrice = order.quantity * order.itemPrice
    const quantityDiscount = Math.max(0, order.quantity - 500) * order.itemPrice *return basePrice ­
    quantityDiscount +
        Math.min(basePrice * 0.1, 100)
}
// Finally, I finish with the shipping. As I do that, I can remove the comment, too, because
// it no longer says anything the code doesn’t say.
// Click here to view code image
function price(order) {
    const basePrice = order.quantity * order.itemPrice
    const quantityDiscount = Math.max(0, order.quantity - 500) * order.itemPrice *const shipping = Math.min(basePrice * 0.1, 100)
    return basePrice ­ quantityDiscount + shipping
}
// Example: With a Class
// Here’s the same code, but this time in the context of a class:
// Click here to view code image
class Order {
    constructor(aRecord) {
        this._data = aRecord
    }
    get quantity() { return this._data.quantity }
    get itemPrice() { return this._data.itemPrice }
    get price() {
        return this.quantity * this.itemPrice ­
        Math.max(0, this.quantity - 500) * this.itemPrice * 0.05 +
            Math.min(this.quantity * this.itemPrice * 0.1, 100)
    }
}
// In this case, I want to extract the same names, but I realize that the names apply to the
// Order as a whole, not just the calculation of the price. Since they apply to the whole
// order, I’m inclined to extract the names as methods rather than variables.
// Click here to view code image
class Order {
    constructor(aRecord) {
        this._data = aRecord
    }
    get quantity() { return this._data.quantity }
    get itemPrice() { return this._data.itemPrice }
    get price() {
        return this.basePrice ­ this.quantityDiscount + this.shipping
    }
    get basePrice() { return this.quantity * this.itemPrice }
    get quantityDiscount() {
        return Math.max(0, this.quantity - 500) * this.itemPriget shipping() { return Math.min(this.basePrice * 0.1, 100) }
    }