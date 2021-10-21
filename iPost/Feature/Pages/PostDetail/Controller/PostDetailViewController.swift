//
//  PostDetailViewController.swift
//  iPost
//
//  Created by Stefan Adisurya on 17/10/21.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    var userId: Int?
    var postId: Int?
    var postTitle: String?
    var postBody: String?
    var username: String?
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var comments: [Comment] = []
    
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
        
        if let username = username {
            usernameLabel.text = username
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(usernameTapped(sender:)))
        usernameLabel.isUserInteractionEnabled = true
        usernameLabel.addGestureRecognizer(tap)
    }
    
    @objc func usernameTapped(sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "UserDetail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserDetail") as! UserDetailViewController
        vc.userId = self.userId
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func getCommentsByPostId(_ id: Int) {
        if let postUrl = Constants.postUrl {
            URLSession.shared.request(url: URL(string: "\(postUrl)/\(id)/comments"), expecting: [Comment].self) { [weak self] result in
                switch result {
                case .success(let comments):
                    DispatchQueue.main.async {
                        self?.comments = comments
                        
                        if let count = self?.comments.count {
                            self?.commentLabel.text = "\(count) Comments"
                        }
                        
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}

extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
        cell.selectionStyle = .none
        cell.authorLabel.text = comments[indexPath.row].email.components(separatedBy: "@")[0]
        cell.commentBodyLabel.text = comments[indexPath.row].body
        
        return cell
    }
    
}
