//
//  Todo.swift
//  RealmTodo
//
//  Created by 渡邉舜也 on 30/07/2019.
//  Copyright © 2019 渡邉舜也. All rights reserved.
//

import RealmSwift

class Todo: Object {
    
    //ID（連番）
    @objc dynamic var id: Int = 0
    //タイトル
    @objc dynamic var title: String = ""
    //登録する日付が入る
    @objc dynamic var date: Date = Date()
    
}
