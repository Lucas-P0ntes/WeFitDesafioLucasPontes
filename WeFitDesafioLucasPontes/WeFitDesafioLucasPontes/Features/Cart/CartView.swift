//
//  CartView.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import SwiftUI

struct CartView: View {
    var coordinator: CoordinatorFlowController?
    @StateObject var viewModel = CartViewModel()
    
    var body: some View {
        Text(viewModel.text)
    }
}

#Preview {
    HomeView()
}
