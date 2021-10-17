//
//  PostDetailViewController.swift
//  iPost
//
//  Created by Stefan Adisurya on 17/10/21.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    var postId: Int?
    var postTitle: String?
    var postBody: String?
    var username: String?
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var commentArr: [CommentData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCell()
        setUpComponent()
        getCommentsByPostId(postId ?? 1)
    }
    
    private func setUpCell() {
        tableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
    }
    
    private func setUpComponent() {
        postTitleLabel.text = postTitle?.capitalized
        postBodyLabel.text = postBody?.capitalized
        usernameLabel.text = "Made by me"
    }
    
    private func getCommentsByPostId(_ id: Int) {
        let request = NSMutableURLRequest(url: NSURL(string: "https://jsonplaceholder.typicode.com/posts/\(id)/comments")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
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
                    self.commentArr = try JSONDecoder().decode([CommentData].self, from: data)

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

extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
        
        cell.authorLabel.text = commentArr[indexPath.row].email
        cell.commentBodyLabel.text = commentArr[indexPath.row].body
        
        return cell
    }
    
}
