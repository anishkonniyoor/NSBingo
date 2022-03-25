//
//  ViewController.swift
//  NSquareBingo
//
//  Created by Anish on 3/11/22.
//  Copyright © 2022 Anish. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
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

    @IBAction private func rollTapped(sender: NSButton) {
        print("value \(balls.randomElement()?.displayText ?? "")")
    }
}

private extension ViewController {
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
