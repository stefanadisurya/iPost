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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCell()
        
        loadDataFromAPI {
            for dt in self.dataArray {
                self.getUser(id: dt.userId)
            }
            
            self.tableView.reloadData()
        }
    }
    
    private func setUpCell() {
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostCell")
    }

    private func loadDataFromAPI(completion: @escaping () -> ()) {
        ConsumeAPI.loadData(from: "https://jsonplaceholder.typicode.com/posts") { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                self.dataArray = try JSONDecoder().decode([Post].self, from: data)

                DispatchQueue.main.async {
                    completion()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func getUser(id: Int) {
        ConsumeAPI.loadData(from: "https://jsonplaceholder.typicode.com/users/\(id)") { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                self.userArray.append(try JSONDecoder().decode(User.self, from: data))
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        cell.postTitle.text = dataArray[indexPath.row].title.capitalized
        cell.postBody.text = dataArray[indexPath.row].body.capitalized
        
        ConsumeAPI.loadData(from: "https://jsonplaceholder.typicode.com/users/\(self.dataArray[indexPath.row].userId)") {
            data, response, error in
            guard let _ = data, error == nil else { return }
            DispatchQueue.main.async() {
                cell.userNameAndCompany.text = "\(self.userArray[indexPath.row].name) | \(self.userArray[indexPath.row].company.name)"
            }
        }
        
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
