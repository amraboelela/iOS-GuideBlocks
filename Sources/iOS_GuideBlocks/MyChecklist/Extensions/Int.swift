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
        if self == 1 {
            return false
        }
        for divisor in 2..<self {
            if self % divisor == 0 {
                return false
            }
        }
        return true
    }
}
