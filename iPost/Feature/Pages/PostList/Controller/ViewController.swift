//
//  ViewController.swift
//  iPost
//
//  Created by Stefan Adisurya on 16/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCell()
        
        getAllPost {
            for dt in self.posts {
                self.getUserById(id: dt.userId)
            }
        }
    }
    
    private func setUpCell() {
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostCell")
    }
    
    private func getAllPost(completion: @escaping () -> ()) {
        URLSession.shared.request(url: Constants.postUrl, expecting: [Post].self) { [weak self] result in
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    self?.posts = posts
                    self?.tableView.reloadData()
                    completion()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getUserById(id: Int) {
        if let userUrl = Constants.userUrl {
            URLSession.shared.request(url: URL(string: "\(userUrl)/\(id)"), expecting: User.self) { [weak self] result in
                switch result {
                case .success(let user):
                    DispatchQueue.main.async {
                        self?.users.append(user)
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        cell.postTitle.text = posts[indexPath.row].title.capitalized
        cell.postBody.text = posts[indexPath.row].body.capitalized
        
        URLSession.shared.get(url: URL(string: "https://jsonplaceholder.typicode.com/users?userId=\(self.posts[indexPath.row].userId)")) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    cell.userNameAndCompany.text = "\(self.users[indexPath.row].name) | \(self.users[indexPath.row].company.name)"
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "PostDetail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostDetail") as! PostDetailViewController
        vc.userId = posts[indexPath.row].userId
        vc.postId = posts[indexPath.row].id
        vc.postTitle = posts[indexPath.row].title
        vc.postBody = posts[indexPath.row].body
        vc.username = users[indexPath.row].name
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
