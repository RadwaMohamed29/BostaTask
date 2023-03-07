//
//  UserProfileViewController.swift
//  BostaTask
//
//  Created by Radwa on 06/03/2023.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var albumsTV: UITableView!
    @IBOutlet weak var userAddressLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        albumsTV.register(UINib(nibName: "UserAlbumsTableViewCell", bundle: nil), forCellReuseIdentifier: "UserAlbumsTableViewCell")
        albumsTV.delegate = self
        albumsTV.dataSource = self

       
    }


}
extension UserProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = albumsTV.dequeueReusableCell(withIdentifier: "UserAlbumsTableViewCell", for: indexPath) as? UserAlbumsTableViewCell
        else{
            return UITableViewCell()
        }
        
        return cell
    }
    
    
}
