//
//  StartPageViewController.swift
//  CS329E_FinalProject
//
//  Created by Samira Ravilisetty on 12/5/22.
//

import UIKit

class StartPageViewController: UIViewController {
    @IBOutlet weak var logoImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImage.image = UIImage(named: "groceriesforu-logo")
        spinLogo()
    }
        
    func spinLogo(){
        self.logoImage.center.x = self.view.center.x + self.view.bounds.width
        
        UIView.animate(
            withDuration: 3.0,
            animations: {
                self.logoImage.center.x -= self.view.bounds.width
            }
        )
    }
}
   
