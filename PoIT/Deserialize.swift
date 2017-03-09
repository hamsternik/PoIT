//
//  Deserializer.swift
//  PoIT
//
//  Created by Nikita Khomitsevich on 3/9/17.
//  Copyright © 2017 Nikita Khomitsevich. All rights reserved.
//

import Cocoa

protocol Deserializable {
    func fromEntry(_ entry: Entry)
}

protocol Deserializer {
    func deserialize(_ data: Data) -> Entry
    func deserialize(_ data: Data) -> [Entry]
}
