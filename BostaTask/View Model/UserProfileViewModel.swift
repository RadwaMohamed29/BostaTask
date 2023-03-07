//
//  UserProfileViewModel.swift
//  BostaTask
//
//  Created by Radwa on 07/03/2023.
//

import Foundation
import RxSwift

protocol UserProfileViewModelProtocol{
    var userObservable: Observable<User>{get set}
    var albumsObservable: Observable<UserAlbums>{get set}
    func getUser()
    func getUserAlbums(userID: String)
}

class UserProfileViewModel: UserProfileViewModelProtocol{
    var userObservable: Observable<User>
    var albumsObservable: Observable<UserAlbums>
    private var userSubject: PublishSubject = PublishSubject<User>()
    private let networkManager: NetworkManager
    private var albumsSubject: PublishSubject = PublishSubject<UserAlbums>()
    private var listOfAlbums : UserAlbums = []
    
    
    init(networkManager: NetworkManager = NetworkManager()){
        self.networkManager = networkManager
        userObservable = userSubject.asObserver()
        albumsObservable = albumsSubject.asObserver()
    }
    func getUser() {
        networkManager.getUser(completion: { [weak self] result in
            switch result {
            case .success(let response):
                let userData = response
                self?.userSubject.asObserver().onNext(userData)
            case .failure(_):
                self?.userSubject.asObserver().onError(ResponseError.invalidData)
            }
            
        })
    }
    
    func getUserAlbums(userID: String) {
        networkManager.getUserAlbums(userID: userID,completion: { [weak self] result in
            switch result {
            case .success(let response):
                let userAlbum = response
                self?.listOfAlbums = userAlbum
                self?.albumsSubject.asObserver().onNext(userAlbum)
            case .failure(_):
                self?.albumsSubject.asObserver().onError(ResponseError.invalidData)
            }
            
        })

    }
    
    
}
