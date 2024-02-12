//
//  UserInfo.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 12.02.2024.
//

import Foundation


struct UserInfo {
    
    let discount:           Int
    
    let avatarUrl:          String
    
    let name:               String
    let surename:           String
    let patrioticName:      String
    
    let email:              String
    let phoneNumber:        String
    let birthday:           String
    
    let company:            String
    let department:         String
    let specialization:     String
    
    let location:           Location
    let statistics:         [Statistics]
}


extension UserInfo {
    
    struct Statistics {
        let title:      String
        let percent:    Int
    }
    
    struct Location {
        let country:    String
        let city:       String
    }
}


extension UserInfo {
     
    static var spampleData: UserInfo {
        .init(
            discount: .random(in: 0...100), avatarUrl: avatarUrls.randomElement()!,
            name: "Yerzhan", surename: "Gapurinov", patrioticName: "Fatherson",
            email: "mail@mail.ru", phoneNumber: getPhoneNumber(), birthday: "\(Int.random(in: 1...31)) Январь 2024",
            company: "ООО TeamForce", department: "Отдел разработки", specialization: "iOS разработчик",
            location: .init(country: "Russia", city: "Innopolis"),
            statistics: getStatistics()
        )
    }
    
    
    private static let avatarUrls: [String] = [
        "https://images.unsplash.com/photo-1631964863108-6cb71730f742?q=80&w=3024&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1625927884163-7583b514b112?q=80&w=3024&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1625926852782-3bef718476dc?q=80&w=3174&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1629043916430-feca2aed4eea?q=80&w=3132&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    ]
    
    private static func getStatistics() -> [Statistics] {
        var res: [Statistics] = []
        
//        for i in (0...(.random(in: 1...10))) {
        for i in 0...5 {
            res.append(.init(
                title: "Statistics \(i) \(["Hello", "World", "Holly Molly", "My name is Slim Shady", "Yes", ""].randomElement()!)",
                percent: .random(in: 1...100))
            )
        }
        
        return res
    }
    
    private static func getPhoneNumber() -> String {
        "+7 (\(Int.random(in: 100...999))) \(Int.random(in: 100...999)) \(Int.random(in: 10...99)) \(Int.random(in: 10...99))"
    }
}
