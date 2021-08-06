//
//  SavingImages.swift
//  InstaFilter
//
//  Created by Sergio Sepulveda on 2021-08-03.
//

import SwiftUI

class ImageSaverExample: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished")
        
    }
}

struct SavingImages: View {
    
    @State private var image: Image?
    @State private var showingImagepicker: Bool = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            Button("Select Image") {
                
                self.showingImagepicker.toggle()
                
                
            }
        }
        .sheet(isPresented: $showingImagepicker, onDismiss: loadImage) {
            ImagePickerExample(image: self.$inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
        let imageSaver = ImageSaverExample()
        imageSaver.writeToPhotoAlbum(image: inputImage )
    }
    
}

struct SavingImages_Previews: PreviewProvider {
    static var previews: some View {
        SavingImages()
    }
}
