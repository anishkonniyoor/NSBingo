//
//  BingoBalls.swift
//  NSquareBingo
//
//  Created by Anish on 3/11/22.
//  Copyright © 2022 Anish. All rights reserved.
//

import Foundation

struct Ball {
    let colKey: String
    let rowValue: Int
    
    var selectedIndex: Int?
    
    init(colKey: String, rowValue: Int) {
        self.colKey = colKey
        self.rowValue = rowValue
        selectedIndex = nil
    }
}

extension Ball {
    var isSelected: Bool {
        selectedIndex != nil
    }
    
    var displayText: String {
        "\(colKey)\(rowValue)"
    }
    
    func updated(selectedIndex: Int?) -> Ball {
        var newBall = self
        newBall.selectedIndex = selectedIndex
        return newBall
    }
}

extension Ball: Hashable {
    static func ==(lhs: Ball, rhs: Ball) -> Bool {
        (lhs.rowValue == rhs.rowValue) && (lhs.colKey == rhs.colKey)
    }
}

extension Collection where Element == Ball {
    var remainingBalls: [Ball] {
        filter { !$0.isSelected }
    }
    
    var selectedBalls: [Ball] {
        filter { $0.isSelected }
    }
    
    var currentIndex: Int {
        compactMap { $0.selectedIndex }.max() ?? 0
    }
}

extension MutableCollection where Element == Ball {
    mutating func selectBall(ball: Ball) -> Bool {
        guard let index = firstIndex(of: ball), !ball.isSelected else {
            return false
        }
        let nextIndex = currentIndex + 1
        guard nextIndex <= count else { return false }
        
        self[index] = ball.updated(selectedIndex: nextIndex)
        
        return true
    }
}

