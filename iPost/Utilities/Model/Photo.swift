//
//  Photo.swift
//  iPost
//
//  Created by Stefan Adisurya on 18/10/21.
//

import Foundation

struct Photo: Codable {
    let albumId, id: Int
    let title: String
    let url, thumbnailUrl: String
}
