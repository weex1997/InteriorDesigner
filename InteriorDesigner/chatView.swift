////
////  chatView.swift
////  InteriorDesigner
////
////  Created by Asma Abdulkreem on 12/11/1444 AH.
////
//
//import Foundation
//
//struct ChatMessage: Identifiable {
//    let id = UUID()
//    let sender: String
//    let text: String
//}
//
//import SwiftUI
//
//struct ChatView: View {
//
//    @State private var messages: [ChatMessage] = [
//        ChatMessage(sender: "User1", text: "Hello, how are you?"),
//        ChatMessage(sender: "User2", text: "I'm doing great, thanks! How about you?")
//    ]
//
//    @State private var newMessage = ""
//
//    var body: some View {
//        NavigationView {
//
//            VStack {
//                ScrollViewReader { scrollView in
//                    ScrollView(.vertical, showsIndicators: false) {
//                        VStack(spacing: 8) {
//                            ForEach(messages) { message in
//                                ChatBubble(message: message)
//                            }
//                        }
//                        .padding()
//                        .onAppear {
//                            scrollView.scrollTo(messages.last?.id, anchor: .bottom)
//                        }
//                    }
//                }
//
//                Divider()
//
//                HStack {
//                    Button(action: sendMessage) {
//                        Image(systemName: "plus.viewfinder")
//                            .resizable()
//                            .frame(width: 22, height: 22)
//                            .foregroundColor(.purple)
//                            .padding()
//                    }
//
//                    TextField("Type a message...", text: $newMessage)
//                        .padding(.horizontal)
//
//                    //
//                    Button(action: sendMessage) {
//                        Image(systemName: "paperplane.fill")
//                            .resizable()
//                            .frame(width: 22, height: 22)
//                            .foregroundColor(Color("Primary"))
//                            .padding()
//                    }
//                }
//
//                .padding(.bottom)
//            }
//
//            .navigationTitle("User2")
//            .navigationBarTitleDisplayMode(.inline)
//            //.foregroundColor(.purple)
//        }
//    }
//
//        func sendMessage() {
//            guard !newMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
//
//            messages.append(ChatMessage(sender: "User1", text: newMessage))
//            newMessage = ""
//        }
//    }
//
//    struct ChatBubble: View {
//        let message: ChatMessage
//        var isCurrentUser: Bool {
//            return message.sender == "User1"
//        }
//
//        var body: some View {
//
//            HStack(alignment: .bottom, spacing: 12) {
//                if !isCurrentUser {
//                    Spacer()
//                }
//
//                VStack(alignment: isCurrentUser ? .
//                       leading : .trailing, spacing: 4) {
//                    Text(message.sender)
//                        .font(.caption)
//                        .foregroundColor(isCurrentUser ? .purple : .gray)
//
//                    Text(message.text)
//                        .padding(10)
//                        .background(isCurrentUser ? Color.purple : Color.purple.opacity(0.2))
//                        .foregroundColor(isCurrentUser ? .white : .primary)
//                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
//                }
//
//                if isCurrentUser {
//                    Spacer()
//                }
//            }
//        }
//    }
//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//    }
//}
//
