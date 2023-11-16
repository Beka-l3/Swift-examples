import Foundation


/// Basic unit of information is ``bit`` = 1/0
/// Traditionally we orgonize them into groups called ``bytes``
/// `1 byte == 8 bits`

// Memory is a long sequence of bytes
/// They are located in a defined order
/// Every byte has it's own `address`

/// We consider memory as a organized ``words`` but not `bytes`
/// ``Word`` is a faded terminology in Computer Science, but usually this means unit of pointer size
/// Modern computers has 64-bit CPU.
/// So `1 word == 8 bytes == 64 bits`
/// ! That's the amount of information we get in one access to the memory


// MARK: Memory Layout
/// Memroy layout consits of 3 main parts
/// - Size
/// - Alignment
/// - Stride

/// `Size` - actual size of data in a row
/// `Alignment` - size of the largest element
/// `Stride` - rounded size for consistency in address space

/// Examples:
func foo1() {
    struct FullResume {
        let id: String
        let age: Int
        let hasVehicle: Bool
    }
    
    MemoryLayout<FullResume>.size // 25
    
    MemoryLayout<String>.size // 16
    + MemoryLayout<Int>.size // 8
    + MemoryLayout<Bool>.size // 1
}


func foo2() {
    struct FullResume {
        let hasVehicle: Bool
        let id: String
        let age: Int
    }

    MemoryLayout<FullResume>.size // 32 ???

    MemoryLayout<Bool>.size // 1
        + MemoryLayout<String>.size // 16
        + MemoryLayout<Int>.size // 8
}

/// Order of property declarations directly effect the `memory layout`
/// foo1:  String[1111111111111111] + Int[11111111] + Bool[1] + `[0000000]`
/// size = 25,    alignment = 16,     stride = 32

/// foo2: Bool[1] + `[0000000]` + String[1111111111111111] + Int[11111111]
/// size = 32,    alignment = 16,     stride = 32


func foo3() {
    struct Test {
        let firstBool: Bool
        let array: [Bool]
        let secondBool: Bool
        let smallInt: Int32
    }
    
    MemoryLayout<Test>.size       // 24
    MemoryLayout<Test>.alignment  // 8
    MemoryLayout<Test>.stride     // 24
}

/// ``Reference == 8 bytes``
/// foo3: Bool[1] + *[0000000]* + ArrayRef[11111111] + Bool[1] + *[000]* + Int32[1111]
/// size: 24    alignment: 8    stride: 24


func foo4() {
    class PaidService {
        let id: String
        let name: String
        let isActive: Bool
        let expiresAt: Date?
        
        init() {
            self.id = "id"
            self.name = "name"
            self.isActive = .random()
            self.expiresAt = .init()
        }
    }

    MemoryLayout<PaidService>.size       // 8
    MemoryLayout<PaidService>.alignment  // 8
    MemoryLayout<PaidService>.stride     // 8
}

/// Class is reference type
/// ``All the references == 8 bytes``

/// To get the real size that is on the heap
/// Need to use Objective-C method `class_getInstanceSize(_:)`

/// foo4: String[1111111111111111] + String[1111111111111111] + Bool[1] + *[0000000]* + Data[11111111] + Optional[1] + *[0000000]* + Metadata[1111111111111111]



// MARK: Dumping, Pointers, Visualisation

func foo5() {
    struct FullResume {
        let id: String
        let age: Int
        let hasVehicle: Bool
    }
    
    class FullResumeC {
        let id: String
        let age: Int
        let hasVehicle: Bool
        
        init() {
            self.id = "id"
            self.age = 0
            self.hasVehicle = .random()
        }
    }
}
/// Visualisation of the `Struct = 1 bubble of memory`
/// Visualisation of the `Class = 15+ bubble of memories`
