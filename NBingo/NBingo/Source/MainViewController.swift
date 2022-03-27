//
//  MainViewController.swift
//  NBingo
//
//  Created by Anish on 3/26/22.
//  Copyright © 2022 Anish. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
        enum Constants {
        static let keyCount = 15
        static let rollingMinTime = 10
        static let rollingMaxTime = 30
    }
    
    var balls = [Ball]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        super.viewWillDisappear(animated)
    }
}

private extension MainViewController {
    @IBAction private func rollTapped(sender: UIButton) {
        let selectedBall = balls.randomElement
        
        print("value \(balls.randomElement()?.displayText ?? "")")
        
    }
    
    @IBAction private func showBoardTapped(sender: UIButton) {
        print("Show Board")
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let boardViewController = storyBoard.instantiateViewController(withIdentifier: "BoardViewController") as! BoardViewController
        navigationController?.pushViewController(boardViewController, animated: true)
    }
    
    @IBAction private func closeTapped(sender: UIButton) {
        print("Close")
        navigationController?.popViewController(animated: true)
    }
}

private extension MainViewController {
    func setup() {
        
        balls = loadBalls()
        print("\(balls.map { $0.displayText })")
    }
    
    func loadBalls() -> [Ball] {
        let keys = ["B", "I", "N", "G", "O"]
        var index = 1
        return keys.reduce([Ball]()) {
            let keyBasedBalls = $0 + balls(key: $1, start: index, count: Constants.keyCount)
            index += Constants.keyCount
            return keyBasedBalls
        }
    }
    
    func balls(key: String, start: Int, count: Int) -> [Ball] {
        let rowValues = start...(start + count - 1)
        return rowValues.map { Ball(colKey: key, rowValue: $0) }
    }
}
