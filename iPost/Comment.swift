//
//  Comment.swift
//  iPost
//
//  Created by Stefan Adisurya on 17/10/21.
//

import Foundation

struct CommentData: Codable {
    let postId, id: Int
    let name, email, body: String
}
