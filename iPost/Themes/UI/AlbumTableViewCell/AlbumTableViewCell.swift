//
//  AlbumTableViewCell.swift
//  iPost
//
//  Created by Stefan Adisurya on 18/10/21.
//

import UIKit

class AlbumTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    var didSelectItemAction: ((IndexPath) -> Void)?
    
    var photoArr: [Photo] = []
    
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        setUpCell()
        
        getPhotosByAlbumId()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCell() {
        collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 150, height: 150)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        
        ConsumeAPI.loadData(from: self.photoArr[indexPath.row].thumbnailUrl) {
            data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                cell.photo.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAction?(indexPath)
    }
    
    private func getPhotosByAlbumId() {
        if let albumUrl = Constants.albumUrl {
            ConsumeAPI.loadData(from: "\(albumUrl)/1/photos") { data, response, error in
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
    
}
