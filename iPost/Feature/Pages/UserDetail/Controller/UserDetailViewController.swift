//
//  UserDetailViewController.swift
//  iPost
//
//  Created by Stefan Adisurya on 17/10/21.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var userId: Int?
    var albums: [Album] = []
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserById(userId ?? 1)
        setUpCell()
        getAlbumByUserId(userId ?? 1)
    }
    
    private func setUpCell() {
        tableView.register(UINib(nibName: "AlbumTableViewCell", bundle: nil), forCellReuseIdentifier: "AlbumCell")
    }
    
    private func getUserById(_ id: Int) {
        if let userUrl = Constants.userUrl {
            URLSession.shared.request(url: URL(string: "\(userUrl)/\(id)"), expecting: User.self) { [weak self] result in
                switch result {
                case .success(let user):
                    DispatchQueue.main.async {
                        self?.nameLabel.text = user.name
                        self?.emailLabel.text = user.email
                        self?.addressLabel.text = "\(user.address.street), \(user.address.suite), \(user.address.city)"
                        self?.companyLabel.text = "\(user.company.name)"
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func getAlbumByUserId(_ id: Int) {
        if let albumUrl = Constants.albumUrl {
            URLSession.shared.request(url: URL(string: "\(albumUrl)?userId=\(id)"), expecting: [Album].self) { [weak self] result in
                switch result {
                case .success(let albums):
                    DispatchQueue.main.async {
                        self?.albums = albums
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}

extension UserDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumTableViewCell
        cell.selectionStyle = .none
        cell.albumNameLabel.text = albums[indexPath.row].title.capitalized
        
        cell.didSelectItemAction = { [weak self] indexPath in
            let storyboard = UIStoryboard(name: "PhotoDetail", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PhotoDetail") as! PhotoDetailViewController
            vc.photoId = indexPath.row
            
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        return cell
    }
    
}
