//
//  GuessManager.swift
//  HanGame
//
//  Created by Alexis Dupre on 27/09/2019.
//  Copyright © 2019 Stephane Mulot. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

struct GuessApi : Codable {
    var name: String?
    var image: String?
}

class GuessManager {
    
    static func getRandomGuess() -> Promise<Guess> {
        return Promise {
            seal in Alamofire.request("https://rickandmortyapi.com/api/character/\(Int.random(in: 0...493))").response{
                response in
                guard let data = response.data else {return}
                do {
                    let decoder = JSONDecoder()
                    let guessApi = try decoder.decode(GuessApi.self, from: data)
                    if let name = guessApi.name, let image = guessApi.image {
                        seal.fulfill(Guess(name : name.uppercased(), image: image, found: false))
                    }
                    else {
                        seal.reject(NSError(domain: "", code: 1, userInfo: nil))
                    }
                }
                catch let error {
                    seal.reject(error)
                }
            }
        }
    }
    
}

