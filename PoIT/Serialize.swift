//
//  Serialize.swift
//  PoIT
//
//  Created by Nikita Khomitsevich on 3/9/17.
//  Copyright © 2017 Nikita Khomitsevich. All rights reserved.
//

import Cocoa

typealias Entry = [String : Any]

protocol Serializible {
    func toEntry() -> Entry
}

protocol Serializer {
    func serialize(_ entry: Entry) -> Data
    func serialize(_ entries: [Entry]) -> Data
}
