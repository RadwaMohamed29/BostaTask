//
//  NetworkManager.swift
//  BostaTask
//
//  Created by Radwa on 07/03/2023.
//

import Foundation
import Moya

protocol Networkable{
    var provider: MoyaProvider<APIService>{get }
    func getUser(completion: @escaping (Result<User,ResponseError>) -> Void)
    func getUserAlbums(userID: String, completion: @escaping (Result<UserAlbums,ResponseError>) -> Void)
    func getAllPhotos(albumID: String, completion: @escaping (Result<Photos,ResponseError>) -> Void)
}

class NetworkManager: Networkable{
    func getUserAlbums(userID: String, completion: @escaping (Result<UserAlbums, ResponseError>) -> Void) {
        request(target: .getUserAlbums(userID: userID), completion: completion)
    }
    
    func getAllPhotos(albumID: String, completion: @escaping (Result<Photos, ResponseError>) -> Void) {
        request(target: .getAllPhotos(albumID: albumID), completion: completion)
    }
    
    func getUser(completion: @escaping (Result<User, ResponseError>) -> Void) {
        request(target: .getUser, completion: completion)
    }
    
    
    
    var provider = MoyaProvider<APIService>( plugins: [NetworkLoggerPlugin()])
    
    
    
}

extension NetworkManager{
    private func request<T:Codable>(target: APIService, completion:
                                    @escaping (Result<T, ResponseError>) -> Void){
        provider.request(target) { result in
            switch result{
            case let .success(response):
                do{
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(T.self, from: response.data)
                    completion(.success(json))
                }catch(_){
                    completion(.failure(.parsingError))
                }
            case .failure(_):
                completion(.failure(.invalidData))
            }
            
        }
    }
}

