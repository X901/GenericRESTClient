//
//  ViewController.swift
//  GenericsDecodableAndEncodableJSON
//
//  Created by X901 on 11/08/2018.
//  Copyright © 2018 X901. All rights reserved.
//

import UIKit

//How to Use ?
//1. Move GenericRESTClint file to your project
//2. Add GenericRESTClint Delegate
class ViewController: UIViewController,GenericRESTClint {
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
     
    
        
        
        //3. Creat Model for your JSON Data
        //4. For Get Reguest use it like this :

        self.getGenericData(urlString: "API Link Here") { (get: [TestData]) in
            
            print(get)
    
        }
        
        //5. For Post Reguest use it like this :
        //Add Prameter As Object
        
        let newAddTest = AddTestData(Name: "basel", age: 26, gender: "Male")
        
        //Call postGenericData
        
        self.postGenericData(urlString: "API Link Here", parameter: newAddTest) { (data, response, error) in
            
            if let error = error {
                print("Failed to post data:", error)
                return
                
            } else {
            
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
            }
                
            }
        }
        
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
