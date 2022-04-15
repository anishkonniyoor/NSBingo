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
        static let recentBalls = 5
        static let recentText = "Recent Numbers"
        static let showAlert = true
    }
    
    @IBOutlet private weak var recentLabel: UILabel!
    
    var bingoBalls: [Ball] = []
    
    lazy var textToSpeechManager: TextToSpeechManager = {
        TextToSpeechManager()
    }()
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
        guard let selectedBall = bingoBalls.remaining.randomElement(),
            bingoBalls.selectBall(ball: selectedBall) else { return }//TODO: Use wheel to pick the ball
        
        textToSpeechManager.speak(speechText: selectedBall.displayText)
        
        let completion: () -> () = {
            self.updateView()
            print("value \(selectedBall.displayText)")
        }
        
        guard Constants.showAlert else {
            completion()
            return
        }
        
        let alert = UIAlertController(title: selectedBall.displayText, message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        present(alert, animated: true, completion: completion)
    }
    
    @IBAction private func showBoardTapped(sender: UIButton) {
        print("Show Board")
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let boardViewController = storyBoard.instantiateViewController(withIdentifier: "BoardViewController") as! BoardViewController
        boardViewController.boardItems = bingoBalls.selected.toBingoBoardModel()
        navigationController?.pushViewController(boardViewController, animated: true)
    }
    
    @IBAction private func closeTapped(sender: UIButton) {
        print("Close")
        navigationController?.popViewController(animated: true)
    }
}

private extension MainViewController {
    func setup() {
        if bingoBalls.isEmpty {
            bingoBalls = loadBalls()
        }
        updateView()
    }
    
    func updateView() {
        updateRecentBalls()
    }
    
    func updateRecentBalls() {
        let recentText: String  = {
            let recentBalls = bingoBalls.selected.sorted {
                ($0.selectedIndex ?? 0) > ($1.selectedIndex ?? 0)
            }.prefix(Constants.recentBalls)
            guard !recentBalls.isEmpty else {
                return Constants.recentText
            }
            
            return recentBalls.map { $0.displayText }.joined(separator: ", ")
        }()

        recentLabel.text = recentText
        recentLabel.backgroundColor = bingoBalls.remaining.isEmpty ? .green : .yellow
    }
}

private extension MainViewController {
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
