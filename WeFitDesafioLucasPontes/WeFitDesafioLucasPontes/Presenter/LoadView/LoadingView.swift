//
//  LoadingView.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false
    @State private var safeAreaInsets: UIEdgeInsets = .zero
    
    var body: some View {
        ZStack {
            Color.backgroundPrimary.ignoresSafeArea()
            VStack {
                header
                loadCircle
                Spacer()
            }
        }
    }
}

private extension LoadingView {
    
    var loadCircle: some View {
        Circle()
            .trim(from: 0.05, to: 1)
            .stroke(AngularGradient(gradient: Gradient(colors: [.gray, .clear]), center: .center), style: StrokeStyle(lineWidth: 5, lineCap: .butt))
            .frame(width: 62.25, height: 62.25)
            .rotationEffect(Angle(degrees: isAnimating ? 0 : 360 ))
            .onAppear {
                withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                    isAnimating = true
                }
            }
            .padding(.top, 33)
    }
    
    var header: some View {
        HStack(alignment: .center) {
            Text("WeMovies")
                .font(.openSansBold(size: 20))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
        }
        .padding(.top, safeAreaInsets.top)
        .background(Color.backgroundTabBar.ignoresSafeArea())
    }
}
