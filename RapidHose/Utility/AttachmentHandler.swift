//
//  AttachmentHandler.swift
//  PhotoVideoFIleAccess
//
//  Created by Shashank Panwar on 21/02/19.
//  Copyright © 2019 Shashank Panwar. All rights reserved.
//

/*
 Add these two lines to access the permissions for camera and photo library respectively.
 Privacy - Camera Usage Description  “$(PRODUCT_NAME) would like to access your camera."
 Privacy - Photo Library Usage Description "$(PRODUCT_NAME) would like to access your photo.”
 */

import Foundation
import UIKit
import AVFoundation
import Photos
import MobileCoreServices

enum AttachmentType : String{
    case camera, video, photoLibrary, document
}

class AttachmentHandler : NSObject{
    
    
    static let shared = AttachmentHandler()
    fileprivate var currentVC : UIViewController?
    
    private override init(){}
    
    var imagePickerBlock : ((UIImage) -> Void)?
    var videoPickerBlock : ((NSURL) -> Void)?
    var documentPickerBlock : ((NSURL) -> Void)?
    var removeImageBlock : (() -> Void)?
    
    
    func showAttachmentActionSheet(vc : UIViewController, libraryModes : [AttachmentType]){
        currentVC = vc
        let actionSheet = UIAlertController(title: "Select file type for access", message: "", preferredStyle: .actionSheet)
        if libraryModes.contains(.camera){
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
                //Camera btn selected
                print("Camera btn pressed")
                self.authorizationStatus(attachmentType: .camera, vc: vc)
            }))
        }
        if libraryModes.contains(.photoLibrary){
            actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
                //Photo Library btn selected
                print("Photo Library btn pressed")
                self.authorizationStatus(attachmentType: .photoLibrary, vc: vc)
            }))
        }
        if libraryModes.contains(.video){
            actionSheet.addAction(UIAlertAction(title: "Video", style: .default, handler: { (action) in
                //Video btn selected
                print("Video btn pressed")
                self.authorizationStatus(attachmentType: .video, vc: vc)
            }))
        }
        if libraryModes.contains(.document){
            actionSheet.addAction(UIAlertAction(title: "File", style: .default, handler: { (action) in
                //File btn selected
                print("File btn pressed")
                self.documentPicker()
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Remove Picture", style: .destructive, handler: { (action) in
            if let removeImageBlock = self.removeImageBlock{
                removeImageBlock()
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
    private func authorizationStatus(attachmentType : AttachmentType, vc : UIViewController){
        if attachmentType == .camera{
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            switch status{
            case .authorized:
                //User is authorized to access camera
                print("User is authorized to access camera")
                self.openCamera()
            case .notDetermined:
                // The user has not yet been asked for camera access
                print("The user has not yet been asked for camera access")
                AVCaptureDevice.requestAccess(for: .video) { (granted) in
                    if granted{
                        self.openCamera()
                    }
                }
            case .denied, .restricted:
                //denied : The user has previously denied access.
                //restricted : the user can't grant access to restriction.
                print("//denied : The user has previously denied access.\n//restricted : the user can't grant access to restriction.")
            @unknown default:
                print("Unknown Cases")
            }
        }else if attachmentType == .photoLibrary || attachmentType == .video{
            let status = PHPhotoLibrary.authorizationStatus()
            switch status{
            case .authorized:
                //User is authorized to access camera
                print("User is authorized to access camera")
                if attachmentType == .photoLibrary{
                    self.photoLibrary()
                }
                if attachmentType == .video{
                    self.videoLibrary()
                }
            case .notDetermined:
                // The user has not yet been asked for camera access
                print("The user has not yet been asked for camera access")
                PHPhotoLibrary.requestAuthorization { (status) in
                    if status == PHAuthorizationStatus.authorized{
                        if attachmentType == .photoLibrary{
                            self.photoLibrary()
                        }
                        if attachmentType == .video{
                            self.videoLibrary()
                        }
                    }
                }
            case .denied, .restricted:
                //denied : The user has previously denied access.
                //restricted : the user can't grant access to restriction.
                print("//denied : The user has previously denied access.\n//restricted : the user can't grant access to restriction.")
            @unknown default:
                print("Unknown Cases")
            }
        }
    }
    
    
    private func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            DispatchQueue.main.async {
                            let myPickerController = UIImagePickerController()
                myPickerController.delegate = self
                myPickerController.sourceType = .camera
                self.currentVC?.present(myPickerController, animated: true, completion: nil)
            }
        }
    }
    
    private func photoLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            DispatchQueue.main.async {
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = self
                myPickerController.sourceType = .photoLibrary
                self.currentVC?.present(myPickerController, animated: true, completion: nil)
            }
        }
    }
    
    private func videoLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            DispatchQueue.main.async {
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = self
                myPickerController.sourceType = .photoLibrary
                myPickerController.mediaTypes = [kUTTypeMovie as String]
                self.currentVC?.present(myPickerController, animated: true, completion: nil)
            }
        }
    }
    
    private func documentPicker(){
        let types = [kUTTypePDF, kUTTypeText, kUTTypeRTF, kUTTypeSpreadsheet]
        let importMenu = UIDocumentPickerViewController(documentTypes: types as [String], in: .import)
        
        if #available(iOS 11.0, *) {
            importMenu.allowsMultipleSelection = true
        }
        
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        
        currentVC?.present(importMenu, animated: true)
    }
}


extension AttachmentHandler : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if let currentVC = currentVC{
            currentVC.dismiss(animated: true, completion: nil)
            self.currentVC = nil
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            if let imageBlock = imagePickerBlock{
                imageBlock(image)
            }
        }
        
        if let videoUrl = info[.mediaURL] as? NSURL{
            print("videoURL : \(videoUrl)")
            let data = NSData(contentsOf: videoUrl as URL)!
            print("Data Length : \(data.length)")
            let fileSizeInMB = Double(Double(data.length) / 1048576.0)
            
            print("File size before compression : \(String(format: "%0.1f", fileSizeInMB)) MB.")
            if let videoBlock = self.videoPickerBlock{
                videoBlock(videoUrl as NSURL)
            }
            /*
             Data is already compressed by 
             */
           //compressWithSessionStatusFunc(videoUrl)
        }
        
        if let currentVC = currentVC{
            currentVC.dismiss(animated: true, completion: nil)
            self.currentVC = nil
        }
    }
}

extension AttachmentHandler : UIDocumentPickerDelegate{
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let documentUrl = urls.first else {return}
        let displayDocument = UIDocumentInteractionController(url: documentUrl)
        displayDocument.delegate = self
        displayDocument.presentPreview(animated: true)
        if let documentBlock = documentPickerBlock{
          documentBlock(documentUrl as NSURL)
        }
    }
}

extension AttachmentHandler : UIDocumentInteractionControllerDelegate{
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return currentVC!
    }
}

extension AttachmentHandler{
    //MARK: Video Compressing technique
   fileprivate func compressWithSessionStatusFunc(_ videoUrl: NSURL) {
        let compressedURL = NSURL.fileURL(withPath: NSTemporaryDirectory() + NSUUID().uuidString + ".MOV")
        print("Compressed URL :\(compressedURL)")
        compressVideo(inputURL: videoUrl as URL, outputURL: compressedURL) { (exportSession) in
            guard let session = exportSession else {
                return
            }
            
            switch session.status {
            case .unknown:
                break
            case .waiting:
                break
            case .exporting:
                break
            case .completed:
                guard let compressedData = NSData(contentsOf: compressedURL) else {
                    return
                }
                print("Data Length after compression : \(compressedData.length)")
                let fileSizeInMB = Double(Double(compressedData.length) / 1048576.0)
                print("File size after compression : \(String(format: "%0.1f", fileSizeInMB)) MB.")
                
                DispatchQueue.main.async {
                    if let videoBlock = self.videoPickerBlock{
                        videoBlock(compressedURL as NSURL)
                    }
                }
                
            case .failed:
                break
            case .cancelled:
                break
            @unknown default:
                print("Unknown Issue")
            }
        }
    }
    
    // Now compression is happening with medium quality, we can change when ever it is needed
    fileprivate func compressVideo(inputURL: URL, outputURL: URL, handler:@escaping (_ exportSession: AVAssetExportSession?)-> Void) {
        let urlAsset = AVURLAsset(url: inputURL, options: nil)
        guard let exportSession = AVAssetExportSession(asset: urlAsset, presetName: AVAssetExportPreset1280x720) else {
            handler(nil)
            
            return
        }
        
        exportSession.outputURL = outputURL
        exportSession.outputFileType = AVFileType.mov
        exportSession.shouldOptimizeForNetworkUse = true
        exportSession.exportAsynchronously { () -> Void in
            handler(exportSession)
        }
    }
}
