//
//  User.swift
//  BostaTask
//
//  Created by Radwa on 07/03/2023.
//

import Foundation

struct User: Codable {

    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case username = "username"
        case email = "email"
        case address = "address"
        case phone = "phone"
        case website = "website"
        case company = "company"
    }

}


struct Address: Codable {

    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo

    private enum CodingKeys: String, CodingKey {
        case street = "street"
        case suite = "suite"
        case city = "city"
        case zipcode = "zipcode"
        case geo = "geo"
    }

}
struct Geo: Codable {

    let lat: String
    let lng: String

    private enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lng = "lng"
    }

}
struct Company: Codable {

    let name: String
    let catchPhrase: String
    let bs: String

    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case catchPhrase = "catchPhrase"
        case bs = "bs"
    }

}
