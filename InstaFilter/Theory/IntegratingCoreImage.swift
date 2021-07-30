//
//  IntegratingCoreImage.swift
//  InstaFilter
//
//  Created by Sergio Sepulveda on 2021-07-30.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct IntegratingCoreImage: View {
    
    @State private var image: Image?
    
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        guard let inputImage = UIImage(named: "Example") else {
            print("Couldn't find the image")
            return
        }
        let beginImage = CIImage(image: inputImage)
        let context = CIContext()
//        let currentFilter = CIFilter.sepiaTone()
//        currentFilter.inputImage = beginImage
//        currentFilter.intensity = 1
        //Pixellate
        let currentFilter = CIFilter.pixellate()
        currentFilter.inputImage = beginImage
        currentFilter.scale = 100
        //Crystallize
//        let currentFilter = CIFilter.crystallize()
//        currentFilter.inputImage = beginImage
//        currentFilter.radius = 200
        //TwirlDistortion
//        let currentFilter = CIFilter.twirlDistortion()
//        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//        currentFilter.setValue(2000, forKey: kCIInputRadiusKey)
//        currentFilter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2), forKey: kCIInputCenterKey)

        
        
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else {
            print("Couldn't convert from CIFilter to CIImage")
            return
        }
        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)

            // and convert that to a SwiftUI image
            image = Image(uiImage: uiImage)
            
        
        }
        
        
        
    }
}

struct IntegratingCoreImage_Previews: PreviewProvider {
    static var previews: some View {
        IntegratingCoreImage()
    }
}
