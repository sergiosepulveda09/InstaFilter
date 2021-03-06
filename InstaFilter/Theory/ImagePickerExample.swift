//
//  ImagePicker.swift
//  InstaFilter
//
//  Created by Sergio Sepulveda on 2021-08-02.
//

import SwiftUI

struct ImagePickerExample: UIViewControllerRepresentable {
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePickerExample
        
        init(_ parent: ImagePickerExample) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
}
