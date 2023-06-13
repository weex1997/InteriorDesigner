//
//  ChatUser.swift
//  LBTASwiftUIFirebaseChat
//
//  Created by Brian Voong on 11/16/21.
//

import FirebaseFirestoreSwift

struct ChatUser: Codable, Identifiable {
    @DocumentID var id: String?
    let uid, email, profileImageUrl: String?
    var brief : String?
    var designer : Bool?
    var field : [String]?
    var gender : String?
    var images : [String]?
    var name : String?
    var phoneNumber : String?
    var rate : String?
    var styles : String?
    
}
