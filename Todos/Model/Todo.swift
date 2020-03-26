//
//  Todo.swift
//  Todos
//
//  Created by apple on 2020/3/21.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import RealmSwift

class Todo: Object{
    @objc dynamic var name = ""
    @objc dynamic var checked = false
    @objc dynamic var createdAT = Date()
}
