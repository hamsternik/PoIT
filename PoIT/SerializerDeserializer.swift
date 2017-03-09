//
//  SerializerDeserializer.swift
//  PoIT
//
//  Created by Nikita Khomitsevich on 3/9/17.
//  Copyright © 2017 Nikita Khomitsevich. All rights reserved.
//

import Cocoa

class SerializerDeserializer: Serializer, Deserializer {
    
    static let sharedInstance = SerializerDeserializer()
    
    private init() { }

    // MARK: Serializer, Deserializer
    
    func serialize(_ entry: Entry) -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: entry)
    }
    
    func serialize(_ entries: [Entry]) -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: entries)
    }
    
    func deserialize(_ data: Data) -> [Entry]? {
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? [Entry]
    }
    
}
