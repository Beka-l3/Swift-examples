import UIKit


/// we have multiple async tasks
/// and we need to wait all of them to finish
/// then we can use ``DispatchGroup``


let imageGroup = DispatchGroup()

let imageUrls = [
    "https://images.unsplash.com/photo-1623491527126-8ccdf066feef?q=80&w=3072&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1652650519133-16956d74279f?q=80&w=3024&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1652648649332-7db46852da33?q=80&w=3024&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1632733634218-a3f449d4af22?q=80&w=3024&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1634735257780-f65fb715d626?q=80&w=3173&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1614866696055-b8588946b8f4?q=80&w=3024&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1614866793299-784255396c47?q=80&w=3174&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
]

var images: [UIImage?] = []

for i in 0...2 {
    DispatchQueue.global().async(group: imageGroup) {
        if
            let url = URL(string: imageUrls[i]),
            let data = try? Data(contentsOf: url)
        {
            images.append( UIImage(data: data) )
            print("---- finished \(i)       priority: \(qos_class_self().rawValue)")
        }
    }
}

//sleep(3)
for i in 3...5 {
    DispatchQueue.global(qos: .userInitiated).async(group: imageGroup) {
        if
            let url = URL(string: imageUrls[i]),
            let data = try? Data(contentsOf: url)
        {
            images.append( UIImage(data: data) )
            print("---- finished \(i)       priority: \(qos_class_self().rawValue)")
        }
    }
}


imageGroup.notify(queue: .main) {
    print("\nfinished image group work")
    if images.count == 6 {
        print("got 6 images")
    } else {
        print("something is not working")
    }
}

/// we can add to the same group
/// tasks from `different queues`

/// when all the tasks are finished
/// then notify is called


/// Group has thread safe counter inside of it
/// notify will be called only it is 0

// my opinion
/// notify will be called once
/// even if we put sleep(3) as in line 35
/// seems like counter is increased during `compilation`
/// and it is not dynamically increased
//

/// however we can call `enter()` and `leave()`
/// to `increase` and `decrease` the counter



