//
//  ListController.swift
//  HanGame
//
//  Created by Alexis Dupre on 27/09/2019.
//  Copyright © 2019 Stephane Mulot. All rights reserved.
//

import UIKit

class ListController: UIViewController {
    
    var listGuesses = [Guess]()
    
    @IBOutlet weak var tableController: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listGuesses = Guess.getSuccessGuess()
        tableController.register(UINib(nibName: "ScoreCell",bundle: nil), forCellReuseIdentifier: "ScoreCell")
    }
}
extension ListController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listGuesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath) as! ScoreCell
        
        cell.nameController.text = listGuesses[indexPath.row].name
        cell.webViewController.loadRequest(URLRequest(url: URL(string: listGuesses[indexPath.row].image)!))
        
        return cell
    }
    
}
