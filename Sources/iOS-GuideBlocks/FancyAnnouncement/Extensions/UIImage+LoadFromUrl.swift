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
