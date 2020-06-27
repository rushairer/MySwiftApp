//
//  DraggableView.swift
//  MySwiftApp
//
//  Created by Abenx on 2020/6/27.
//

import SwiftUI

struct DraggableVie: View {
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    
    var body: some View {
        Circle()
            .frame(width: 100, height: 100)
            .foregroundColor(Color.red)
            .offset(x: self.currentPosition.width, y: self.currentPosition.height)
            // 3.
            .gesture(DragGesture()
                        .onChanged { value in
                            self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                        }   // 4.
                        .onEnded { value in
                            self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                            print(self.newPosition.width)
                            self.newPosition = self.currentPosition
                        }
            )
    }
}


struct DraggableVie_Previews: PreviewProvider {
    static var previews: some View {
        DraggableVie()
    }
}
