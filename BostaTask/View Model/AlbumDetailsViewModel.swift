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
    func searchWithWord(word:String)
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
    
    func searchWithWord(word: String) {
        if word.isEmpty{
            photoSubject.onNext(listOfPhotos)
            return
        }
        let filteredPhotos = listOfPhotos.filter { photoSearch in
            return photoSearch.title.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).contains(word.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))
        }
        photoSubject.onNext(filteredPhotos)
    }
}
