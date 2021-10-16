//
//  ViewController.swift
//  iPost
//
//  Created by Stefan Adisurya on 16/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataArray: [Int: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCell()
        loadDataFromAPI()
    }
    
    private func setUpCell() {
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostCell")
    }

    private func loadDataFromAPI() {
        let request = NSMutableURLRequest(url: NSURL(string: "https://jsonplaceholder.typicode.com/posts")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
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
                    let dataJSON = try JSONDecoder().decode([PostData].self, from: data)

//                    print(dataJSON[0].title)
                    
                    
                    for i in 0..<dataJSON.count {
                        self.dataArray[i] = "\(dataJSON[i])"
                    }

//                    for item in dataJSON["response"] as! NSArray {
//                        self.dataArray.append(item as! String)
//                    }

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
        
        var keysArray = Array(dataArray.keys)
        let currentKey = keysArray[indexPath.row]
        let currentIndexKey: PostData = dataArray[currentKey] as! PostData

        
        cell.postTile.text = currentIndexKey.title
        cell.postBody.text = currentIndexKey.body
        
        return cell
    }
    
    
    
    
}
