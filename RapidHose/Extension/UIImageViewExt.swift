//
//  UIImageViewExt.swift
//  RapidHose
//
//  Created by Kirti Ahlawat on 10/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import Foundation
import UIKit



let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView{
    func loadImageUsingCacheWithUrlString(urlString: String, defaultString : String? = nil){
        if urlString != Constants.empty{
            //Check Cache for image first
            
            if defaultString == nil{
                self.image = nil
            }else{
                self.image = UIImage(named: defaultString!)
            }
            
            if let cachedImage = imageCache.object(forKey: (urlString as AnyObject)) as? UIImage{
                self.image = cachedImage
                return
            }
            //otherwise fire off a new download
            if let url = NSURL(string: urlString){
                print("URL: \(url)")
                URLSession.shared.dataTask(with: url as URL) { (data, URLRequest, error) in
                    if let err = error{
                        print("error: \(err)")
                        return
                    }
                    DispatchQueue.main.async {
                        if let downloadedImage = UIImage(data: data!){
                            imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                            self.image = downloadedImage                    }
                        
                    }
                    }.resume()
            }
        }else{
            
            if defaultString == nil{
                self.image = nil
            }else{
                self.image = UIImage(named: defaultString!)
            }
//             self.image = UIImage(named: "defaultProfileImage")
        }
        
    }
    
    
    func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity =  0.7 //1
//            containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        containerView.layer.shadowRadius =  12 //5
        containerView.layer.cornerRadius = cornerRadious
        
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
    }
}


extension UIImage {

    func save(at directory: FileManager.SearchPathDirectory,
              pathAndImageName: String,
              createSubdirectoriesIfNeed: Bool = true,
              compressionQuality: CGFloat = 1.0)  -> URL? {
        do {
        let documentsDirectory = try FileManager.default.url(for: directory, in: .userDomainMask,
                                                             appropriateFor: nil,
                                                             create: false)
        return save(at: documentsDirectory.appendingPathComponent(pathAndImageName),
                    createSubdirectoriesIfNeed: createSubdirectoriesIfNeed,
                    compressionQuality: compressionQuality)
        } catch {
            print("-- Error: \(error)")
            return nil
        }
    }

    func save(at url: URL,
              createSubdirectoriesIfNeed: Bool = true,
              compressionQuality: CGFloat = 1.0)  -> URL? {
        do {
            if createSubdirectoriesIfNeed {
                try FileManager.default.createDirectory(at: url.deletingLastPathComponent(),
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
            }
            guard let data = jpegData(compressionQuality: compressionQuality) else { return nil }
            try data.write(to: url)
            return url
        } catch {
            print("-- Error: \(error)")
            return nil
        }
    }
}

// load from path

extension UIImage {
    convenience init?(fileURLWithPath url: URL, scale: CGFloat = 1.0) {
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data, scale: scale)
        } catch {
            print("-- Error: \(error)")
            return nil
        }
    }
}
