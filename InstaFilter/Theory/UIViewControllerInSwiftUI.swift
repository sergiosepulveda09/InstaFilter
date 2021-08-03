//
//  UIViewControllerInSwiftUI.swift
//  InstaFilter
//
//  Created by Sergio Sepulveda on 2021-08-02.
//

import SwiftUI

struct UIViewControllerInSwiftUI: View {
    
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
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
    }
}

struct UIViewControllerInSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerInSwiftUI()
    }
}
