//
//  ViewController.swift
//  iPost
//
//  Created by Stefan Adisurya on 16/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataArray: [Post] = []
    var userArray: [User] = []
    
    var idArray: [Int] = []
    var nameArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCell()
        
        loadDataFromAPI {
            self.tableView.reloadData()
            
//            for ids in self.idArray {
//                self.getUser(id: ids)
//            }
        }
    }
    
    private func setUpCell() {
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostCell")
    }

    private func loadDataFromAPI(completion: @escaping () -> ()) {
        let request = NSMutableURLRequest(url: NSURL(string: "https://jsonplaceholder.typicode.com/posts")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if error != nil {
                print(error as Any)
            } else {
                if let data = data {
                    do {
                        self.dataArray = try JSONDecoder().decode([Post].self, from: data)
                        
                        for i in 0..<self.dataArray.count {
                            self.idArray.append(self.dataArray[i].userId)
                            
                            self.getUser(id: self.idArray[i])
                        }

                        DispatchQueue.main.async {
                            completion()
                        }
                    } catch let error {
                        print(error.localizedDescription)
                    }
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
                if let data = data {
                    do {
                        let dataJSON = try JSONDecoder().decode(User.self, from: data)
                        
                        self.userArray.append(dataJSON)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch let error {
                        print(error.localizedDescription)
                    }
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
        
        cell.postTile.text = dataArray[indexPath.row].title.capitalized
        cell.postBody.text = dataArray[indexPath.row].body.capitalized
        cell.userNameAndCompany.text = "\(idArray[indexPath.row])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "PostDetail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostDetail") as! PostDetailViewController
        vc.userId = dataArray[indexPath.row].userId
        vc.postId = dataArray[indexPath.row].id
        vc.postTitle = dataArray[indexPath.row].title
        vc.postBody = dataArray[indexPath.row].body
        vc.username = userArray[indexPath.row].name
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
