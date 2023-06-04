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

class ViewModel: ObservableObject {
    
    @Published var list = [Users]()
    @Published var designers = [Users]()
    @State var users : Users
    private var db = Firestore.firestore()

    init(){
        let user = Users(id: (Auth.auth().currentUser?.uid.description) ?? "")
        self._users = .init(initialValue: user)
        
    }
    //----------------------------------
    
    func updateData(UsersUpdate: Users) {
        
        // Get a reference to the database
        let db = Firestore.firestore()

        // Set the data to update
        db.collection("Users").document(users.id).setData([
            "name":UsersUpdate.name ?? users.name,
                                                     "phoneNumber":UsersUpdate.phoneNumber ?? users.phoneNumber,
                                                     "desinger":UsersUpdate.desinger ?? users.desinger,
                                                     "brief":UsersUpdate.brief ?? users.brief,
                                                     "field":UsersUpdate.field ?? users.field,
                                                     "styles":UsersUpdate.styles ?? users.styles], merge: true) { error in
            
            // Check for errors
            if error == nil {
                // Get the new data
                self.getData()
            }
        }
    }
    
    //----------------------------------
    
    func deleteData(UsersDelete: Users) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Specify the document to delete
        db.collection("Users").document(users.id).delete { error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                // Update the UI from the main thread
                DispatchQueue.main.async {
                    
                    // Remove the todo that was just deleted
                    self.list.removeAll { Users in
                        
                        // Check for the todo to remove
                        return Users.id == UsersDelete.id
                    }
                }
                
                
            }
        }
        
    }
    
    //----------------------------------
    
    func addData(id: String,
                 email: String?,
                 name : String?) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Add a document to a collection
        db.collection("Users").document(users.id).setData([ "id": users.id,
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
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Read the documents at a specific path
        db.collection("Users").getDocuments { snapshot, error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                if let snapshot = snapshot {
                    
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        
                        // Get all the documents and create Todos
                        self.list = snapshot.documents.map { d in
                            
                            // Create a Todo item for each document returned
                            return Users(id:d["id"] as? String ?? "",
//                                         userId:d["userId"] as? String ?? "",
                                         name: d["name"] as? String ?? "",
                                         email: d["email"] as? String ?? "",
                                         phoneNumber: d["phoneNumber"] as? String ?? "",
                                         favorite: d["favorite"] as? [String] ?? [""],
                                         desinger: d["desinger"] as? Bool ?? false,
                                         brief: d["brief"] as? String ?? "",
                                         field: d["field"] as? String ?? "",
                                         styles: d["styles"] as? String ?? "",
                                         rate: d["rate"] as? String ?? "")
                        }
                        print("GetData")
                    }
                    
                    
                }
            }
            else {
                // Handle the error
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
            print("\(String(describing: Auth.auth().currentUser?.uid))")
            print("No user is signed in.")
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
        }
        
    }
    
    //----------------------------------

    func addFavoriteArray(otherUserID : String) {
        let db = Firestore.firestore()
        let washingtonRef = db.collection("Users").document(users.id)

        // Atomically add a new region to the "regions" array field.
        washingtonRef.updateData([
            "favorite": FieldValue.arrayUnion([otherUserID])
        ])

      }
    
    //----------------------------------

    func removeFavoriteArray(otherUserID : String) {
        let washingtonRef = db.collection("Users").document(users.id)

        // Atomically remove a region from the "regions" array field.
        washingtonRef.updateData([
            "favorite": FieldValue.arrayRemove([otherUserID])
        ])
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
    
    
    func fetchData() {
        db.collection("Users").getDocuments { doucments, error in

            if let error = error {
                print("error!:\(error.localizedDescription)")
            } else {
                guard let documents = doucments?.documents else {
                    print("No documents")
                    return
                }
                for document in documents {
                
                    let id =  document.data()["id"] as? String
//                    let userId =  document.data()["userId"] as? UUID
                    let name = document.data()["name"] as? String
                    let email = document.data()["email"] as? String
                    let phoneNumber = document.data()["name"] as? String
                    let favorite = document.data()["phoneNumber"] as? String
                    let desinger = document.data()["desinger"] as? Bool
                    let brief = document.data()["brief"] as? String
                    let field = document.data()["field"] as? String
                    let styles = document.data()["styles"] as? String
                    let rate = document.data()["rate"] as? String

                    
                    let user = Users(id: id ?? "", name: name ?? "",email: email ?? "" ,phoneNumber: phoneNumber ?? "",desinger: desinger ?? false , brief: brief ?? "",field: field ?? "" ,styles: styles ?? "", rate: rate ?? "" )
                    self.designers.append(user)
                    print("SSSS:\(self.designers.count)")
                    print("MMM:\(self.designers[0].name)")
                    print("Hello")

                
                }
                
            }
            
        }
}
}
