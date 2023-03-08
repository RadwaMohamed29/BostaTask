//
//  AlbumDetailsViewModel.swift
//  BostaTask
//
//  Created by Radwa on 07/03/2023.
//

import Foundation
import RxSwift
protocol AlbumDetailsViewModelProtocol{
    var photoObservable: Observable<Photos>{get set}
    func getPhotos(albumID: String)
}

class AlbumDetailsViewModel: AlbumDetailsViewModelProtocol{
    var photoObservable: Observable<Photos>
    private var photoSubject: PublishSubject = PublishSubject<Photos>()
    private let networkManager: NetworkManager
    private var listOfPhotos : Photos = []
    
    
    init(networkManager: NetworkManager = NetworkManager()){
        self.networkManager = networkManager
        photoObservable = photoSubject.asObserver()
    }
    
    func getPhotos(albumID: String) {
        networkManager.getAllPhotos(albumID: albumID, completion: { [weak self] result in
            switch result {
            case .success(let response):
                let photos = response
                self?.listOfPhotos = photos
                self?.photoSubject.asObserver().onNext(photos)
            case .failure(_):
                self?.photoSubject.asObserver().onError(ResponseError.invalidData)
            }
            
        })
    }
    
    
}
