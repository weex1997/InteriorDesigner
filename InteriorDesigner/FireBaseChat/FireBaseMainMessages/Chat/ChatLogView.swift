//
//  ChatLogView.swift
//  LBTASwiftUIFirebaseChat
//
//  Created by Brian Voong on 11/18/21.
//

import SwiftUI
import Firebase
import AVFoundation
import SDWebImageSwiftUI

class ChatLogViewModel: ObservableObject {
    
    @Published var chatText = ""
    @Published var errorMessage = ""
    
    @Published var chatMessages = [ChatMessage]()
    @Published var mediaItem = ""

    var chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        
        fetchMessages()
    }
    
    var firestoreListener: ListenerRegistration?
    
    func fetchMessages() {
        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let toId = chatUser?.id else {
            return
        }
        guard let gender = chatUser?.gender else {
            return
        }
        firestoreListener?.remove()
        chatMessages.removeAll()
        firestoreListener = FirebaseManager.shared.firestore
            .collection(FirebaseConstants.messages)
            .document(fromId)
            .collection(toId)
            .order(by: FirebaseConstants.timestamp)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to listen for messages: \(error)"
                    print(error)
                    return
                }
                
                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        do {
//                            if let cm = try change.document.data(as: ChatMessage.self) {
//                                self.chatMessages.append(cm)
//                                print("Appending chatMessage in ChatLogView: \(Date())")
//                            }
                            let cm = try change.document.data(as: ChatMessage.self)
                            self.chatMessages.append(cm)
                            print("Appending chatMessage in ChatLogView: \(Date())")
                            
                        } catch {
                            print("Failed to decode message: \(error)")
                        }
                    }
                })
                
                DispatchQueue.main.async {
                    self.count += 1
                }
            }
    }
    
    func handleSend() {
        print(chatText)
        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        guard let toId = chatUser?.id else { return }
        guard let gender = chatUser?.gender else { return }
        
        let document = FirebaseManager.shared.firestore.collection(FirebaseConstants.messages)
            .document(fromId)
            .collection(toId)
            .document()
        
        let msg = ChatMessage(id: nil, fromId: fromId, toId: toId, text: chatText, timestamp: Date() , gender: gender, mediaItem: mediaItem)

        try? document.setData(from: msg) { error in
            if let error = error {
                print(error)
                self.errorMessage = "Failed to save message into Firestore: \(error)"
                return
            }
            
            print("Successfully saved current user sending message")
            
            self.persistRecentMessage()
            
            self.chatText = ""
            self.count += 1
        }
        
        let recipientMessageDocument = FirebaseManager.shared.firestore.collection("messages")
            .document(toId)
            .collection(fromId)
            .document()
        
        try? recipientMessageDocument.setData(from: msg) { error in
            if let error = error {
                print(error)
                self.errorMessage = "Failed to save message into Firestore: \(error)"
                return
            }
            
            print("Recipient saved message as well")
        }
    }
    
    private func persistRecentMessage() {
        guard let chatUser = chatUser else { return }
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let toId = self.chatUser?.id else { return }
        guard let gender = self.chatUser?.gender else { return }
        
        let document = FirebaseManager.shared.firestore
            .collection(FirebaseConstants.recentMessages)
            .document(uid)
            .collection(FirebaseConstants.messages)
            .document(toId)
        
//        let data = [
//            FirebaseConstants.timestamp: Timestamp(),
//            FirebaseConstants.text: self.chatText,
//            FirebaseConstants.fromId: uid,
//            FirebaseConstants.toId: toId,
//            FirebaseConstants.profileImageUrl: chatUser.profileImageUrl ?? "",
//            FirebaseConstants.email: chatUser.email ?? ""
        
        let data = [
            FirebaseConstants.timestamp: Timestamp(),
            FirebaseConstants.text: self.chatText,
            FirebaseConstants.fromId: uid,
            FirebaseConstants.toId: toId,
            FirebaseConstants.name: chatUser.name ?? "",
            FirebaseConstants.gender: gender ?? ""
        
        ] as [String : Any]
        
        // you'll need to save another very similar dictionary for the recipient of this message...how?
        
        document.setData(data) { error in
            if let error = error {
                self.errorMessage = "Failed to save recent message: \(error)"
                print("Failed to save recent message: \(error)")
                return
            }
        }
        
        guard let currentUser = FirebaseManager.shared.currentUser else { return }
//        let recipientRecentMessageDictionary = [
//            FirebaseConstants.timestamp: Timestamp(),
//            FirebaseConstants.text: self.chatText,
//            FirebaseConstants.fromId: uid,
//            FirebaseConstants.toId: toId,
//            FirebaseConstants.profileImageUrl: currentUser.profileImageUrl ?? "",
//            FirebaseConstants.email: currentUser.email ?? ""
        
        let recipientRecentMessageDictionary = [
            FirebaseConstants.timestamp: Timestamp(),
            FirebaseConstants.text: self.chatText,
            FirebaseConstants.fromId: uid,
            FirebaseConstants.toId: toId,
            FirebaseConstants.name: currentUser.name ?? "",
            FirebaseConstants.gender: gender ?? ""
        
        ] as [String : Any]
        
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.recentMessages)
            .document(toId)
            .collection(FirebaseConstants.messages)
            .document(currentUser.id!)
            .setData(recipientRecentMessageDictionary) { error in
                if let error = error {
                    print("Failed to save recipient recent message: \(error)")
                    return
                }
            }
    }
    
    @Published var count = 0
}

struct ChatLogView: View {
    
//    let chatUser: ChatUser?
//
//    init(chatUser: ChatUser?) {
//        self.chatUser = chatUser
//        self.vm = .init(chatUser: chatUser)
//    }
    
    @ObservedObject var vm: ChatLogViewModel
    @State private var selectedImages: [UIImage] = []
    @State private var selectedVideos: [AVPlayer] = []
    @State private var isMediaPickerPresented = false
    @State private var mediaUrl : String?
    
    
    var body: some View {
        ZStack {
            messagesView
            Text(vm.errorMessage)
        }
        .navigationBarHidden(true)
        .navigationTitle(vm.chatUser?.name ?? "")
        .onDisappear {
            vm.firestoreListener?.remove()
        }
//        .navigationTitle(vm.chatUser?.name ?? "")
//        .navigationBarTitleDisplayMode(.inline)
//        .onDisappear {
//            vm.firestoreListener?.remove()
//        }
    }
    
    static let emptyScrollToString = "Empty"
    
    private var messagesView: some View {
        VStack {
            if #available(iOS 15.0, *) {
                ScrollView {
                    ScrollViewReader { scrollViewProxy in
                        VStack {
                            ForEach(vm.chatMessages) { message in
                                MessageView(message: message)
                            }
                            
                            HStack{ Spacer() }
                            .id(Self.emptyScrollToString)
                        }
                        .onReceive(vm.$count) { _ in
                            withAnimation(.easeOut(duration: 0.5)) {
                                scrollViewProxy.scrollTo(Self.emptyScrollToString, anchor: .bottom)
                            }
                        }
                    }
                }
                .background(Color(.init(white: 0.95, alpha: 1)))
                .safeAreaInset(edge: .bottom) {
                    chatBottomBar
                        .background(Color(.systemBackground).ignoresSafeArea())
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    private var chatBottomBar: some View {
        HStack(spacing: 16) {
            Image(systemName: "plus.viewfinder")
                .resizable()
                .frame(width: 22, height: 22)
                .foregroundColor(.purple)
                .padding()
                .onTapGesture {
                    isMediaPickerPresented = true
                }
            ZStack {
                DescriptionPlaceholder()
                TextEditor(text: $vm.chatText)
                    .opacity(vm.chatText.isEmpty ? 0.5 : 1)
                    .disableAutocorrection(true)
            }
            .frame(height: 40)
            
            Button {
                vm.handleSend()
            } label: {
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundColor(Color.purple)
                    .padding()
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .cornerRadius(4)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .sheet(isPresented: $isMediaPickerPresented) {
            MediaPicker(selectedImages: $selectedImages, selectedVideos: $selectedVideos, mediaUrl: $mediaUrl)
        }.onChange(of: selectedImages) {newValue in
            FirebaseManager.shared.uploadMedia(image: newValue[0]) { url in
                guard let url = url else {return}
                vm.mediaItem = url
                vm.handleSend()
            }
        }
    }
}


struct MessageView: View {
    
    let message: ChatMessage
    
    var body: some View {
        VStack(alignment: message.fromId == FirebaseManager.shared.auth.currentUser?.uid ? .leading : .trailing) {
            if message.fromId == FirebaseManager.shared.auth.currentUser?.uid {
                HStack {
                    Spacer()
                    
                    VStack {
                        if let image = message.mediaItem  {
                            
                            let isEmptyImage = message.mediaItem?.isEmpty
                            
                            if !isEmptyImage!{
                                WebImage(url: URL(string: image ?? ""))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipped()
                                    .cornerRadius(0)
                                    .overlay(RoundedRectangle(cornerRadius: 0)
                                        .stroke(Color(.label), lineWidth: 0.5)
                                    )
                                Spacer()
                            }
                        }
                        HStack {
                            Text(message.text)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .foregroundColor(.white)
                        }.frame( alignment: .trailing)

                        //                        .padding()
                        //                        .background(Color.blue)
                        //                        .cornerRadius(8)
                    }
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(8)
                }
            } else {
                HStack {
                    Spacer()
                    
                    VStack {
                        if let image = message.mediaItem  {
                            
                            let isEmptyImage = message.mediaItem?.isEmpty
                            
                            if !isEmptyImage!{
                                WebImage(url: URL(string: image ?? ""))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipped()
                                    .cornerRadius(0)
                                    .overlay(RoundedRectangle(cornerRadius: 0)
                                        .stroke(Color(.label), lineWidth: 0.5)
                                    )
                                Spacer()
                            }
                        }
                        
                        
                        HStack {
                            Text(message.text)
                                .foregroundColor(Color.purple)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }.frame( alignment: .leading)
                        //                    .padding()
                        //                    .background(Color.white)
                        //                    .cornerRadius(8)
                        //                    Spacer()
                    }.padding()
                        .background(Color.purple.opacity(0.2))
                        .cornerRadius(8)
                    Spacer()
                }
            }
            //        .padding(.horizontal)
            //        .padding(.top, 8)
        }.padding(.horizontal)
            .padding(.top, 8)
    }
}

private struct DescriptionPlaceholder: View {
    var body: some View {
        HStack {
            Text("Enter your message here")
                .foregroundColor(Color(.gray))
                .font(.system(size: 17))
                .padding(.leading, 5)
                .padding(.top, -4)
            Spacer()
        }
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
    }
}
