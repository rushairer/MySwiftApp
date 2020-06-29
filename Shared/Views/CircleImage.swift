//
//  CircleImage.swift
//  Landmark
//
//  Created by Abenx on 2020/6/26.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    var shadowRadius: CGFloat = 10

    var body: some View {
        image
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .shadow(radius: shadowRadius)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("logo.full"))
    }
}
