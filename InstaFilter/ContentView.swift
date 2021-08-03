//
//  ContentView.swift
//  InstaFilter
//
//  Created by Sergio Sepulveda on 2021-07-29.
//

import SwiftUI

struct ContentView: View {
    
    @State private var image: Image?
    @State private var filterIntensity: Double = 0.5
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        NavigationView {
                
            VStack {
                
                ZStack {
                    
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        
                        image?
                            .resizable()
                            .scaledToFit()
                        
                    } else {
                        
                        Text("Tap to select the picture")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                    }
                    
                }
                .onTapGesture {
                    
                    self.showingImagePicker.toggle()
                
                }
                
                HStack {
                    
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                    
                }
                .padding(.vertical)
                
                HStack {
                    
                    Button("Change filter") {
                        
                        //Change filter
                        
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        
                        //Save the picture
                        
                    }
                    
                }
                
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
        }
    }
    
    func loadImage() {
        
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
