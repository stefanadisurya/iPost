//
//  UserDetailViewController.swift
//  iPost
//
//  Created by Stefan Adisurya on 17/10/21.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var userId: Int?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserById(userId ?? 1)
    }
    
    private func getUserById(_ id: Int) {
        let request = NSMutableURLRequest(url: NSURL(string: "https://jsonplaceholder.typicode.com/users/\(id)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if error != nil {
                print(error as Any)
            } else {
                if let data = data {
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
        })
        
        dataTask.resume()
    }
    
}
