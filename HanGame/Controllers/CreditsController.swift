//
//  CreditsController.swift
//  HanGame
//
//  Created by Alexis Dupre on 02/10/2019.
//  Copyright © 2019 Stephane Mulot. All rights reserved.
//

import UIKit

class CreditsController: UIViewController {
    
    @IBOutlet weak var labelController: UILabel!
    
    override func viewDidLoad() {
        labelController.text = "App made by :\nDUPRE Alexis\nBOURTAL-ZARAT Médhi\n\nGraphisms made by :\nBOURTAL-ZARAT Médhi\n\nViews made by :\nDUPRE Alexis"
        UIView.animate(withDuration: 0) {
            self.labelController.transform = CGAffineTransform(translationX: 0, y: 100)
        }
    }
    
    func credit() {
        while true {
            print("yo")
            UIView.animate(withDuration: 2.0) {
                self.labelController.transform = CGAffineTransform(translationX: 0, y: -500)
            }
            UIView.animate(withDuration: 0) {
                self.labelController.transform = CGAffineTransform(translationX: 0, y: 100)
            }
        }
    }
    
}
