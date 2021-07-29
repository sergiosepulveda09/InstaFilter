//
//  PropetryWrappersToStruct.swift
//  InstaFilter
//
//  Created by Sergio Sepulveda on 2021-07-29.
//

import SwiftUI

struct PropetryWrappersToStruct: View {
    
    @State private var blurAmount: CGFloat  = 0 {
        didSet {
            
            //We need custom binding to trigger this action, because it is not happening somehow
            print("New value is \(blurAmount)")
        }
    }
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .blur(radius: blurAmount)
            Slider(value: $blurAmount, in: 0...20)
        }
    }
}

struct PropetryWrappersToStruct_Previews: PreviewProvider {
    static var previews: some View {
        PropetryWrappersToStruct()
    }
}
