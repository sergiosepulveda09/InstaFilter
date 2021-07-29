//
//  CreatingCustomBindings.swift
//  InstaFilter
//
//  Created by Sergio Sepulveda on 2021-07-29.
//

import SwiftUI

struct CreatingCustomBindings: View {
    @State private var blurAmount: CGFloat  = 0 {
        didSet {
            
            //We need custom binding to trigger this action, because it is not happening somehow
            print("New value is \(blurAmount)")
        }
    }
    
    var body: some View {
        
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("The new value is \(self.blurAmount)")
            }
        )
        
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .blur(radius: blurAmount)
            Slider(value: blur, in: 0...20)
        }
    }
    
}

struct CreatingCustomBindings_Previews: PreviewProvider {
    static var previews: some View {
        CreatingCustomBindings()
    }
}
