//
//  APIServices.swift
//  BostaTask
//
//  Created by Radwa on 07/03/2023.
//

import Foundation
import Moya
import SwiftUI

enum APIService{
    case getUser
    case getUserAlbums(userID: String)
    case getAllPhotos(albumID: String)
}

extension APIService: TargetType{
    var baseURL: URL {
        guard let url = URL(string: URLs.baseUrl) else{
            fatalError(ResponseError.invalidURL.rawValue)
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getUser:
            return "/7"
        case .getUserAlbums(let userID):
            return "/\(userID)/albums"
        case .getAllPhotos(let albumID):
            return "/\(albumID)/photos"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
