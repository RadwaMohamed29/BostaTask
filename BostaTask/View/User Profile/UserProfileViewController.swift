//
//  UserProfileViewController.swift
//  BostaTask
//
//  Created by Radwa on 06/03/2023.
//

import UIKit
import RxSwift
import KRProgressHUD

class UserProfileViewController: UIViewController {

    @IBOutlet weak var albumsTV: UITableView!
    @IBOutlet weak var userAddressLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    var userProfile: UserProfileViewModelProtocol = UserProfileViewModel()
    let disposeBag = DisposeBag()
    var user: User?
    var listOfAlbums : UserAlbums = []
    override func viewDidLoad() {
        super.viewDidLoad()
        albumsTV.register(UINib(nibName: "UserAlbumsTableViewCell", bundle: nil), forCellReuseIdentifier: "UserAlbumsTableViewCell")
        albumsTV.delegate = self
        albumsTV.dataSource = self
        getUser()
        getUserAlbums(ID: "\(user?.id ?? 2)")
       
        

       
    }
    
    func getUser(){
        KRProgressHUD.show()
        userProfile.getUser()
        userProfile.userObservable.subscribe(on:
        ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.asyncInstance)
            .subscribe{userDetails in
                KRProgressHUD.dismiss()
                self.user = userDetails
                DispatchQueue.main.async { [self] in
                    userNameLbl.text = user?.name
                    userAddressLbl.text = ("\(user?.address.street ?? " "), \( user?.address.suite ?? " "), \( user?.address.city ?? " "), \( user?.address.zipcode ?? " ")")
                }
                       
            } onError: { _ in
                print(ResponseError.invalidData)
            }.disposed(by: disposeBag)
    }
    
    func getUserAlbums(ID: String){
        userProfile.getUserAlbums(userID: ID)
        userProfile.albumsObservable.subscribe(on:
        ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.asyncInstance)
            .subscribe{ [self]album in
                listOfAlbums = album
                albumsTV.reloadData()
                       
            } onError: { _ in
                print(ResponseError.invalidData)
            }.disposed(by: disposeBag)
    }
    



}
extension UserProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfAlbums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = albumsTV.dequeueReusableCell(withIdentifier: "UserAlbumsTableViewCell", for: indexPath) as? UserAlbumsTableViewCell
        else{
            return UITableViewCell()
        }
        cell.albumNameLbl.text = listOfAlbums[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
