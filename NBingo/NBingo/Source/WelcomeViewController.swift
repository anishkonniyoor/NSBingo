//
//  WelcomeViewController.swift
//  NBingo
//
//  Created by Anish on 3/26/22.
//  Copyright © 2022 Anish. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

extension WelcomeViewController {
    private func routeToGame() {
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    @IBAction private func startNewTapped(sender: UIButton) {
        print("Start New")
        routeToGame()
    }
    
    @IBAction private func openPreviousTapped(sender: UIButton) {
        print("Open Previous")
        routeToGame()
    }
}

