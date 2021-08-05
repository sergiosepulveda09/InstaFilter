//
//  ContentView.swift
//  InstaFilter
//
//  Created by Sergio Sepulveda on 2021-07-29.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    
    @State private var image: Image?
    @State private var filterIntensity: Double = 0.5
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProccesing()
            }
        
        )
        
        return NavigationView {
                
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
                    Slider(value: intensity)
                    
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
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProccesing()
    }
    
    func applyProccesing() {
        currentFilter.intensity = Float(filterIntensity)
        guard let outputImage = currentFilter.outputImage else {
            return
        }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
