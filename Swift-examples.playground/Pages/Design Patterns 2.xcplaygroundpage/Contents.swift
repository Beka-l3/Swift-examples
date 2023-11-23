import Foundation


// MARK: Most frequently used DP in Swift


// MARK: - Builder
/// The Builder pattern is a ``creational`` design pattern that `allows you to create complex objects from simple objects step by step`.
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
        order ?? nil
    }
    
    
    private func set(_ dish: Dish, at orderCategory: [OrderItem]?, withCategory dishCategory: DishCategory) {
        guard let orderCategory = orderCategory else { return }
        
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
/// Adapter is a ``structural`` design pattern that `allows objects with incompatible interfaces to work together`.
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
        "Name: \(title)\nEvent start: \(startDate)\nEvent end: \(endDate)"
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
        event.title
    }
    
    var startDate: String {
        dateFormatter.string(from: event.startDate)
    }
    
    var endDate: String {
        dateFormatter.string(from: event.endDate)
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





// MARK: - Decorator
/// The Decorator pattern is a ``structural`` design pattern
/// that allows you to `dynamically attach new functionalities` to an object by wrapping them in useful wrappers

/// No wonder this design pattern is also called the `Wrapper` design pattern.
/// This name describes more precisely the core idea behind this pattern:
///  you place a target object inside another wrapper object
///  that triggers the basic behavior of the target object and adds its own behavior to the result.

/// Both objects share the same interface,
/// so it doesn’t matter for a user which of the objects they interact with − clean or wrapped.
/// You can use several wrappers simultaneously and get the combined behavior of all these wrappers

/// ``When to use?``
/// - when you want to add responsibilities to objects dynamically and conceal those objects from the code that uses them;
/// - when it’s impossible to extend responsibilities of an object through inheritance.

/// ``Example``
/// Imagine you need to implement data management in your iOS application.
/// You could create two decorators: `EncryptionDecorator` for encrypting
/// and decrypting data and `EncodingDecorator` for encoding and decoding.


// Helpers (may be not include in blog post)
func encryptString(_ string: String, with encryptionKey: String) -> String {
    let stringBytes = [UInt8](string.utf8)
    let keyBytes = [UInt8](encryptionKey.utf8)
    var encryptedBytes: [UInt8] = []
    
    for stringByte in stringBytes.enumerated() {
        encryptedBytes.append(stringByte.element ^ keyBytes[stringByte.offset % encryptionKey.count])
    }
    
    return String(bytes: encryptedBytes, encoding: .utf8)!
}

func decryptString(_ string: String, with encryptionKey: String) -> String {
    let stringBytes = [UInt8](string.utf8)
    let keyBytes = [UInt8](encryptionKey.utf8)
    var decryptedBytes: [UInt8] = []
    
    for stringByte in stringBytes.enumerated() {
        decryptedBytes.append(stringByte.element ^ keyBytes[stringByte.offset % encryptionKey.count])
    }
    
    return String(bytes: decryptedBytes, encoding: .utf8)!
}


// Services
protocol DataSource: AnyObject {
    
    func writeData(_ data: Any)
    func readData() -> Any
    
}


class UserDefaultsDataSource: DataSource {
    
    private let userDefaultsKey: String
    
    init(userDefaultsKey: String) {
        self.userDefaultsKey = userDefaultsKey
    }
    
    func writeData(_ data: Any) {
        UserDefaults.standard.set(data, forKey: userDefaultsKey)
    }
    
    func readData() -> Any {
        UserDefaults.standard.value(forKey: userDefaultsKey)!
    }
    
}


// Decorators
class DataSourceDecorator: DataSource {
    
    let wrappee: DataSource
    
    
    init(wrappee: DataSource) {
        self.wrappee = wrappee
    }
    
    
    func writeData(_ data: Any) {
        wrappee.writeData(data)
    }
    
    func readData() -> Any {
        wrappee.readData()
    }
    
}


class EncodingDecorator: DataSourceDecorator {
    
    private let encoding: String.Encoding
    
    
    init(wrappee: DataSource, encoding: String.Encoding) {
        self.encoding = encoding
        super.init(wrappee: wrappee)
    }
    
    
    override func writeData(_ data: Any) {
        let stringData = (data as! String).data(using: encoding)!
        wrappee.writeData(stringData)
    }
    
    override func readData() -> Any {
        let data = wrappee.readData() as! Data
        return String(data: data, encoding: encoding)!
    }
    
}


class EncryptionDecorator: DataSourceDecorator {
    
    private let encryptionKey: String
    
    
    init(wrappee: DataSource, encryptionKey: String) {
        self.encryptionKey = encryptionKey
        super.init(wrappee: wrappee)
    }
    
    
    override func writeData(_ data: Any) {
        let encryptedString = encryptString(data as! String, with: encryptionKey)
        wrappee.writeData(encryptedString)
    }
    
    override func readData() -> Any {
        let encryptedString = wrappee.readData() as! String
        return decryptString(encryptedString, with: encryptionKey)
    }
}


func foo3() { // Usage
    
    var source: DataSource = UserDefaultsDataSource(userDefaultsKey: "decorator")
    source = EncodingDecorator(wrappee: source, encoding: .utf8)
    source = EncryptionDecorator(wrappee: source, encryptionKey: "secret")
    source.writeData("Design Patterns")
    source.readData() as! String
    
    // Result:
    // Design Patterns
}





// MARK: - Facade
/// The Facade pattern is a ``structural`` design pattern that provides a `simple interface` to a library, framework, or complex system of classes.

/// Imagine that your code has to deal with multiple objects of a complex library or framework.
/// You need to initialize all these objects, keep track of the right order of dependencies, and so on.
/// As a result, the business logic of your classes gets intertwined with implementation details of other classes.
/// Such code is difficult to read and maintain.

/// The Facade pattern provides a simple interface for working with complex subsystems containing lots of classes.
/// The Facade pattern offers a simplified interface with limited functionality that you can extend by using a complex subsystem directly.
/// This simplified interface provides only the features a client needs while concealing all others.


/// ``When to use?``
/// - when you want to provide a simple or unified interface to a complex subsystem;
/// - when you need to decompose a subsystem into separate layers.


/// ``Example`` <(Service) that collects other services together>
/// Lots of modern mobile applications support audio recording and playback,
/// so let’s suppose you need to implement this functionality.

/// You could use the Facade pattern to hide the implementation of services responsible for the:
/// file system (FileService),
/// audio sessions (AudioSessionService),
/// audio recording (RecorderService),
/// and audio playback (PlayerService).

/// The Facade provides a simplified interface for this rather complex system of classes.
import AVFoundation

// Services (may be not include in blog post)
struct FileService {
    
    private var documentDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    var contentsOfDocumentDirectory: [URL] {
        return try! FileManager.default.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
    }
    
    func path(withPathComponent component: String) -> URL {
        return documentDirectory.appendingPathComponent(component)
    }
    
    func removeItem(at index: Int) {
        let url = contentsOfDocumentDirectory[index]
        try! FileManager.default.removeItem(at: url)
    }
    
}


protocol AudioSessionServiceDelegate: AnyObject {
    
    func audioSessionService(_ audioSessionService: AudioSessionService, recordPermissionDidAllow allowed: Bool)
    
}


class AudioSessionService {
    
    weak var delegate: AudioSessionServiceDelegate?
    
    
    func setupSession() {
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, options: [.defaultToSpeaker])
        try! AVAudioSession.sharedInstance().setActive(true)
        
        AVAudioSession.sharedInstance().requestRecordPermission { [weak self] allowed in
            DispatchQueue.main.async {
                guard let strongSelf = self, let delegate = strongSelf.delegate else {
                    return
                }
                
                delegate.audioSessionService(strongSelf, recordPermissionDidAllow: allowed)
            }
        }
    }
    
    func deactivateSession() {
        try! AVAudioSession.sharedInstance().setActive(false)
    }
    
}

struct RecorderService {
    
    private var isRecording = false
    private var recorder: AVAudioRecorder!
    private var url: URL
    
    
    init(url: URL) {
        self.url = url
    }
    
    
    mutating func startRecord() {
        guard !isRecording else {
            return
        }
        
        isRecording = !isRecording
        recorder = try! AVAudioRecorder(url: url, settings: [AVFormatIDKey: kAudioFormatMPEG4AAC])
        recorder.record()
    }
    
    mutating func stopRecord() {
        guard isRecording else {
            return
        }
        
        isRecording = !isRecording
        recorder.stop()
    }
    
}


protocol PlayerServiceDelegate: AnyObject {
    
    func playerService(_ playerService: PlayerService, playingDidFinish success: Bool)
    
}


class PlayerService: NSObject, AVAudioPlayerDelegate {
    
    private var player: AVAudioPlayer!
    private var url: URL
    weak var delegate: PlayerServiceDelegate?
    
    
    init(url: URL) {
        self.url = url
    }
    
    
    func startPlay() {
        player = try! AVAudioPlayer(contentsOf: url)
        player.delegate = self
        player.play()
    }
    
    func stopPlay() {
        player.stop()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        delegate?.playerService(self, playingDidFinish: flag)
    }
    
}

// Facade
protocol AudioFacadeDelegate: AnyObject {

    func audioFacadePlayingDidFinish(_ audioFacade: AudioFacade)
    
}


class AudioFacade: PlayerServiceDelegate {
    
    private let audioSessionService = AudioSessionService()
    private let fileService = FileService()
    private let fileFormat = ".m4a"
    private var playerService: PlayerService!
    private var recorderService: RecorderService!
    
    weak var delegate: AudioFacadeDelegate?
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd_HH:mm:ss"
        return dateFormatter
    }()
    
    
    init() {
        audioSessionService.setupSession()
    }
    
    deinit {
        audioSessionService.deactivateSession()
    }
    
    
    func startRecord() {
        let fileName = dateFormatter.string(from: Date()).appending(fileFormat)
        let url = fileService.path(withPathComponent: fileName)
        recorderService = RecorderService(url: url)
        recorderService.startRecord()
    }
    
    func stopRecord() {
        recorderService.stopRecord()
    }
    
    func numberOfRecords() -> Int {
        fileService.contentsOfDocumentDirectory.count
    }
    
    func nameOfRecord(at index: Int) -> String {
        let url = fileService.contentsOfDocumentDirectory[index]
        return url.lastPathComponent
    }
    
    func removeRecord(at index: Int) {
        fileService.removeItem(at: index)
    }
    
    func playRecord(at index: Int) {
        let url = fileService.contentsOfDocumentDirectory[index]
        playerService = PlayerService(url: url)
        playerService.delegate = self
        playerService.startPlay()
    }
    
    func stopPlayRecord() {
        playerService.stopPlay()
    }
    
    func playerService(_ playerService: PlayerService, playingDidFinish success: Bool) {
        if success {
            delegate?.audioFacadePlayingDidFinish(self)
        }
    }
    
}


func foo4() { // Usage
    let audioFacade = AudioFacade()
    audioFacade.numberOfRecords()
    
    // Result:
    // 0
}
