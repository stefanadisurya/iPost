//
//  PhotoDetailViewController.swift
//  iPost
//
//  Created by Stefan Adisurya on 18/10/21.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    var photoId: Int?
    var photos: [Photo] = []
    
    @IBOutlet weak var imageTitleLabel: UILabel!
    @IBOutlet weak var fullImage: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPhotoDetailById((photoId ?? 1) + 1)
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
    }
    
    private func getPhotoDetailById(_ id: Int) {
        URLSession.shared.request(url: URL(string: "https://jsonplaceholder.typicode.com/albums/1/photos?id=\(id)"), expecting: [Photo].self) { [weak self] result in
            switch result {
            case .success(let photos):
                DispatchQueue.main.async {
                    self?.photos = photos
                    
                    if let title = self?.photos[0].title.capitalized {
                        self?.imageTitleLabel.text = "\(title)"
                    }
                    self?.getImage()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getImage() {
        URLSession.shared.request(url: URL(string: self.photos[0].thumbnailUrl), expecting: [Photo].self) { [weak self] result in
            switch result {
            case .success(let photos):
                DispatchQueue.main.async {
                    self?.photos = photos
                    
                    if let title = self?.photos[0].title.capitalized {
                        self?.imageTitleLabel.text = "\(title)"
                    }
                    self?.getImage()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }                  
        
        ConsumeAPI.loadData(from: self.photos[0].thumbnailUrl) {
            data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.fullImage.image = UIImage(data: data)
            }
        }
    }
    
}

extension PhotoDetailViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return fullImage
    }
    
}
