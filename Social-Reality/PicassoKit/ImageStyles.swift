//
//  ImageStyles.swift
//  Social-Reality
//
//  Created by Nick Crews on 6/23/21.
//

import SwiftUI

struct PKCircleImage: View {
    
    public var image: String
    public var size: CGFloat
    
    var body: some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size, alignment: .center)
            .clipShape(Circle())
            .padding()
    }
    
}
