//
//  BallsFileManager.swift
//  NBingo
//
//  Created by Anish on 4/15/22.
//  Copyright © 2022 Anish. All rights reserved.
//

import Foundation

class BallsFileManager {
    static let ballKey = "balls"
    
    static func saveBalls(balls: [Ball]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(balls), forKey:ballKey)
    }
    
    static func fetchBalls() -> [Ball]? {
        guard let data = UserDefaults.standard.value(forKey:ballKey) as? Data else {
            return nil
        }
        
        return try? PropertyListDecoder().decode(Array<Ball>.self, from: data)
    }
}
