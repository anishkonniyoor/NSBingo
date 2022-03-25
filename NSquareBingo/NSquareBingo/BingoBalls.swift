//
//  BingoBalls.swift
//  NSquareBingo
//
//  Created by Anish on 3/11/22.
//  Copyright © 2022 Anish. All rights reserved.
//

import Foundation

struct Ball {
    var colKey: String
    var rowValue: Int
    
    var selectedIndex: Int?
    
    init(colKey: String, rowValue: Int) {
        self.colKey = colKey
        self.rowValue = rowValue
        selectedIndex = nil
    }
}

extension Ball {
    var displayText: String {
        "\(colKey)\(rowValue)"
    }
}

