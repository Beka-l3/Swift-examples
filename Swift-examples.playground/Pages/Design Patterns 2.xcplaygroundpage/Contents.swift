import Foundation


// MARK: Most frequently used DP in Swift


// MARK: - Builder
/// The Builder pattern is a `creational` design pattern that allows you to create complex objects from simple objects step by step.
/// This design pattern helps you use the same code for creating different object views.

/// Imagine a complex object that requires incremental initialization of multiple fields and nested objects.
/// Typically, the initialization code for such objects is hidden inside a mammoth constructor with dozens of parameters.
/// Or even worse, it can be scattered all over the client code

/// The Builder design pattern calls for separating the construction of an object from its own class.
/// The construction of this object is instead assigned to special objects called builders and split into multiple steps.
/// To create an object, you successively call builder methods.
/// And you don’t need to go through all the steps – only those required for creating an object with a particular configuration.


/// ``When to Apply``
/// - when you want to avoid using a telescopic constructor (when a constructor has too many parameters, it gets difficult to read and manage)
/// - when your code needs to create different views of a specific object
/// - when you need to compose complex objects


/// ``Example``
/// Suppose you’re developing an iOS application for a restaurant and you need to implement ordering functionality.
/// You can introduce two structures, Dish and Order, and with the help of the OrderBuilder object,
/// you can compose orders with different sets of dishes.
// Design Patterns: Builder

// Models
enum DishCategory: Int {
    case firstCourses, mainCourses, garnishes, drinks
}

struct Dish {
    var name: String
    var price: Float
}

struct OrderItem {
    var dish: Dish
    var count: Int
}

struct Order {
    var firstCourses: [OrderItem] = []
    var mainCourses: [OrderItem] = []
    var garnishes: [OrderItem] = []
    var drinks: [OrderItem] = []
    
    var price: Float {
        let items = firstCourses + mainCourses + garnishes + drinks
        return items.reduce(Float(0), { $0 + $1.dish.price * Float($1.count) })
    }
}

// Builder
class OrderBuilder {
    private var order: Order?
    
    func reset() {
        order = Order()
    }
    
    func setFirstCourse(_ dish: Dish) {
        set(dish, at: order?.firstCourses, withCategory: .firstCourses)
    }
    
    func setMainCourse(_ dish: Dish) {
        set(dish, at: order?.mainCourses, withCategory: .mainCourses)
    }
    
    func setGarnish(_ dish: Dish) {
        set(dish, at: order?.garnishes, withCategory: .garnishes)
    }
    
    func setDrink(_ dish: Dish) {
        set(dish, at: order?.drinks, withCategory: .drinks)
    }
    
    func getResult() -> Order? {
        return order ?? nil
    }
    
    private func set(_ dish: Dish, at orderCategory: [OrderItem]?, withCategory dishCategory: DishCategory) {
        guard let orderCategory = orderCategory else {
            return
        }
        
        var item: OrderItem! = orderCategory.filter( { $0.dish.name == dish.name } ).first
        
        guard item == nil else {
            item.count += 1
            return
        }
        
        item = OrderItem(dish: dish, count: 1)
        
        switch dishCategory {
        case .firstCourses:
            order?.firstCourses.append(item)
        case .mainCourses:
            order?.mainCourses.append(item)
        case .garnishes:
            order?.garnishes.append(item)
        case .drinks:
            order?.drinks.append(item)
        }
    }
}


func foo1() { // Usage
    let steak = Dish(name: "Steak", price: 2.30)
    let chips = Dish(name: "Chips", price: 1.20)
    let coffee = Dish(name: "Coffee", price: 0.80)
    
    let builder = OrderBuilder()
    builder.reset()
    builder.setMainCourse(steak)
    builder.setGarnish(chips)
    builder.setDrink(coffee)
    
    let order = builder.getResult()
    order?.price
    
    // Result:
    // 4.30
}







// MARK: - Adapter
/// Adapter is a structural design pattern that allows objects with incompatible interfaces to work together.
/// In other words, it transforms the interface of an object to adapt it to a different object.

/// An adapter wraps an object, therefore concealing it completely from another object.
/// For example, you could wrap an object that handles meters with an adapter that converts data into feet.


/// ``When to Apply``
/// - when you want to use a third-party class but its interface doesn’t match the rest of your application’s code;
/// - when you need to use several existing subclasses but they lack particular functionality and, on top of that, you can’t extend the superclass.


/// ``Example``
/// Suppose you want to implement a calendar and event management functionality in your iOS application.
/// To do this, you should integrate the `EventKit` framework and adapt the `Event` model from the framework to the model in your application.
///  An Adapter can wrap the model of the framework and make it compatible with the model in your application.


import EventKit

// Models
protocol Event: AnyObject {
    var title: String { get }
    var startDate: String { get }
    var endDate: String { get }
}

extension Event {
    var description: String {
        return "Name: \(title)\nEvent start: \(startDate)\nEvent end: \(endDate)"
    }
}

class LocalEvent: Event {
    var title: String
    var startDate: String
    var endDate: String
    
    init(title: String, startDate: String, endDate: String) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
    }
}


// Adapter
class EKEventAdapter: Event {
    private var event: EKEvent
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        return dateFormatter
    }()
    
    var title: String {
        return event.title
    }
    var startDate: String {
        return dateFormatter.string(from: event.startDate)
    }
    var endDate: String {
        return dateFormatter.string(from: event.endDate)
    }
    
    init(event: EKEvent) {
        self.event = event
    }
}


func foo2() { // Usage
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
    
    let eventStore = EKEventStore()
    let event = EKEvent(eventStore: eventStore)
    event.title = "Design Pattern Meetup"
    event.startDate = dateFormatter.date(from: "06/29/2018 18:00")
    event.endDate = dateFormatter.date(from: "06/29/2018 19:30")
    
    let adapter = EKEventAdapter(event: event)
    adapter.description
    
    // Result:
    // Name: Design Pattern Meetup
    // Event start: 06-29-2018 18:00
    // Event end: 06-29-2018 19:30
}




