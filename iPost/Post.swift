//
//  Post.swift
//  iPost
//
//  Created by Stefan Adisurya on 16/10/21.
//

import Foundation

struct PostData: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

typealias Post = [PostData]
