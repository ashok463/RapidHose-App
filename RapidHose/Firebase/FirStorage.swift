//
//  FirebaseStorage.swift
//  DailySpend
//
//  Created by Kirti Ahlawat on 04/11/19.
//  Copyright © 2019 outect. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage


class FirStorage{
    
    private init() {}
    
    static let shared = FirStorage()
    
    let storageRef = Storage.storage().reference()

    var taskImageRef : StorageReference{
        get{
            return storageRef.child("TaskImages/")
        }
    }
    
    var categoryIconRef : StorageReference{
        get{
            return storageRef.child("CategoryIcon/PngIcon/")
        }
    }
    
    
    func uploadTaskImage(cell : UICollectionViewCell, taskId : String, imageIndex : Int, withData data : Data, completion: @escaping (URL) -> Void){
//        ActivityIndicator.shared().show("Image Uploading")
        ActivityIndicator.shared().show(cell.contentView, loadingText: "Uploading")
        let uploadTask = taskImageRef.child(taskId).child("\(imageIndex).jpg").putData(data, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let _ = metadata.size
            metadata.contentType = "image/jpeg"
            self.taskImageRef.child(taskId).child("\(imageIndex).jpg").updateMetadata(metadata, completion: nil)
          // You can also access to download URL after upload.
            self.taskImageRef.child(taskId).child("\(imageIndex).jpg").downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
              return
            }
                completion(downloadURL)
                print("Final Image Url : \(downloadURL)")
          }
        }
        
        print("======Image Uploading Start=====")
        uploadTask.observe(.progress) { (snapshot) in
            print("Data : \(snapshot)")
            let percentComplete = 100.0 * Double(snapshot.progress!.fractionCompleted)
            ActivityIndicator.shared().updateProgressText(progreess: "\(NSString(format: "%.0f", percentComplete))%")
        }
        uploadTask.observe(.success) { (snapshot) in
            print("======Image Uploading Successfully Completed")
            ActivityIndicator.shared().hide()
        }
        
        uploadTask.observe(.failure) { (snapshot) in
            if let error = snapshot.error as NSError? {
              switch (StorageErrorCode(rawValue: error.code)!) {
              case .objectNotFound:
                // File doesn't exist
                break
              case .unauthorized:
                // User doesn't have permission to access file
                break
              case .cancelled:
                // User canceled the upload
                break

              /* ... */

              case .unknown:
                // Unknown error occurred, inspect the server response
                break
              default:
                // A separate error occurred. This is a good place to retry the upload.
                break
              }
            }
        }
    }
    
    
    func deleteProfileImage(){
        taskImageRef.delete { (error) in
            if let err = error{
                print("Erro while deleting file :\(err.localizedDescription)")
                // Error While deleting file.
            }else{
                // File Successfully Deleted
            }
        }
    }
    
    func downloadAllCategoryIcons(completion : @escaping ([StorageReference]) -> Void){
        categoryIconRef.listAll { (result, error) in
            completion(result.items)
        }
    }
    
    
    
}
