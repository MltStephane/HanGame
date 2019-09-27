//
//  Guess.swift
//  HanGame
//
//  Created by Alexis Dupre on 27/09/2019.
//  Copyright © 2019 Stephane Mulot. All rights reserved.
//

import Foundation

class Guess {
    
    var name: String
    var image: String
    
    init(name: String = "", image: String = "") {
        self.name = name
        self.image = image
    }
}
