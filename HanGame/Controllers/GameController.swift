//
//  GameController.swift
//  HanGame
//
//  Created by Stephane Mulot on 27/09/2019.
//  Copyright © 2019 Stephane Mulot. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    @IBOutlet weak var webViewController: UIWebView!
    @IBOutlet weak var inputController: UITextField!
    @IBOutlet weak var wordController: UILabel!
    @IBOutlet weak var lettersTriedController: UILabel!
    
    var guess = Guess()
    var letters: [Character:Bool] = ["A": false, "B": false, "C": false, "D": false, "E": false, "F": false, "G": false, "H": false, "I": false, "J": false, "K": false, "L": false, "M": false, "N": false, "O": false, "P": false, "Q": false, "R": false, "S": false, "T": false, "U": false, "V": false, "W": false, "X": false, "Y": false, "Z": false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setGuess()
    }
    
    func setGuess() {
        _ = GuessManager.getRandomGuess().done {
            (g) in
            self.guess.name = g.name
            self.guess.image = g.image
            self.guess.found = g.found
            self.webViewController.loadRequest(URLRequest(url: URL(string: g.image)!))
            self.setName()
            self.lettersTriedController.text = "Letters you tried :\n"
        }
    }
    
    func setName() {
        wordController.text = ""
        for letter in guess.name {
            if letters.keys.contains(letter) && !letters[letter]! {
                wordController.text = (wordController.text ?? "") + "_ "
            }
            else {
                wordController.text = (wordController.text ?? "") + String(letter) + " "
            }
        }
    }
    
    
    @IBAction func inputAction(_ sender: Any) {
        if inputController.text!.count == 1
        && letters.keys.contains(Character(inputController.text!))
        && letters[Character(inputController.text!)] == false {
            letters[Character(inputController.text!)] = true
            lettersTriedController.text = (lettersTriedController.text ?? "") + inputController.text! + " "
        }
        inputController.text = ""
        setName()
    }
}

