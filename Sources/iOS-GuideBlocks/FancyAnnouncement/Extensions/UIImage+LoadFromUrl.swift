//
//  UIImage+LoadFromUrl.swift
//  
//
//  Created by Marc Stroebel on 29/1/2024.
//

import UIKit
import SwiftUI

extension UIImage {
    static func loadFromUrl(_ url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                // Once the data is received, create a UIImage from it and update the UI on the main thread
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            } else {
                print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }.resume()
    }
}

//TODO: Need to move this to new file.
extension Color {
    init(uiColor: UIColor) {
        if let components = uiColor.cgColor.components {
            switch components.count {
            case 2: // Grayscale color with alpha
                self.init(white: Double(components[0]), opacity: Double(components[1]))
            case 3: // RGB color without alpha
                self.init(red: Double(components[0]), green: Double(components[1]), blue: Double(components[2]))
            case 4: // RGB color with alpha
                self.init(red: Double(components[0]), green: Double(components[1]), blue: Double(components[2]), opacity: Double(components[3]))
            default:
                // Unsupported color format, fallback to black
                self.init(red: 0, green: 0, blue: 0, opacity: 1)
            }
        } else {
            // Unable to extract components, fallback to black
            self.init(red: 0, green: 0, blue: 0, opacity: 1)
        }
    }
}
