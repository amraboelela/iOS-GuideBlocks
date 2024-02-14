//
//  String.swift
//  SwiftLevelDB
//
//  Created by Amr Aboelela on 7/31/18.
//  Copyright © 2018 Amr Aboelela.
//
//  See LICENCE for details.
//

import Foundation

public extension String {
    
    func truncate(length: Int, trailing: String = "…") -> String {
        if self.count > length {
            return String(self.prefix(length)) + trailing
        } else {
            return self
        }
    }
    
}
