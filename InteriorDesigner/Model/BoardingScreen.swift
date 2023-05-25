//
//  BoardingScreen.swift
//  BoardingScreen
//
//  Created by Hajar on 18/05/23.
//

import SwiftUI

struct BoardingScreen: Identifiable {
    var id = UUID().uuidString
    var image: String
    var title: String
    var description: String
}

// Same Title and desc...
let title = "Facilitate client-interior designer \nCommunication"
let description = "We provided simpler, faster, and safer communication rather to trying to figure out how to communicate between the interior designer and the clients."

// Since image name and BG color name are same....

// Sample Model SCreens....
var boardingScreens: [BoardingScreen] = [

    BoardingScreen(image: "screen1", title: title, description: description),
    BoardingScreen(image: "screen2", title: title, description: description),
    BoardingScreen(image: "screen3", title: title, description: description),
    BoardingScreen(image: "screen4", title: title, description: description),
]
