//
//  FirebaseManager.swift
//  LBTASwiftUIFirebaseChat
//
//  Created by Brian Voong on 11/15/21.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseManager: NSObject {
    
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    var currentUser: ChatUser?
    
    static let shared = FirebaseManager()
    
    override init() {
        
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
    
    func uploadMedia(image: UIImage ,completion: @escaping (_ url: String?) -> Void) {
        
        guard let uploadData = image.jpegData(compressionQuality: 0.5),let currentUser = auth.currentUser else { return }
        
        // Create a root reference
        let storageRef = self.storage.reference()
        
        
        let CurrentTime = CACurrentMediaTime()
        
        let currentTimeString = String(format: "%f", CurrentTime)
        
        let spaceRef = storageRef.child("Users/" + currentUser.uid + "_" + currentTimeString + ".jpg")
        
        
        spaceRef.putData(uploadData, metadata: nil) { (metadata, error) in
            
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                print("\(String(describing: error))")
                completion(nil)
                return
            }
            
            // Metadata contains file metadata such as size, content-type.
            _ = metadata.size
            // You can also access to download URL after upload.
            spaceRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
                
                completion(downloadURL.absoluteString)
                // your uploaded photo url.
                
                //update your Db here
            }
        }
    }
    
    // MARK: Video code
    func uploadVideoToFirebase(_ videoURL: URL,completion: @escaping (_ url: String?) -> Void) {
            let storage = Storage.storage()
            let storageRef = storage.reference()
            
            let videoFileName = "\(UUID().uuidString).mov" // Generate a unique filename for the video
            
            let videoRef = storageRef.child(videoFileName)
            
            let metadata = StorageMetadata()
            metadata.contentType = "video/quicktime" // Update the content type based on your video type
            
            videoRef.putFile(from: videoURL, metadata: metadata) { (metadata, error) in
                if let error = error {
                    // Handle the error
                    print("Error uploading video: \(error.localizedDescription)")
                    return
                }
                
                // Video uploaded successfully
                // You can now store the video download URL or perform any other necessary operations
                
                videoRef.downloadURL { (url, error) in
                    if let downloadURL = url {
                        // Store the downloadURL or perform further operations
                        print("Video download URL: \(downloadURL)")
                    } else {
                        // Handle any error in retrieving the download URL
                        print("Error retrieving video download URL: \(error?.localizedDescription ?? "")")
                    }
                }
            }
        }
    
}
