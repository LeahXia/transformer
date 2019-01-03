//
//  ImageService.swift
//  Transformer
//
//  Created by Leah Xia on 2019-01-02.
//  Copyright © 2018 Leah Xia. All rights reserved.
//

import UIKit

enum DownloadImageType {
    case property, user, contact, chat, contactRequest, messageSharedContact, message
}

// Handle downloading images
final class ImageService: NSObject {
    
    // MARK: - Image Cache
    static let teamImagesCache = NSCache<AnyObject, AnyObject>()

    func checkCacheOrDownloadImage(from url: String, completion: @escaping ImageCompletionHandler) {
        // 1. If there is a cached image, return cached image
        let imagesCache = ImageService.teamImagesCache
        if let cachedImage = imagesCache.object(forKey: url as AnyObject) as? UIImage {
            completion(nil, cachedImage)
            return
        }
        
        // 2. If no image is cached with this url, download from server
        downloadImage(from: url) { (errorMessage, downloadedImage) in
            completion(errorMessage, downloadedImage)
        }
        
    }
  
    // MARK: - 2.Background download
    func downloadImage(from urlStr: String, completion: @escaping ImageCompletionHandler) {

        guard let url = URL(string: urlStr) else {
            completion("Invalid image url", nil)
            return
        }
        
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else {
                completion("No data or has error: \(error?.localizedDescription ?? "")", nil)
                return
            }
            
            let imagesCache = ImageService.teamImagesCache
            guard let image = UIImage(data: data) else {return}

            DispatchQueue.main.async {
                imagesCache.setObject(image, forKey: urlStr as AnyObject)
                completion(nil, image)
            }
           
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
   
}
