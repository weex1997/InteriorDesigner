//
//  ChatUser.swift
//  LBTASwiftUIFirebaseChat
//
//  Created by Brian Voong on 11/16/21.
//

import FirebaseFirestoreSwift

struct ChatUser: Codable, Identifiable {
    @DocumentID var id: String?
    let uid: String
//    var id : String
//    var userId = UUID()
    var name: String?
    var email: String
    var phoneNumber: String?
    var gender: String?
    var favorite: [String]?
    var desinger : Bool?
    var brief : String?
    var field : [String]?
    var styles : String?
    var rate : String?
}
