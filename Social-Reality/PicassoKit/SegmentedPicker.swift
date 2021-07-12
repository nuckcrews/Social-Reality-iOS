//
//  SegmentedPicker.swift
//  Social-Reality
//
//  Created by Nick Crews on 7/11/21.
//

import SwiftUI

struct PKPageSegmentedPicker: View {
    @State private var selectedIndex = 0
    var images: [String]
    var colors = [Color.primary, Color.green, Color.blue]
    @State private var frames = Array<CGRect>(repeating: .zero, count: 3)

    var body: some View {
        ZStack {
            HStack(spacing: 10) {
                ForEach(self.images.indices, id: \.self) { index in
                    Button(action: { self.selectedIndex = index }) {
                        Image(systemName: "heart.fill")
                            .tag(index)
                            .foregroundColor(
                                selectedIndex == index ? Color.primary : Color.grayText
                            )
                    }
                    .padding()
                    .background(
                        GeometryReader { geo in
                        Color.clear.onAppear { self.setFrame(index: index, frame: geo.frame(in: .global)) }
                    }
                    )
                }
            }
            .background(
                Divider()
//                    .foregroundColor(.primary)
                    .frame(width: self.frames[self.selectedIndex].width,
                           height: 4,
                           alignment: .bottomLeading)
                    .offset(x: self.frames[self.selectedIndex].minX - self.frames[0].minX,
                            y: (self.frames[self.selectedIndex].height / 2) - 4)
                , alignment: .leading
            )
        }
        .animation(.default)
//        .background(Capsule().stroke(Color.gray, lineWidth: 3))
    }

    func setFrame(index: Int, frame: CGRect) {
        self.frames[index] = frame
    }
}


struct SegmentedPicker_Previews: PreviewProvider {
    static var previews: some View {
        PKPageSegmentedPicker(images: ["heart.fill", "heart.fill", "heart.fill"])
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("PKPageSegmentedPicker")
    }
}
