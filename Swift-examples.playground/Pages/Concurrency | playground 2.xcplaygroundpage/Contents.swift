import Foundation


func printCucumbers() {
  DispatchQueue.global().async {
    for _ in 0..<100 {
      print("🥒")
    }
  }
}

printCucumbers()

for _ in 0..<100 {
  print("🍅")
}

