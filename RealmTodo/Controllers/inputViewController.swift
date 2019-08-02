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
    
    @IBOutlet weak var button: UIButton!
    //前の画面から渡されてきたTODOを受け取る変数
    var todo: Todo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //todoの変数に値が入っている場合つまり編集しようとする場合
        if todo != nil{
            //ボタンの名前を変える
            button.setTitle("タスク編集", for: .normal)
            //テキストにタイトルを入れる
            textField.text = todo?.title
        }
        
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
    
    fileprivate func updateTodo(_ text: String) {
        //更新
        let realm = try! Realm()
        try! realm.write {
            todo?.title = text
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
        
        if todo == nil{
            //新規タスクを追加
            createNewTodo(text)
        }else{
            updateTodo(text)
        }
        
        
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
