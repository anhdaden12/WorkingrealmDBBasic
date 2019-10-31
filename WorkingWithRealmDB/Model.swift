//
//  Model.swift
//  WorkingWithRealmDB
//
//  Created by Apple on 10/31/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

import RealmSwift


class Person: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var phone: Int = 0
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

