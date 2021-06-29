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
                            .foregroundColor(.accentColor))
    }
}

fileprivate struct PKCapsuleBorderedButton_preview: View {
    var body: some View {
        Button(action: {
            print("button pressed")
        }) {
            Text("Button")
        }
        .buttonStyle(PKCapsuleBorderedButton())
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
                            .foregroundColor(.accentColor))
    }
}

fileprivate struct PKSquareBorderedButton_preview: View {
    var body: some View {
        Button(action: {
            print("button pressed")
        }) {
            Text("Button")
        }
        .buttonStyle(PKSquareBorderedButton())
    }
}

struct PKCapsuleFilledButton: ButtonStyle {
    
    public var backgroundColor: Color
    public var textColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(textColor)
            .padding(.horizontal, .m3)
            .padding(.vertical, .m1)
            .background(Capsule()
                            .foregroundColor(backgroundColor)
                            .shadow(radius: .s1))
    }
}

fileprivate struct PKCapsuleFilledButton_preview: View {
    var body: some View {
        Button(action: {
            print("button pressed")
        }) {
            Text("Button")
        }
        .buttonStyle(PKCapsuleFilledButton(backgroundColor: .accentColor,
                                          textColor: .white))
    }
}

struct PKSquareFilledButton: ButtonStyle {
    
    public var backgroundColor: Color
    public var textColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(textColor)
            .padding(.horizontal, .m3)
            .padding(.vertical, .m1)
            .background(Rectangle()
                            .foregroundColor(backgroundColor)
                            .shadow(radius: .s1)
            )
    }
}

fileprivate struct PKSquareFilledButton_preview: View {
    var body: some View {
        Button(action: {
            print("button pressed")
        }) {
            Text("Button")
        }
        .buttonStyle(PKSquareFilledButton(backgroundColor: .accentColor,
                                          textColor: .white))
    }
}

struct ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        
        PKCapsuleFilledButton_preview()
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("PKCapsuleFilledButton")
        
    }
}
