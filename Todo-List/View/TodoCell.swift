//
//  TodoCell.swift
//  Todo-List
//
//  Created by Abdelrahman Sobhy on 5/3/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {
    @IBOutlet weak var todoLbl: UILabel!
    @IBOutlet weak var todoPaiorty: UIView!
    
    func confegureCell(todos : Todo){
        self.todoLbl.text! = todos.item
        switch todos.priority {
        case 0:
            todoPaiorty.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case 1:
            todoPaiorty.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        case 2:
            todoPaiorty.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        default:
            todoPaiorty.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}
