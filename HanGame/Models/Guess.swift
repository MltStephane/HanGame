//
//  Guess.swift
//  HanGame
//
//  Created by Alexis Dupre on 27/09/2019.
//  Copyright © 2019 Stephane Mulot. All rights reserved.
//

import Foundation
import CoreData

class Guess {
    
    var name: String
    var image: String
    var found: Bool
    
    init(name: String = "", image: String = "", found: Bool = false) {
        self.name = name
        self.image = image
        self.found = found
    }
    
    static func getSuccessGuess() -> Int{
        
        var res = 0
        
        do {
            let request: NSFetchRequest<GuessDB> = GuessDB.fetchRequest()
            let guesses = try AppDelegate.viewContext.fetch(request)
            
            for guess in guesses {
                if guess.found == true {
                    res += 1
                }
            }
        }
        catch {
            print("Oups on a pas vraiment réussi a récupérer les valeurs ...")
        }
        
        return res
    }
    
    static func getGuesses() -> [Guess]{
        
        var listGuesses = [Guess]()
        
        do {
            let request: NSFetchRequest<GuessDB> = GuessDB.fetchRequest()
            let guesses = try AppDelegate.viewContext.fetch(request)
            
            for guess in guesses {
                listGuesses.append(Guess(name: guess.name!, image: guess.image!, found: guess.found))
            }
        }
        catch {
            print("Oups on a pas vraiment réussi a récupérer les bonnes réponses ...")
        }
        
        return listGuesses
    }
}
