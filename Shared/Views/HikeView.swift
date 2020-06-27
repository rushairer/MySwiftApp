//
//  HikeView.swift
//  MySwiftApp
//
//  Created by Abenx on 2020/6/27.
//

import SwiftUI

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.scale
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)    }
}

struct HikeView: View {
    var hike: Hike
    @State private var showDetail = false
    
    var body: some View {
        VStack {
            HStack {
                HikeGraph(hike: hike, path: \.elevation)
                    .frame(width: 50, height: 30)
                
                VStack(alignment: .leading) {
                    Text(hike.name)
                        .font(.headline)
                    Text(hike.distanceText)
                }

                Spacer()
                
                Image(systemName: "chevron.right.circle")
                    .imageScale(.large)
                    .rotationEffect(.degrees(showDetail ? 90 : 0))
                    .scaleEffect(showDetail ? 1.5 : 1)
                    .padding()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            self.showDetail.toggle()
                        }
                    }
            }
            if showDetail {
                HikeDetail(hike: hike)
                    .offset(x: 0, y: 50.0)
                    .transition(.moveAndFade)
            }
        }
    }
}

struct HikeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HikeView(hike: hikeData[0])
                .padding()
            Spacer()
        }
    }
}
