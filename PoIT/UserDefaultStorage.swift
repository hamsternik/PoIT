//
//  UserDefaultsStorage.swift
//  PoIT
//
//  Created by Nikita Khomitsevich on 3/9/17.
//  Copyright © 2017 Nikita Khomitsevich. All rights reserved.
//

import Cocoa

let UsersTableID = "com.PoIT.UsersTableID"

class UserDefaultsStorage {
    
    static let sharedInstance = UserDefaultsStorage()
    
    fileprivate var entries: [Entry]
    fileprivate var storage = UserDefaults.standard {
        didSet {
            storage.synchronize()
        }
    }
    
    private init() {
        self.entries = []
        if let entries = loadEntries() {
            self.entries = entries
        }
    }
    
    // MARK: Public methods
    
    func put<T: Serializible>(_ object: T) {
        let entry = object.toEntry()
        self.entries.append(entry)
        let encodedData = SerializerDeserializer.sharedInstance.serialize(self.entries)
        storage.set(encodedData, forKey: UsersTableID)
    }
    
    func put<T: Serializible>(_ objects: [T]) {
        let entries = objects.map { $0.toEntry() }
        self.entries += entries
        let encodedData = SerializerDeserializer.sharedInstance.serialize(self.entries)
        storage.set(encodedData, forKey: UsersTableID)
    }
    
    func get<T: Deserializable>() -> [T] {
        guard let entries = loadEntries() else { return [] }
        self.entries = entries
        return getDictValues(from: entries)
    }
    
    func remove(_ user: User) -> Bool {
        // TODO: Implement storing into UserDefaults 
        var users: [User] = getDictValues(from: entries)
        for ind in 0...users.count {
            if user == users[ind] {
                users.remove(at: ind)
                return true
            }
        }
        
        print("Storage does not contain passed element.")
        return false
    }
    
    func removeAll() {
        // TODO: Implement storing into UserDefaults
        entries.removeAll()
    }
    
    // MARK: Private Methods
    
    private func loadEntries() -> [Entry]? {
        if let encodedData = storage.object(forKey: UsersTableID) as? Data {
            return SerializerDeserializer.sharedInstance.deserialize(encodedData)
        }
        return nil
    }
    
    private func getDictValues<T: Deserializable>(from entries: [Entry]) -> [T] {
        var objects = Array<T>()
        for entry in entries {
            objects.append(T(entry))
        }
        return objects
    }
    
}
