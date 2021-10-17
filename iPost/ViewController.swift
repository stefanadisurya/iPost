//
//  ViewController.swift
//  iPost
//
//  Created by Stefan Adisurya on 16/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataArray: [PostData] = []
    var userArray: [UserData] = []
    
    var idArray: [Int] = []
    var nameArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCell()
        
        loadDataFromAPI()
        getAllUser()
    }
    
    private func setUpCell() {
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostCell")
    }

    private func loadDataFromAPI() {
        let request = NSMutableURLRequest(url: NSURL(string: "https://jsonplaceholder.typicode.com/posts")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if error != nil {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
            }
            
            if let data = data {
                do {
                    self.dataArray = try JSONDecoder().decode([PostData].self, from: data)
                    
                    for i in 0..<self.dataArray.count {
                        // Passing id ke array
                        self.idArray.append(self.dataArray[i].userId)

                        // Ambil data ke URL yang punya id pada array tersebut
//                        self.getUser(id: self.idArray[i])
                    }

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        })
        
        dataTask.resume()
    }
    
    private func getAllUser() {
        let request = NSMutableURLRequest(url: NSURL(string: "https://jsonplaceholder.typicode.com/users")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if error != nil {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
            }
            
            if let data = data {
                do {
                    self.userArray = try JSONDecoder().decode([UserData].self, from: data)
                    
                    for i in 0..<self.userArray.count {
                        self.nameArray.append(self.userArray[i].name)
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        })
        
        dataTask.resume()
    }
    
    private func getUser(id: Int) {
        let request = NSMutableURLRequest(url: NSURL(string: "https://jsonplaceholder.typicode.com/users/\(id)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if error != nil {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
            }
            
            if let data = data {
                do {
                    let dataJSON = try JSONDecoder().decode(UserData.self, from: data)
                    
                    // Masukin namanya ke array baru
                    self.nameArray.append(dataJSON.name)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        })
        
        dataTask.resume()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        
        print(self.nameArray)
        
        cell.postTile.text = dataArray[indexPath.row].title.capitalized
        cell.postBody.text = dataArray[indexPath.row].body.capitalized
        cell.userNameAndCompany.text = "\(nameArray[0])"
        
        return cell
    }
    
}
