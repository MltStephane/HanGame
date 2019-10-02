//
//  GameController.swift
//  HanGame
//
//  Created by Stephane Mulot on 27/09/2019.
//  Copyright © 2019 Stephane Mulot. All rights reserved.
//

import UIKit
import CoreData

class GameController: UIViewController {
    
    @IBOutlet weak var webViewController: UIWebView!
    @IBOutlet weak var inputController: UITextField!
    @IBOutlet weak var wordController: UILabel!
    @IBOutlet weak var lettersTriedController: UILabel!
    @IBOutlet weak var imageController: UIImageView!
    
    var guess = Guess()
    var letters: [Character:Bool] = ["A": false, "B": false, "C": false, "D": false, "E": false, "F": false, "G": false, "H": false, "I": false, "J": false, "K": false, "L": false, "M": false, "N": false, "O": false, "P": false, "Q": false, "R": false, "S": false, "T": false, "U": false, "V": false, "W": false, "X": false, "Y": false, "Z": false]
    var life = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteData()
        self.setGuess(resetLife: true)
    }
    
    func setGuess(resetLife: Bool) {
        for letter in self.letters.keys {
            self.letters[letter] = false
        }
        _ = GuessManager.getRandomGuess().done {
            (g) in
            self.guess.name = g.name
            self.guess.image = g.image
            self.guess.found = g.found
            self.webViewController.loadRequest(URLRequest(url: URL(string: g.image)!))
            self.lettersTriedController.text = "Letters you tried :\n"
            if resetLife {
                self.life = 8
            }
            self.setImage()
            self.inputController.becomeFirstResponder()
            self.setName()
            print(self.guess.name)
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
    
    func setImage() {
        imageController.image = UIImage(named: "pendu_\(life)")!
    }
    
    
    @IBAction func inputAction(_ sender: UITextInput) {
        if inputController.text!.count == 1
            && letters.keys.contains(Character(inputController.text!))
            && letters[Character(inputController.text!)] == false {
            letters[Character(inputController.text!)] = true
            lettersTriedController.text = (lettersTriedController.text ?? "") + inputController.text! + " "
            if !guess.name.contains(Character(inputController.text!)) {
                life -= 1
            }
            
            setName()
            setImage()
            
            checkWinLose()
        }
        inputController.text = ""
    }
    
    func saveSuccess(found: Bool) {
        let successGuess = GuessDB(context: AppDelegate.viewContext)
        
        successGuess.name = guess.name
        successGuess.image = guess.image
        successGuess.found = found
        
        do {
            try AppDelegate.viewContext.save()
        }catch {
            print("oups fail")
        }
    }
    
    func checkWinLose() {
        if !wordController.text!.contains("_") {
            saveSuccess(found: true)
            setGuess(resetLife: true)
        }
        else if life == 0 {
            saveSuccess(found: false)
            self.performSegue(withIdentifier: "scoreViewSegue", sender: nil)
        }
    }
    
    func deleteData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GuessDB")
        
        do {
            let list = try managedContext.fetch(fetchRequest)
            
            for item in list {
                managedContext.delete(item as! NSManagedObject)
            }
            
            do {
                try managedContext.save()
            }
            catch {
                print(error)
            }
        }
        catch {
            print(error)
        }
    }
    
    @IBAction func skipAction(_ sender: Any) {
        saveSuccess(found: false)
        setGuess(resetLife: false)
    }
}
