//
//  inputViewController.swift
//  RealmTodo
//
//  Created by 渡邉舜也 on 30/07/2019.
//  Copyright © 2019 渡邉舜也. All rights reserved.
//

import UIKit
import RealmSwift

class inputViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    //前の画面から渡されてきたTODOを受け取る変数
    var todo: Todo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    fileprivate func createNewTodo(_ text: String) {
        //Realmに接続
        let realm = try! Realm()
        
        //データを登録する
        let todo = Todo()
        //最大のIDを取得
        let id = getMaxId()
        todo.id = id
        todo.title = text
        todo.date = Date()
        
        //作成したTODOリストを登録する
        try! realm.write {
            realm.add(todo)
        }
    }
    
    @IBAction func didClickButton(_ sender: UIButton) {
        
        //nilかチェックをする
        guard let text = textField.text else{
            //textField.textがnilの場合
            //ボタンがクリックされた時の処理を中断（return）
            return
        }
        
        
        if text.isEmpty {
            //textField.textが空文字の場合
            //ボタンがクリックされた時の処理を中断（return）
            return
        }
        
        //新規タスクを追加
        createNewTodo(text)
        
        //前の画面に戻る
        //NavigationControllerの持っている履歴から１つ前の画面に戻る
        navigationController?.popViewController(animated: true)
        
    }
    
    //最大IDを取得するメソッド
    func getMaxId() -> Int {
        //Realmに接続
        let realm = try! Realm()
        //Todoシートから最大のIDを取得する
        let id = realm.objects(Todo.self).max(ofProperty: "id") as Int?
        
        if id == nil{
            //最大IDがnil（存在しない）場合、１を返す
            return 1
        } else {
            //最大IDが存在する場合、最大ID ＋１を返す
            return id! + 1
        }
        
    }
   

}
