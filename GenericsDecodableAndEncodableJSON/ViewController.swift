//
//  ViewController.swift
//  GenericsDecodableAndEncodableJSON
//
//  Created by X901 on 11/08/2018.
//  Copyright © 2018 X901. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        //How to Use ?
        
        //1. Creat Model for your JSON Data
        //2. For Get Reguest use it like this :
        
        getGenericData(urlString: "API Link Here") { (get: [TestData]) in
            
            print(get)
    
        }
        
        //3. For Post Reguest use it like this :
        
        //Add Prameter As Object
        let newAddTest = AddTestData(Name: "wael", age: 35, gender: "Male")
        
        //Call postGenericData
        postGenericData(urlString: "API Link Here", parameter: newAddTest) { (post : AddTestData)  in
            
            // This is not necessary
            print(post)
        }
        
    }

    fileprivate func getGenericData<T: Decodable>(urlString: String, completion: @escaping (T) -> ()) {
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            if let err = err {
                print("Failed to fetch data:", err)
                return
            }
            
            
            guard let data = data else { return }
            
            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                completion(obj)
            } catch let jsonErr {
                print("Failed to decode json:", jsonErr)
            }
            }.resume()
    }
    
    fileprivate func postGenericData<T:Encodable>(urlString: String, parameter: T, completion: @escaping (T) -> ()) {
        
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonBody = try JSONEncoder().encode(parameter)
            
            request.httpBody = jsonBody
            
            
            completion(parameter)
            
            
            
        } catch let jsonErr {
            print("Failed to encode json:", jsonErr)
        }
        
        
        let session = URLSession.shared
        _ = session.dataTask(with: request) { (data,respon, error) in
            
            if let error = error {
                print("Failed to post data:", error)
                return
            }
            
            if let httpResponse = respon as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
            }
            
            
            
            }.resume()
        
    }




}

//Example Model for Get Request
struct TestData: Decodable {
    let Id : Int
    let Name : String
    let age : Int
    let gender : String
    
}

//Example Model for Post Request
struct AddTestData: Encodable {
    let Name : String
    let age : Int
    let gender : String
    
}

