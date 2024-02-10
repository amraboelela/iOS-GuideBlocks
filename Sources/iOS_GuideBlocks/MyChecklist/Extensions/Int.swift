//
//  Int.swift
//  iOS-GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/9.
//  Copyright © 2024 Contextual.
//

import Foundation

extension Int {
    func isPrime() -> Bool {
        let value = abs(self)
        if value == 0 || value == 1 {
            return false
        }
        for divisor in 2..<value {
            if self % divisor == 0 {
                return false
            }
        }
        return true
    }
}
