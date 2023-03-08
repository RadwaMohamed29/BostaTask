//
//  AlbumDetailsViewController.swift
//  BostaTask
//
//  Created by Radwa on 06/03/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import KRProgressHUD

class AlbumDetailsViewController: UIViewController {

    @IBOutlet weak var photosCV: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var albumID: String?
    var albumTitle: String?
    var albumDetail: AlbumDetailsViewModelProtocol = AlbumDetailsViewModel()
    let disposeBag = DisposeBag()
    var listOfPhotos : Photos = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = albumTitle
        let PhotoCell = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        photosCV.register(PhotoCell, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        self.photosCV.delegate=self
        self.photosCV.dataSource=self
        setubSearchBar()
        getAllPhotos(ID: albumID ?? "")

        
    }
    
    func getAllPhotos(ID: String){
        KRProgressHUD.show()
        albumDetail.getPhotos(albumID: ID)
        albumDetail.photoObservable.subscribe(on:
        ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.asyncInstance)
            .subscribe{ [self] photo in
                KRProgressHUD.dismiss()
                listOfPhotos = photo
                photosCV.reloadData()
                       
            } onError: { _ in
                print(ResponseError.invalidData)
            }.disposed(by: disposeBag)
    }
    
    func setubSearchBar(){
        searchBar.rx.text.orEmpty.throttle(RxTimeInterval.microseconds(500), scheduler: MainScheduler.asyncInstance)
            .distinctUntilChanged()
            .subscribe { result in
                self.albumDetail.searchWithWord(word: result)
            } .disposed(by: disposeBag)
    }
    
    



}

extension AlbumDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        
        let url = URL(string: listOfPhotos[indexPath.row].url )
        cell.photoImageView.kf.setImage(with: url)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.2
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }


    
    
}
