//
//  SplashView.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import SwiftUI

struct SplashScreenView: View {
    // Propriedade de callback para notificar o término do splash
    var onFinish: () -> Void

    @State private var isAnimating = false

    var body: some View {
        ZStack {
            Image("BackgroundSplash")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Bem vindo a")
                    .font(.openSansBold(size: 20))
                    .foregroundStyle(Color.textlight)

                Text("WeMovies")
                    .font(.openSansBold(size: 42))
                    .foregroundStyle(Color.textlight)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                onFinish()
            }
        }
    }
}
