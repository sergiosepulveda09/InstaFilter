//
//  ContentView.swift
//  InstaFilter
//
//  Created by Sergio Sepulveda on 2021-07-29.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

enum ValueSlider: String {
    case Intensity = "Intensity"
    case Radius = "Radius"
    case Scale = "Scale"
}

struct ContentView: View {
    
    @State private var image: Image?
    @State private var filterIntensity: Double = 0.5
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilterSheet = false
    @State private var processedImage: UIImage?
    @State private var title: String = "InstaFilter"
    @State private var showingAlert: Bool = false
    
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
                    
                    Text("\(findSliderName())")
                    Slider(value: intensity)
                    
                }
                
                .padding(.vertical)
                
                HStack {
                    
                    Button("Change filter") {
                        
                        self.showingFilterSheet = true
                        
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        
                        guard let processedImage = self.processedImage else {
                            self.showingAlert.toggle()
                            return
                        }
                        let imageSaver = ImageSaver()
                        
                        imageSaver.successHandler = {
                            print("Image saved successfully")
                        }
                        imageSaver.errorHandler = {
                            print("There was an error: \($0.localizedDescription)")
                        }
                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                        
                    }
                    
                }
                
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("\(title)")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Not Image Selected"), message: Text("Please select an image"), dismissButton: .default(Text("OK!")))
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) {
                        self.setFilter(CIFilter.crystallize())
                        self.title = "Crystallize Filter"
                        
                    },
                    .default(Text("Edges")) {
                        self.setFilter(CIFilter.edges())
                        self.title = "Edges Filter"
                    },
                    .default(Text("Gaussian Blur")) {
                        self.setFilter(CIFilter.gaussianBlur())
                        self.title = "Gaussian Blur Filter"
                    },
                    .default(Text("Pixellate")) {
                        self.setFilter(CIFilter.pixellate())
                        self.title = "Pixellate Filter"
                    },
                    .default(Text("Sepia Tone")) {
                        self.setFilter(CIFilter.sepiaTone())
                        self.title = "Sepia Tone Filter"
                    },
                    .default(Text("Unsharp Mask")) {
                        self.setFilter(CIFilter.unsharpMask())
                        self.title = "Unsharp Mask Filter"
                    },
                    .default(Text("Vignette")) {
                        self.setFilter(CIFilter.vignette())
                        self.title = "Vignette Filter"
                    },
                    .cancel()
            
                ])
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
    
    func findSliderName() -> String {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            return ValueSlider.Intensity.rawValue
        }
        else if inputKeys.contains(kCIInputRadiusKey) {
            return ValueSlider.Radius.rawValue
        }
        else {
            return ValueSlider.Scale.rawValue
        }
        
    }
    func applyProccesing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        guard let outputImage = currentFilter.outputImage else {
            return
        }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
