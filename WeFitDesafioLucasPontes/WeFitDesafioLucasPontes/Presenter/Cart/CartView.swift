//
//  CartView.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import SwiftUI

struct CartView: View {
    @StateObject var viewModel: CartViewModel
    @State private var isSuccess = false
    
    var body: some View {
        VStack(spacing: 24) {
            titleCartShopping
            ScrollView {
                VStack(spacing: 0) {
                    if !viewModel.orderItems.isEmpty {
                        ForEach(viewModel.orderItems) { order in
                            cartProductCard(for: order)
                        }
                        totalSummary
                    } else if isSuccess {
                        successState
                    } else {
                        emptyState
                    }
                }
                .background(Color.white)
                .cornerRadius(4)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal, 24)
        .padding(.top, 33)
        .background(Color.backgroundPrimary)
        .onDisappear {
            isSuccess = false
        }
    }
}

private extension CartView {
    var titleCartShopping: some View {
        HStack {
            Text(verbatim: .cartTitle)
                .font(.openSansBold(size: 20))
                .foregroundColor(Color.textlight)
                .accessibilityLabel(String.cartTitle)
            Spacer()
        }
        .padding(.top, 24)
    }
    
    func cartProductCard(for order: Order) -> some View {
        VStack(spacing: 16) {
            HStack {
                ImageView(imageURL: URL(string: order.products.image), width: 56, height: 72)
                    .accessibilityLabel("Imagem do produto \(order.products.title)")
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(order.products.title)
                        .font(.openSansBold(size: 14))
                        .foregroundStyle(Color.textCustom)
                        .accessibilityLabel("Produto: \(order.products.title)")
                    
                    HStack(spacing: 0) {
                        Text(verbatim: .productAddedOn)
                            .font(.openSansRegular(size: 12))
                            .foregroundStyle(Color.textGray)
                        Text(Date().formattedDate)
                            .font(.openSansBold(size: 12))
                            .foregroundStyle(Color.textGray)
                            .accessibilityLabel("Data de adição: \(Date().formattedDate)")
                    }
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.removeOrder(product: order.products)
                }) {
                    ImageView(image: ImageAssets.icontrash, width: 16, height: 18)
                        .accessibilityLabel("Remover produto do carrinho")
                }
            }
            
            HStack(spacing: 12) {
                Button(action: {
                    viewModel.removeFromCart(product: order.products)
                }) {
                    ImageView(image: ImageAssets.iconless, width: 18, height: 18)
                        .accessibilityLabel(String.removerUnidadeProdutoLabel)
                }
                
                Text("\(order.quantity)")
                    .font(.openSansRegular(size: 14))
                    .frame(width: 59, height: 26)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .accessibilityLabel("Quantidade: \(order.quantity)")
                
                Button(action: {
                    viewModel.addToCart(product: order.products)
                }) {
                    ImageView(image: ImageAssets.iconMore, width: 18, height: 18)
                        .accessibilityLabel(String.adicionarUnidadeProdutoLabel)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(verbatim: .subtotal)
                        .font(.openSansBold(size: 12))
                        .foregroundStyle(Color.textGray)
                    Text("R$ \(Double(order.quantity) * order.products.price, specifier: "%.2f")")
                        .font(.openSansBold(size: 16))
                        .accessibilityLabel("Subtotal: R$ \(Double(order.quantity) * order.products.price, specifier: "%.2f")")
                }
            }
            Divider()
        }
        .padding(16)
    }
    
    var totalSummary: some View {
        VStack(spacing: 16) {
            HStack {
                Text(verbatim: .total)
                    .font(.openSansBold(size: 14))
                    .foregroundStyle(Color.textGray)
                Spacer()
                Text("R$ \(viewModel.totalAmount, specifier: "%.2f")")
                    .font(.openSansBold(size: 24))
                    .foregroundStyle(Color.textCustom)
                    .accessibilityLabel("Total: R$ \(viewModel.totalAmount, specifier: "%.2f")")
            }
            
            Button(action: {
                viewModel.endOrder()
                isSuccess = true
            }) {
                VStack {
                    HStack {
                        Text(verbatim: .finishOrderButton)
                            .font(.openSansBold(size: 14))
                            .foregroundStyle(Color.textlight)
                            .padding(.horizontal, 75)
                            .accessibilityLabel(String.finishOrderButton)
                    }
                    .padding(.vertical, 11)
                }
                .background(Color.ButtonPrimary)
                .cornerRadius(4)
            }
        }
        .padding(16)
        .background(.white)
    }
    
    var emptyState: some View {
        VStack {
            VStack(alignment: .center, spacing: 24) {
                Text(verbatim: .emptyCartMessage)
                    .font(.openSansBold(size: 20))
                    .foregroundStyle(Color.textCustom)
                    .multilineTextAlignment(.center)
                    .accessibilityLabel(String.emptyCartAccessibilityLabel)
                
                ImageView(image: .personBackHome, width: 178, height: 364)
                    .accessibilityLabel(String.emptyCartImageAccessibilityLabel)
                
                Button(action: {
                    viewModel.navigateToSecondTab()
                    HapticManager.shared.playStandardFeedback(type: .success)
                }) {
                    VStack {
                        Text(verbatim: .backToHomeButton)
                            .font(.openSansBold(size: 12))
                            .foregroundStyle(Color.textlight)
                            .padding(.vertical, 11)
                            .padding(.horizontal, 8)
                    }
                    .background(Color.ButtonPrimary)
                    .cornerRadius(4)
                }
            }
            .padding(24)
        }
        .background(Color.white)
        .cornerRadius(4)
        .accessibilityLabel(String.emptyCartAccessibilityLabel)
    }
    
    var successState: some View {
        VStack {
            VStack(alignment: .center, spacing: 24) {
                VStack(spacing: 4) {
                    HStack(spacing: 0) {
                        Text(verbatim: .orderSuccessDatePrefix)
                            .font(.openSansRegular(size: 12))
                            .foregroundColor(Color.textGray)
                            .multilineTextAlignment(.center)
                        
                        Text("\(Date().formattedDate)")
                            .font(.openSansBold(size: 12))
                            .foregroundColor(Color.textGray)
                            .multilineTextAlignment(.center)
                        
                        Text(verbatim: .orderSuccessHourPrefix)
                            .font(.openSansRegular(size: 12))
                            .foregroundColor(Color.textGray)
                            .multilineTextAlignment(.center)
                        
                        Text("\(Date().formattedTime)")
                            .font(.openSansBold(size: 12))
                            .foregroundColor(Color.textGray)
                            .multilineTextAlignment(.center)
                    }
                    
                    Text(verbatim: .orderSuccessMessage)
                        .font(.openSansBold(size: 20))
                        .multilineTextAlignment(.center)
                        .accessibilityLabel(String.orderSuccessMessage)
                }
                ImageView(image: .personAllRight, width: 178, height: 364)
                    .accessibilityLabel(String.emptyCartImageAccessibilityLabel)
                
                Button(action: {
                    viewModel.navigateToSecondTab()
                    HapticManager.shared.playStandardFeedback(type: .success)
                }) {
                    VStack {
                        Text(verbatim: .backToHomeButton)
                            .font(.openSansBold(size: 12))
                            .foregroundColor(Color.textlight)
                            .padding(.vertical, 11)
                            .padding(.horizontal, 40)
                            .accessibilityLabel(String.backToHomeAccessibilityLabel)
                    }
                    .background(Color.ButtonPrimary)
                    .cornerRadius(4)
                }
            }
            .padding(24)
        }
        .background(Color.white)
        .cornerRadius(4)
        .accessibilityLabel(String.orderSuccessScreenAccessibilityLabel)
    }
}

private extension String {
    static let cartTitle = "Carrinho de compras"
    static let productAddedOn = "Adicionado em "
    static let subtotal = "SUBTOTAL"
    static let total = "TOTAL"
    static let finishOrderButton = "FINALIZAR PEDIDO"
    static let emptyCartMessage = "Parece que não há nada por aqui :("
    static let backToHomeButton = "Voltar à Home"
    static let orderSuccessDatePrefix = "Compra realizada em "
    static let orderSuccessMessage = "Compra realizada com sucesso!"
    static let orderSuccessHourPrefix = " às "
    static let backToHomeAccessibilityLabel = "Botão para voltar à tela inicial"
    static let emptyCartAccessibilityLabel = "Carrinho vazio"
    static let emptyCartImageAccessibilityLabel = "Imagem de carrinho vazio"
    static let orderSuccessScreenAccessibilityLabel = "Tela de confirmação de compra"
    static let adicionarUnidadeProdutoLabel = "Adicionar uma unidade do produto"
    static let removerUnidadeProdutoLabel = "Remover uma unidade do produto"
    
}
