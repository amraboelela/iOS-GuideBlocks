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
        
        print("CAROUSEL DATA \(guide.carousel.items)")
        
        let backgroundImages = guide.arrayImages
        print("Total Background Images \(backgroundImages)")
        guard let carouselData = guide.carousel,
              let items = carouselData.items else {
            carouselItems = []
            return
        }

        for (index, item) in items.enumerated() {
            var _bgImageElement: SHTipImageElement?
            
            print("CAROUSEL DATA ITEM \(item)")
            if (backgroundImages ?? []).indices.contains(index) {
                _bgImageElement = backgroundImages?[index]
                print("Background Image \(_bgImageElement?.resource)")
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
    
    //TODO: NEED TO REMOVE THIS INIT
    //    init(guide: SHTipElement) {
    //
    //        // will change later.
    //        self.id = [0,1,2].randomElement() ?? 0
    //        self.title = guide.title
    //
    //        guard let json = guide.extraJson else { return }
    //
    //        if let subtitle = json["subtitle"] as? String {
    //            self.subtitle = subtitle
    //        }
    //
    //        if let primaryImageUrl = json["primaryImageUrl"] as? String {
    //            self.primaryImageUrl = primaryImageUrl
    //        }
    //
    //        if let backgroundImageURL = json["backgroundImageURL"] as? String {
    //            self.backgroundImageURL = backgroundImageURL
    //        }
    //
    //        if let totalCarouselsCount = json["totalCarouselsCount"] as? Int {
    //            self.totalCarouselsCount = totalCarouselsCount
    //        }
    //    }
    
    
    //    static let list: [OpenCarouselData] = [
    //        OpenCarouselData(id: 1),
    //        OpenCarouselData(id: 2),
    //        OpenCarouselData(id: 3, isLastScreen: true)
    //    ]
    
    
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

extension SHTipImageElement {
    var imageSize: CGSize {
        
        let percentRange = 0.0...1.0
        
        var width_height: (width: CGFloat,height: CGFloat) = (width, height)
        let screenSize = UIScreen.main.bounds
        
        if percentRange.contains(width) {
        
            width_height.width = screenSize.width * width
        }
        
        if percentRange.contains(height) {
            width_height.height = screenSize.height * height
        }

        return CGSize(width: width_height.width, height: width_height.height)
    }
    
    var imageAligment: Alignment {
        
        if imageAlign == SHTipImageAlignment_LeftTop {
            return .topLeading
        }
        else if imageAlign == SHTipImageAlignment_LeftMiddle {
            return .leading
        }
        else if imageAlign == SHTipImageAlignment_LeftBottom {
            return .bottomLeading
        }
        else if imageAlign == SHTipImageAlignment_CenterTop {
            return .top
        }
        else if imageAlign == SHTipImageAlignment_CenterMiddle {
            return .center
        }
        else if imageAlign == SHTipImageAlignment_CenterBottom {
            return .bottom
        }
        else if imageAlign == SHTipImageAlignment_RightTop {
            return .topTrailing
        }
        else if imageAlign == SHTipImageAlignment_RightMiddle {
            return .trailing
        }
        else if imageAlign == SHTipImageAlignment_RightBottom {
            return .bottomTrailing
        }
        return .topLeading
    }
}
