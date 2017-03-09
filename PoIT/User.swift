//
//  User.swift
//  PoIT
//
//  Created by Nikita Khomitsevich on 3/9/17.
//  Copyright © 2017 Nikita Khomitsevich. All rights reserved.
//

import Cocoa

enum Role: String {
    case undefined = "Undefined"
    case admin = "Admin"
    case user = "User"
}

class User: NSObject, NSCoding, Person, Serializible, Deserializable {
    
    fileprivate(set) var name: String
    
    fileprivate(set) var password: String
    fileprivate(set) var role: Role
    
    init(_ name: String, _ password: String, _ role: Role) {
        self.name = name
        self.password = password
        self.role = role
    }
    
    // NSCoding
    
    @objc required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let password = aDecoder.decodeObject(forKey: "password") as! String
        let role = Role(rawValue: (aDecoder.decodeObject(forKey: "role") as! String)) ?? Role.undefined
        
        self.init(name, password, role)
    }
    
    @objc func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(role.rawValue, forKey: "role")
    }
    
    // Serializible & Deserializable
    
    func toEntry() -> Entry {
        return ["name" : name, "password" : password, "role" : role.rawValue]
    }
    
    required init(_ entry: Entry) {
        self.name = entry["name"] as! String
        self.password = entry["password"] as! String
        self.role = Role(rawValue: entry["role"] as! String)!
    }
    
    // Equatable
    
    static func ==(lhs: User, rhs: User) -> Bool {
        if (lhs.name == rhs.name && lhs.password == rhs.password && lhs.role.rawValue == rhs.role.rawValue) {
            return true
        }
        return false
    }
}
