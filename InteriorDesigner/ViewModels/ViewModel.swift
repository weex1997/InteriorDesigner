//
//  ViewModels.swift
//  InteriorDesigner
//
//  Created by Wedad Almehmadi on 15/05/2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import CryptoKit
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift

class ViewModel: ObservableObject {
    @State var userIDE = Auth.auth().currentUser?.uid ?? "123"
    @Published var user = User(id: (Auth.auth().currentUser?.uid.description) ?? "")
    @Published var designers = [Users]()
    private var db = Firestore.firestore()
    let storage = Storage.storage()
    @State var SR = Storage.storage().reference()
   
    //----------------------------------
    
    func updateData() {
        let db = Firestore.firestore()

        let washingtonRef = db.collection("Users").document(userIDE)

        // Set the "capital" field of the city 'DC'
        washingtonRef.updateData([
            
            "name": self.user.name ?? "",
                            "phoneNumber": self.user.phoneNumber ?? "",
                            "gender": self.user.gender ?? "",
                            "desinger": self.user.desinger ?? false,
                            "brief": self.user.brief ?? "",
            //                            "field": self.user.field ?? [],
            //                            "images": self.user.field as Any,
                            "styles": self.user.styles ?? "",
                            "rate": self.user.rate ?? 0
            
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
            }
    
    //----------------------------------
    
    func deleteData() {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Specify the document to delete
        db.collection("Users").document(user.id).delete { error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                // Update the UI from the main thread
                DispatchQueue.main.async {
                    
                    // Remove the todo that was just deleted
//                    self.Users.removeAll { Users in
//
//                        // Check for the todo to remove
//                        return Users.id == UsersDelete.id
//                    }
                    
                }
                
//                "name": self.user.name ?? "",
//                "phoneNumber": self.user.phoneNumber ?? "",
//                "gender": self.user.gender ?? "",
//                "desinger": self.user.desinger ?? false,
//                "brief": self.user.brief ?? "",
////                            "field": self.user.field ?? [],
////                            "images": self.user.field as Any,
//                "styles": self.user.styles ?? "",
//                "rate": self.user.rate ?? 0], merge: true)
            }
        }
        signOut()
    }
    
    //----------------------------------
    
    func addData(id: String,
                 email: String?,
                 name : String?) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Add a document to a collection
        db.collection("Users").document(id).setData([ "id": id,
                                                                  "email": email ?? "",
                                                                  "name":name ?? ""]) { error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                // Call get data to retrieve latest data
                self.getData()
            }
            else {
                // Handle the error
            }
        }
    }
    
    //----------------------------------
    
    func getData() {

        let docRef = db.collection("Users").document(userIDE)

          docRef.getDocument { document, error in
              if let error = error {
                  print("error!:\(error.localizedDescription)")
              }
            else {
              if let document = document {
                  let id =  document.documentID
                  let data = document.data()
                  let name = data?["name"] as? String ?? ""
                  let uid = data?["id"] as? String ?? ""
                  let email = data?["email"] as? String ?? ""
                  let phoneNumber = data?["phoneNumber"] as? String ?? ""
                  let gender = data?["gender"] as? String ?? ""
                  let favorite = data?["favorite"] as? [String] ?? []
                  let desinger = data?["desinger"] as? Bool ?? false
                  let brief = data?["brief"] as? String ?? ""
                  let field = data?["field"] as? [String] ?? []
                  let images = data?["images"] as? [String] ?? []
                  let styles = data?["styles"] as? String ?? ""
                  let rate = data?["rate"] as? String ?? ""
                  
                  
//                  UserDefaults.standard.set(name, forKey: "name")
//                  UserDefaults.standard.set(email, forKey: "email")
//                  UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
//                  UserDefaults.standard.set(favorite, forKey: "favorite")
//                  UserDefaults.standard.set(desinger, forKey: "desinger")
//                  UserDefaults.standard.set(brief, forKey: "brief")
//                  UserDefaults.standard.set(field, forKey: "field")
//                  UserDefaults.standard.set(rate, forKey: "rate")
                 
                  

                  self.user = User(id: id, name: name , uid: uid, email: email ,phoneNumber: phoneNumber ,desinger: desinger , brief: brief ,field: field ,styles: styles , rate: rate )

//                  self.user = User(id: id, name: name ,email: email ,phoneNumber: phoneNumber ,images: images, desinger: desinger , brief: brief ,field: field ,styles: styles , rate: rate )

                  
                  print(self.user.name ?? "" )
              }
            }
          }
    }
    
    //----------------------------------
    
    func signOut() {
        do{
            try Auth.auth().signOut();
        } catch let logoutError {
            print(logoutError)
        }
        
        let user1 = Auth.auth().currentUser;
        
        if ((user1) != nil) {
            // User is signed in.
            print("User is signed in.")
        } else {
            // No user is signed in.
            print("No user is signed in.")
//            let domain = Bundle.main.bundleIdentifier!
//            UserDefaults.standard.removePersistentDomain(forName: domain)
//            UserDefaults.standard.synchronize()
//            print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
        }
        
    }
    
    //----------------------------------

    func addFavoriteArray(otherUserID : String) {
        let db = Firestore.firestore()
        let washingtonRef = db.collection("Users").document(user.id)

        // Atomically add a new region to the "regions" array field.
        washingtonRef.updateData([
            "favorite": FieldValue.arrayUnion([otherUserID])
        ])
        self.getData()

      }
    
    func addFieldArray(Feilds : String) {
        let db = Firestore.firestore()
        let washingtonRef = db.collection("Users").document(user.id)

        // Atomically add a new region to the "regions" array field.
        washingtonRef.updateData([
            "field": FieldValue.arrayUnion([Feilds])
        ])
        self.getData()

      }
    
    func addImageArray(imageURL : String) {
        let db = Firestore.firestore()
        let washingtonRef = db.collection("Users").document(user.id)

        // Atomically add a new region to the "regions" array field.
        washingtonRef.updateData([
            "images": FieldValue.arrayUnion([imageURL])
        ])
        self.getData()

      }
    
    //----------------------------------

    func removeFavoriteArray(otherUserID : String) {
        let washingtonRef = db.collection("Users").document(user.id)

        // Atomically remove a region from the "regions" array field.
        washingtonRef.updateData([
            "favorite": FieldValue.arrayRemove([otherUserID])
        ])
        self.getData()

      }
    
    
    func removeFieldArray(Feilds : String) {
        let washingtonRef = db.collection("Users").document(user.id)

        // Atomically remove a region from the "regions" array field.
        washingtonRef.updateData([
            "field": FieldValue.arrayRemove([Feilds])
        ])
        self.getData()

      }
    
    func removeImageArray(ImageURL : String) {
        let washingtonRef = db.collection("Users").document(user.id)

        // Atomically remove a region from the "regions" array field.
        washingtonRef.updateData([
            "images": FieldValue.arrayRemove([ImageURL])
        ])
        self.getData()

      }
//    func Rate(otherUserID : String, rateingValue : Int32) {
//
//        //        var count = 0
//        //        var rating = 0
//        //
//        //        for (key, value) in users.rate! {
//        //            count += 1
//        //            rating += value
//        //        }
//        //
//        //        rating /= count
//        //
//        //        let user = User(name: "john doe", rating: rating)
//
//        //        let db = Firestore.firestore()
//        //        let washingtonRef = db.collection("Users").document(otherUserID)
//        //
//        //        // Atomically add a new region to the "regions" array field.
//        //        washingtonRef.updateData([
//        //            "rate": FieldValue.arrayUnion([otherUserID,rateingValue])
//        //        ])
//
//
//
//        let db = Firestore.firestore()
//        let washingtonRef = db.collection("Users").document(users.id)
////
////        let ref = self.washingtonRef.child("uid_0").child("playlist")
////        let songArray = ["Us and Them", "Get Back", "Children of the Sun"]
////        ref.setValue(songArray)
//
//        // Atomically add a new region to the "regions" array field.
//        washingtonRef.updateData([
//            "favorite": FieldValue.arrayUnion([otherUserID])
//        ])
//
//
//    }
    
//    func uploadSavedData() {
//        guard let data = myData else { return } // Checks whether there is actual data to upload.
//
//        let storageRef = Storage.storage().reference()
//        let fileRef = storageRef.child("userUID/files/documentName.png")
//
//        let uploadTask = fileRef.putData(data, metadata: nil) { (metadata, error) in
//            guard let metadata = metadata else { return } // Cancels task if there is any error
//            
//            fileRef.downloadURL { (url, error) in {
//                guard let downloadURL = url else { return }
//                print(downloadURL) // Prints the URL to the newly uploaded data.
//            }
//        }
//    }
    
    func upload(image: UIImage) {
        // Create a storage reference
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let filename = UUID().uuidString + ".jpg"
        let storageRef = storage.reference().child("\(uid)/\(filename)")
        self.SR = storageRef
        // Resize the image to 200px with a custom extension
        //        let resizedImage = image.aspectFittedToHeight(200)
        
        // Convert the image into JPEG and compress the quality to reduce its size
        let data = image.jpegData(compressionQuality: 0.2)
        
        // Change the content type to jpg. If you don't, it'll be saved as application/octet-stream type
        let metadata = StorageMetadata()
//        metadata.contentType = filename + ".jpg"
        

        // Upload the image
        if let data = data {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file: ", error)
                }
                
                if let metadata = metadata {
                    print("Metadata: ", metadata)
                    // Fetch the download URL
                    storageRef.downloadURL { url, error in
                        if error != nil {
                          print("fkuuuuuuuuuu")
                      } else {
                          //Do something with url
                          print(url?.absoluteString ?? "")
                          self.addImageArray(imageURL: url?.absoluteString ?? "")
                      }
                    }

                }
            }
          
        }
    }
       
    func listAllFiles() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
            // Create a reference
            let storageRef = storage.reference().child(uid)

            // List all items in the images folder
            storageRef.listAll { (result, error) in
              if let error = error {
                print("Error while listing all files: ", error)
              }

                for item in result!.items {
                print("Item in images folder: ", item)
//                    user.image.append(item)
                    item.downloadURL(completion: { (url, error) in
                        if error != nil {
                            print("Failed to download url:", error!)
                            return
                        } else {
                            //Do something with url
                            print(url?.absoluteString ?? "")
                            self.user.images.append(url?.absoluteString ?? "")
                            print("hioooooooooooooooooooooooooooooo\(self.user.images)" )
                            self.addImageArray(imageURL: url?.absoluteString ?? "")
                        }

                    })
              }
                
             
            }
        }
    
    func deleteItem(item: StorageReference) {
           item.delete { error in
               if let error = error {
                   print("Error deleting item", error)
               }
           }
       }
    func fetchData() { // Read the documents at a specific path
        db.collection("Users").getDocuments { snapshot, error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                if let snapshot = snapshot {
                    
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        
                        // Get all the documents and create Todos
                        self.designers = snapshot.documents.map { d in
                            
                            // Create a Todo item for each document returned
                            return Users(id: d.documentID,
                                        name: d["name"] as? String ?? "",
                                         email: d["email"] as? String ?? "",
                                         phoneNumber: d["phoneNumber"] as? String ?? "",
//                                         gender: d["gender"] as? String ?? "",
                                         favorite: d["favorite"] as? [String] ?? [],
                                         desinger: d["desinger"] as? Bool ?? false,
                                         brief: d["brief"] as? String ?? "",
                                         field: d["field"] as? [String] ?? [],
//                                         images: d["images"] as? [String] ?? []
                                         styles: d["styles"] as? String ?? "",
                                         rate: d["rate"] as? String ?? "",
                                         images: d["images"] as? [String] ?? []
                            
                            
                            )
                        }
                    }
                    
                    
                }
            }
            else {
                // Handle the error
            }
        }
    }
}
