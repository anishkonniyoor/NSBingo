//
//  TextToSpeechManager.swift
//  NBingo
//
//  Created by Anish on 3/28/22.
//  Copyright © 2022 Anish. All rights reserved.
//

import Foundation
import AVFoundation

class TextToSpeechManager {
    let synthesizer: AVSpeechSynthesizer
    init() {
         synthesizer = AVSpeechSynthesizer()
    }
    
    func speak(speechText: String) {
        let speech = AVSpeechUtterance(string: speechText)
        synthesizer.speak(speech)
    }
}
