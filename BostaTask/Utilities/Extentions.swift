//
//  Extentions.swift
//  BostaTask
//
//  Created by Radwa on 07/03/2023.
//

import Foundation
import LPSnackbar

extension UIViewController{
    func showSnackBar(){
        
        let snack = LPSnackbar(title: "network is not connected", buttonTitle: "dismiss")
        
        snack.bottomSpacing = (tabBarController?.tabBar.frame.minX ?? 0)
        snack.view.titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        
        snack.show(animated: true) { (undone) in
            if undone {
                snack.dismiss()
            } else {
                snack.show()
            }
        }
    }
    
}
