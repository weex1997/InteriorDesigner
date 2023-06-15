//
//  MediaPicker.swift
//  InteriorDesigner
//
//  Created by Kamran on 13/06/2023.
//

import SwiftUI
import PhotosUI
import AVKit

struct MediaPicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = PHPickerViewController
    
    @Binding var selectedImages: [UIImage]
    @Binding var selectedVideos: [AVPlayer]
    @Binding var mediaUrl : String?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
//        configuration.filter = .any(of: [.images, .videos])
        configuration.filter = .any(of: [.images])
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // No need to update
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    final class Coordinator: PHPickerViewControllerDelegate {
        private let parent: MediaPicker
        
        init(parent: MediaPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.selectedImages.removeAll()
            parent.selectedVideos.removeAll()
            
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                        if let image = image as? UIImage {
                            DispatchQueue.main.async {
                                self.parent.selectedImages.append(image)
                                
                            }
                        }
                    }
                } else {
                    result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { (url, error) in
                        if let url = url {
                            let player = AVPlayer(url: url)
                            DispatchQueue.main.async {
                                self.parent.selectedVideos.append(player)
                            }
                        }
                    }
                }
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
    }
}


