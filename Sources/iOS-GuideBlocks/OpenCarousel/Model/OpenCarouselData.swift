//
//  OpenCarouselData.swift
//
//
//  Created by Aamir on 10/02/24.
//

import ContextualSDK
import SwiftUI

struct OpenCarouselData: Hashable, Identifiable {
    
    let id: Int
    
    var title: SHTipTextElement?
    var subtitle: String?
        
    var primaryImageUrl: String?
    var backgroundImageURL: String?
    
    var totalCarouselsCount: Int?
    
    var isLastScreen = false
    
    private let placeholderBackgroundImageURL = "https://picsum.photos/seed/picsum/200/300"
    private let placeholderPrimaryImageURL = "https://picsum.photos/id/870/200/300?grayscale&blur=2"
    
    
    init(guide: SHTipElement) {
        
        // will change later.
        self.id = [0,1,2].randomElement() ?? 0
        self.title = guide.title
        
        guard let json = guide.extraJson else { return }
        
        //TODO: KVPs are going to change later.
        if let subtitle = json["subtitle"] as? String {
            self.subtitle = subtitle
        }
        
        if let primaryImageUrl = json["primaryImageUrl"] as? String {
            self.primaryImageUrl = primaryImageUrl
        }
        
        if let backgroundImageURL = json["backgroundImageURL"] as? String {
            self.backgroundImageURL = backgroundImageURL
        }
        
        if let totalCarouselsCount = json["totalCarouselsCount"] as? Int {
            self.totalCarouselsCount = totalCarouselsCount
        }
    }
    
    // Added init for debug
    init(id: Int,isLastScreen: Bool = false) {
        self.id = id
        self.title = SHTipTextElement()
        self.subtitle = "subtitle"
        self.totalCarouselsCount = 3
        self.isLastScreen = isLastScreen
    }
    
    static let list: [OpenCarouselData] = [
        OpenCarouselData(id: 1),
        OpenCarouselData(id: 2),
        OpenCarouselData(id: 3, isLastScreen: true)
    ]
    
    
    //MARK: Loading Image
    func loadBackgroundImage(completion: @escaping ((Image) -> ())) {
        loadImage(imageURLString: backgroundImageURL ?? placeholderBackgroundImageURL) { loadedImage in
            guard let loadedImage = loadedImage else {
                completion(Image("person.circle.fill"))
                return
            }
            completion(loadedImage)
        }
    }
    
    func loadPrimaryImage(completion: @escaping ((Image) -> ())) {
        loadImage(imageURLString: primaryImageUrl ?? placeholderPrimaryImageURL) { loadedImage in
            guard let loadedImage = loadedImage else {
                completion(Image("person.circle.fill"))
                return
            }
            completion(loadedImage)
        }
    }
    
    private func loadImage(imageURLString: String?, completion: @escaping ((Image?) -> ())) {
        if let imageURL = imageURLString,
           let url = URL(string: imageURL) {
            UIImage.loadFromUrl(url, completion: { image in
                if let image = image {
                    completion(Image(uiImage: image))
                } else {
                    completion(nil)
                }
            })
        } else {
            completion(nil)
        }
    }
}
