//
//  NSArray.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/12.
//  Copyright © 2024 Contextual.
//

import Foundation

extension NSArray {
    func toString() -> String? {
        do {
            // Convert NSDictionary to Data
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            
            // Convert Data to JSON string
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print("Error:", error.localizedDescription)
            return nil
        }
        return nil
    }
    
    func toData() -> Data? {
        do {
            // Convert NSDictionary to Data
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            return jsonData
        } catch {
            print("Error:", error.localizedDescription)
            return nil
        }
    }
}
