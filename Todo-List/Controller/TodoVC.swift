//
//  ViewController.swift
//  Todo-List
//
//  Created by Abdelrahman Sobhy on 5/3/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import UIKit
class TodoVC: UIViewController {
    var todos = [Todo]()
    @IBOutlet weak var paiortySegment: UISegmentedControl!
    @IBOutlet weak var todoTF: UITextField!
    @IBOutlet weak var todoTableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTogos()
        todoTableView.reloadData()
        }
    
    func getTogos(){
        NetworkServices.shared.featchTodo(isSuccess: { (todos) in
            self.todos = todos.items
            self.todoTableView.reloadData()
        }) { (err) in
            /// alert error to user here
        }

    }
    @IBAction func addTodo(_ sender: Any) {
        guard let todoText = todoTF.text else {return}
        let todo = Todo(item: todoText, priority: paiortySegment.selectedSegmentIndex)
        NetworkServices.shared.addTodo(todo: todo, onSuccess: { (todo) in
        
            self.todos = todo.items
        self.todoTableView.reloadData()

        }) { (err) in
            print(err.debugDescription)
        }
    }
    
    
}

extension TodoVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as? TodoCell else {return UITableViewCell()}
        
        cell.confegureCell(todos: todos[indexPath.row])
        
        return cell
    }
}
extension TodoVC : UITableViewDelegate{
    
}

