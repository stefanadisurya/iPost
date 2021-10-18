//
//  UserDetailViewController.swift
//  iPost
//
//  Created by Stefan Adisurya on 17/10/21.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var userId: Int?
    var photoArr: [Photo] = []
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserById(userId ?? 1)
        setUpCell()
        getPhotos()
    }
    
    func setUpCell() {
        collectionView.register(UINib(nibName: "AlbumCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 150, height: 150)
        }
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
    
    private func getPhotos() {
        ConsumeAPI.loadData(from: "https://jsonplaceholder.typicode.com/albums/1/photos") { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                self.photoArr = try JSONDecoder().decode([Photo].self, from: data)

                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
}

extension UserDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! AlbumCollectionViewCell
        
        ConsumeAPI.loadData(from: self.photoArr[indexPath.row].thumbnailUrl) {
            data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                cell.photo.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
}
