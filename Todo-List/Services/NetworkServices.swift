//
//  NetworkServices.swift
//  Todo-List
//
//  Created by Abdelrahman Sobhy on 5/3/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import Foundation
class NetworkServices {
    static let shared = NetworkServices()
    let baseUrl = "http://localhost:3003"
    let addUrl = "/Add"
    let session = URLSession(configuration: .default)
    
    
    
    func addTodo(todo: Todo, onSuccess: @escaping (Todos) -> Void, onError: @escaping (String) -> Void) {
           let url = URL(string: "\(baseUrl)\(addUrl)")!
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           request.addValue("application/json", forHTTPHeaderField: "Accept")
           
           do {
               let body = try JSONEncoder().encode(todo)
               request.httpBody = body
               
               let task = session.dataTask(with: request) { (data, response, error) in
                   
                   DispatchQueue.main.async {
                       if let error = error {
                           onError(error.localizedDescription)
                           return
                       }
                       
                       guard let data = data, let response = response as? HTTPURLResponse else {
                           onError("Invalid data or response")
                           return
                       }
                       
                       do {
                           if response.statusCode == 200 {
                               let items = try JSONDecoder().decode(Todos.self, from: data)
                               onSuccess(items)
                           } else {
                               let err = try JSONDecoder().decode(ApiError.self, from: data)
                               onError(err.message)
                           }
                       } catch {
                           onError(error.localizedDescription)
                       }
                   }
                   
                   
               }
               task.resume()
               
           } catch {
               onError(error.localizedDescription)
           }
           
       }
    
    
    
    func featchTodo(isSuccess : @escaping (Todos)->Void , onError : @escaping (String)->Void) {
        let url = URL(string: "\(baseUrl)")!
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error{
                    onError("\(error.localizedDescription)")
                }
                guard let data = data , let response = response as? HTTPURLResponse else {return onError("invalid Data or response")}
                
                do {
                    if response.statusCode == 200 {
                        let jsonData = try JSONDecoder().decode(Todos.self, from: data)
                        isSuccess(jsonData)
                    }else{
                        let err = try JSONDecoder().decode(ApiError.self, from: data)
                        onError(err.message)
                        
                    }
                } catch {
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}

