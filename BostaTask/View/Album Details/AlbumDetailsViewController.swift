//
//  AlbumDetailsViewController.swift
//  BostaTask
//
//  Created by Radwa on 06/03/2023.
//

import UIKit

class AlbumDetailsViewController: UIViewController {

    @IBOutlet weak var photosCV: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Album Name"
        let PhotoCell = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        photosCV.register(PhotoCell, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        self.photosCV.delegate=self
        self.photosCV.dataSource=self
        setUpCell()

        
    }
    



}

extension AlbumDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell

        return cell
    }
    func setUpCell(){
        if let layout = photosCV?.collectionViewLayout as? UICollectionViewFlowLayout{
                layout.minimumLineSpacing = 10
                layout.minimumInteritemSpacing = 10
                layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                let size = CGSize(width:(photosCV!.bounds.width-30)/2, height: 250)
                layout.itemSize = size
        }
    }

    
    
}
