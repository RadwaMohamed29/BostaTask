//
//  PhotoViewController.swift
//  BostaTask
//
//  Created by Radwa on 07/03/2023.
//

import UIKit
import Kingfisher

class PhotoViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var image: UIImageView!
    var Url: String?
    var photoTitle: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = photoTitle
        setUpScrollView()
    }
    func setUpScrollView(){
        let url = URL(string: Url ?? "")
        image.kf.setImage(with: url)
        scrollView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareDataTapped))
    }
    
    func shareData(data: [Any], barButtonItem: UIBarButtonItem?){
        let activityViewController = UIActivityViewController(activityItems: data, applicationActivities: [])
        activityViewController.popoverPresentationController?.barButtonItem = barButtonItem
        present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func shareDataTapped(){
        guard let photoURL = Url else{ return }
        shareData(data: [photoURL], barButtonItem: navigationItem.rightBarButtonItem)
    }
    
    
    
}

extension PhotoViewController: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return image
    }
}
