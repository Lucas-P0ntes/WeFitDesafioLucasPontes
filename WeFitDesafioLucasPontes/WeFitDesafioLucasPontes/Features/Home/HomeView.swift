//
//  HomeView.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import SwiftUI

struct HomeView: View {
    var coordinator: CoordinatorFlowController?
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        Text(viewModel.text)
    }
}

#Preview {
    HomeView()
}
