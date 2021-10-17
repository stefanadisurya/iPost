//
//  Post.swift
//  iPost
//
//  Created by Stefan Adisurya on 16/10/21.
//

import Foundation

struct PostData: Codable {
    var userId, id: Int
    var title, body: String
}
