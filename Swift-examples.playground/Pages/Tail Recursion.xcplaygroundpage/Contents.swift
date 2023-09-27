import Foundation

protocol Connection {
    func receive(minimumIncompleteLength: Int, maximumLength: Int, callback: (Data, String, Bool, Error) -> Void)
}

class Some {
    let connection: Connection
    
    init(connection: Connection) {
        self.connection = connection
    }
    
    func startReceive() {
        self.connection.receive(minimumIncompleteLength: 1, maximumLength: 1) { data, contentContext, isDone, error in
            //    do something with data; handle errors and EOF
            
            self.startReceive()  //    stack explosion or tail recursion?
        }
    }
}


// what will happen, if 1 MB is sent?

// A: the stack will explode
// B: Swift does handle tail recursion and the stack size will not change.


/// Swift does support tail call optimizations, but it doesn't make any guarantees.
/// In effect, you could never rely on it, unless you're carefully retesting your code with every compiler version.

/// The main issue is that functions have a `prelude`,
/// a chunk of code that runs after the function body, which makes release calls on any ARC-managed objects used during the function.

/// So long as your function's last statement is a recursive call (with no extra bells and whistles, like `recurse() + [value], recurse() + 1)`,
/// and your functions doesn't use any ARC--managed objects, then the compiler should be able to tail-call optimize it.
/// But again, don't rely on it.

/// In any case, the example you show is most certainly not a good dit for recursion.
/// Conceptually it's just messy, but it's also not a candidate for tail call optimization because data and probably `contentContext are arc-managed`.

