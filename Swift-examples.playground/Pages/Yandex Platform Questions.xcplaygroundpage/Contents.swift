import Foundation
import UIKit
import PlaygroundSupport

print("Hello World!")


/*
 
// Для строки вида "AAABBCCAA" вывести частоту символов, например: A: 5, B: 2, C: 2
func frequencies(_ s: String) -> String {
    let s = Array(s)
    var freq: [Character: Int] = [:]

    for char in s {
        freq[char, default: 0] += 1
    }

    var result = ""

    let keys = freq.keys.sorted()
    for i in 0..<keys.count {
        if let value = freq[keys[i]] {
            if i == keys.count - 1 {
                result += "\(keys[i]): \(value)"
            } else {
                result += "\(keys[i]): \(value), "
            }
        }
    }
    
    return result
}


// 1
struct Circle {
  var radius: Int = 5
}

var circle1 = Circle()
var circle2 = circle1
circle2.radius = 10

// 2
class Circle {
  var radius: Int = 5
}

var circle1 = Circle()
var circle2 = circle1
circle2.radius = 10

// 3
struct Circle {
  var radius: Int = 5
}

var circle1 = Circle()
let circle2 = circle1
circle2.radius = 10

// 4
class Circle {
  var radius: Int = 5
}

var circle1 = Circle()
let circle2 = circle1
circle2.radius = 10

let circle3 = Circle()
cirlce2 = cirlce3



var myCircle: Circle? = .init()

print(myCircle?.radius ?? "no circle")
if let radius = myCircle?.radius {
    print(radius)
}

guard let radius = myCircle?.radius else {
    return
}

print(radius)

print(myCircle!.radius)


class Foo {
  func bar() { print("bar") }
}

// 1
let foo : Foo? = nil
foo?.bar()

// 2
let foo : Foo? = nil
foo!.bar()

// 3
let foo : Foo? = nil
foo.bar()


class Person {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is deallocated")
    }
}

do {
    var person: Person? = Person(name: "Piterson") // 1
    var person2: Person? = nil                     // 1
    var person3: Person? = nil                     // 1
    
    person2 = person                               // 2
    person3 = person2                              // 3

    person = nil //1                               // 2
    person2 = nil //2                              // 1
    person3 = nil //3                              // 0 deinit
}


class SomeViewController: UIViewController {
    private lazy var label: UIlabel {
        let label = UIlabel()
        ...
        return label
    }()

    private let networkService: SomeNetworkService

    init(networkService: SomeNetworkService) {
        self.networkService = networkService
        super.init()
    }

    func print(text: String) {
        Logging.log(text)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // label = makeLabelAndSetupLayout()
        setupViews()
    }

    func makeLabelAndSetupLayout() -> UILabel {
        // считаем что метод реализован
    }
 
    func doSomething() {
        networkService.downloadObject { [weak self] text in
            self?.print(text: text)

            DispatchQueue.main.async {
                self?.label.text = text
            }
        }
    }

    private func setupView() {
        view.addSuview(label)

        NSLayoutConstraints.activate([

        ])
    }
}


func test() {
    let v = 5
}

// казак
// А роза упала на лапу Азора
func isPalindorme(_ s: String) -> Bool {
    let s = Array(s)
    var l = 0, r = s.count - 1

    while l < r {
        if !s[l].isLetter() {
            l += 1
            continue
        }

        if !s[r].isLetter() {
            r -= 1
            continue
        }

        if s[l].lowercased() != s[r].lowercased() {
            return false
        }

        l += 1
        r -= 1
    }

    return true
}

*/
