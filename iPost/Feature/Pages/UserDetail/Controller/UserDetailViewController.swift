//
//  UserDetailViewController.swift
//  iPost
//
//  Created by Stefan Adisurya on 17/10/21.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var userId: Int?
    var albumArr: [Album] = []
    
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
        ConsumeAPI.loadData(from: "https://jsonplaceholder.typicode.com/users/\(id)") { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let dataJSON = try JSONDecoder().decode(User.self, from: data)
                
                DispatchQueue.main.async {
                    self.nameLabel.text = dataJSON.name
                    self.emailLabel.text = dataJSON.email
                    self.addressLabel.text = "\(dataJSON.address.street), \(dataJSON.address.suite), \(dataJSON.address.city)"
                    self.companyLabel.text = "\(dataJSON.company.name)"
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func getAlbumByUserId(_ id: Int) {
        ConsumeAPI.loadData(from: "https://jsonplaceholder.typicode.com/albums?userId=\(id)") { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                self.albumArr = try JSONDecoder().decode([Album].self, from: data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
}

extension UserDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumTableViewCell
        cell.selectionStyle = .none
        cell.albumNameLabel.text = albumArr[indexPath.row].title.capitalized
        
        return cell
    }
    
}
