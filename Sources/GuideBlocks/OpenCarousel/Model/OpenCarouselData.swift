//
//  OpenCarouselData.swift
//
//
//  Created by Aamir on 10/02/24.
//

import ContextualSDK
import SwiftUI

struct OpenCarouselDataManager {
    var carouselItems: [OpenCarouselData] = []
    
    init(guide: SHTipElement) {
        
        let backgroundImages = guide.arrayImages

        guard let carouselData = guide.carousel,
              let items = carouselData.items else {
            carouselItems = []
            return
        }

        for (index, item) in items.enumerated() {
            var _bgImageElement: SHTipImageElement?
            
            if (backgroundImages ?? []).indices.contains(index) {
                _bgImageElement = backgroundImages?[index]
            }
            
            carouselItems.append(OpenCarouselData(id: index,
                                                  carouselData: item,
                                                  isLastScreen: (index == items.count - 1),
                                                  backgroundImage: _bgImageElement))
            
        }
    }
}

struct OpenCarouselData: Hashable, Identifiable {
    
    // ID
    let id: Int
    
    // This will represents both title and subtitle for carousel.
    var carouselDataItem: SHTipCarouselItem?
        
    // It will have center image of screen.
    var primaryImageUrl: String?
    
    // It will have background image of screen.
    var backgroundImage: SHTipImageElement?
    
    // Usually Button with text `Next`.
    var button: SHTipButtonElement?
    //
    var totalCarouselsCount: Int?
    
    // Used to dismiss screen if last screen from array is reached.
    var isLastScreen = false
    
    //Default URLs if in case Dashboard returns nil
    private let placeholderBackgroundImageURL = "https://picsum.photos/seed/picsum/200/300"
    private let placeholderPrimaryImageURL = "https://picsum.photos/id/870/200/300?grayscale&blur=2"
    
    //MARK: Init
    // Used for debug
    init(id: Int,
         isLastScreen: Bool = false) {
        self.id = id
        self.totalCarouselsCount = 3
        self.isLastScreen = isLastScreen
    }
    
    init(id: Int,
         carouselData: SHTipCarouselItem,
         isLastScreen: Bool,
         backgroundImage: SHTipImageElement?) {
        
        print("CAROUSEL DATA ITEM id \(id) carouselDataItem \(carouselDataItem) isLastScreen \(isLastScreen)")
        print("CAROUSEL DATA ITEM image \(carouselData.image) image Source \(carouselData.imageSource) \n icon \(carouselData.icon) icon source \(carouselData.iconSource)")
        
        self.id = id
        self.carouselDataItem = carouselData
        self.isLastScreen = isLastScreen
        self.primaryImageUrl = carouselData.imageSource
        self.button = carouselData.button
        self.backgroundImage = backgroundImage
    }
    
    //MARK: Loading Image
    func loadBackgroundImage(completion: @escaping ((Image) -> ())) {
        loadImage(imageURLString: backgroundImage?.resource ?? placeholderBackgroundImageURL) { loadedImage in
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
