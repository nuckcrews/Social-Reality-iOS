//
//  ButtonStyles.swift
//  Social-Reality
//
//  Created by Nick Crews on 6/23/21.
//

import SwiftUI

struct PKCapsuleBorderedButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? .gray : .accentColor)
            .padding(.horizontal, .m3)
            .padding(.vertical, .m1)
            .background(Capsule()
                            .stroke(lineWidth: .xs3)
                            .foregroundColor(.accentColor)
                        
            )
    }
    
}

struct PKSquareBorderedButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? .gray : .accentColor)
            .padding(.horizontal, .m3)
            .padding(.vertical, .m1)
            .background(Rectangle()
                            .stroke(lineWidth: .xs3)
                            .foregroundColor(.accentColor)
                        
            )
    }
    
}
