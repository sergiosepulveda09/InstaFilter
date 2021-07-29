//
//  ActionSheetMultipleActions.swift
//  InstaFilter
//
//  Created by Sergio Sepulveda on 2021-07-29.
//

import SwiftUI

struct ActionSheetMultipleActions: View {
    
    @State private var showingAlert: Bool = false
    @State private var backgroundColor: Color = Color.white
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                self.showingAlert = true
            }
            .actionSheet(isPresented: $showingAlert) {
                ActionSheet(title: Text("Change Background"), message: Text("Select new color"), buttons: [
                    .default(Text("Red"), action: {
                        self.backgroundColor = Color.red
                    }),
                    .default(Text("Green"), action: {
                        self.backgroundColor = Color.green
                    }),
                    .default(Text("Blue"), action: {
                        self.backgroundColor = Color.blue
                    }),
                    .cancel()
                
                ])
            }
        
    }
}

struct ActionSheetMultipleActions_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheetMultipleActions()
    }
}
