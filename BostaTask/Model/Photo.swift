//
//  Photo.swift
//  BostaTask
//
//  Created by Radwa on 07/03/2023.
//

import Foundation

struct Photo: Codable {

    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String

    private enum CodingKeys: String, CodingKey {
        case albumId = "albumId"
        case id = "id"
        case title = "title"
        case url = "url"
        case thumbnailUrl = "thumbnailUrl"
    }

}
