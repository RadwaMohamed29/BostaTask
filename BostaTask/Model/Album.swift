//
//  Album.swift
//  BostaTask
//
//  Created by Radwa on 07/03/2023.
//

import Foundation
struct Album: Codable {

    let userId: Int
    let id: Int
    let title: String

    private enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id = "id"
        case title = "title"
    }

}
typealias UserAlbums = [Album]
