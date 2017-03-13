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
    
    // TODO: Test both version of the `remove` process
    func remove<T>(_ object: T) -> Bool where T: Serializible, T: Deserializable, T: Equatable {
        var objects: [T] = getDictValues(from: entries)
        
        // first var.
        for ind in 0...objects.count {
            if object == objects[ind] {
                objects.remove(at: ind)
                replaceAll(on: objects)
                return true
            }
        }
        
        // second var.
        if let index = objects.index(where: { $0 == object }) {
            objects.remove(at: index)
            replaceAll(on: objects)
            return true
        }
        
        print("Storage does not contain passed element.")
        return false
    }
    
    func removeAll() {
        entries.removeAll()
        let encodedData = SerializerDeserializer.sharedInstance.serialize(entries)
        storage.set(encodedData, forKey: UsersTableID)
    }
    
    // MARK: Private Methods
    
    private func replaceAll<T: Serializible>(on objects: [T]) {
        let entries = objects.map { $0.toEntry() }
        self.entries = entries //replace
        let encodedData = SerializerDeserializer.sharedInstance.serialize(self.entries)
        storage.set(encodedData, forKey: UsersTableID)
    }
    
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
