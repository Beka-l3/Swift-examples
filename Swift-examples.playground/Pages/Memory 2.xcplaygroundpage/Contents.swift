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
