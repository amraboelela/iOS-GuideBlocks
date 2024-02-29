//
//  Date.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/18.
//  Copyright © 2024 Contextual.
//

import Foundation

extension Date {
    
    public static var now: Int {
        return Int(Date().timeIntervalSince1970)
    }
}
