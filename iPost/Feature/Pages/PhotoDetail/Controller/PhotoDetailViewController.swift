//
//  PhotoDetailViewController.swift
//  iPost
//
//  Created by Stefan Adisurya on 18/10/21.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    var photoId: Int?
    var photoArr: [Photo] = []
    
    @IBOutlet weak var fullImage: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPhotoDetailById((photoId ?? 1) + 1)
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
    }
    
    private func getPhotoDetailById(_ id: Int) {
        ConsumeAPI.loadData(from: "https://jsonplaceholder.typicode.com/albums/1/photos?id=\(id)") { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                self.photoArr = try JSONDecoder().decode([Photo].self, from: data)
                
                DispatchQueue.main.async {
                    self.getImage()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func getImage() {
        ConsumeAPI.loadData(from: self.photoArr[0].thumbnailUrl) {
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
