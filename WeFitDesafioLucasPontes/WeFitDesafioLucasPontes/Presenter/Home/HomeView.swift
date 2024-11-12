//
//  HomeView.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        ZStack {
            Color.backgroundPrimary
            VStack(spacing: 24) {
                if false {
                    emptyState
                } else {
                    titleMostSell
                    productCards
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 33)
            .onAppear() {
                viewModel.appearAction()
            }
        }
    }
}

private extension HomeView {
    
    var titleMostSell: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(verbatim: .mostSoldTitle)
                    .font(.openSansBold(size: 20))
                    .foregroundColor(Color.textlight)
                    .accessibilityLabel(String.mostSoldSection)
                
                Text(verbatim:.mostSoldSubtitle)
                    .font(.openSansRegular(size: 12))
                    .foregroundColor(Color.textlight)
                    .accessibilityLabel(String.mostSoldDescription)
            }
            .padding(.top, 23)
            Spacer()
        }
    }
    
    var productCards: some View {
        ScrollView {
            ForEach(viewModel.orderItems) { orderItems in
                cardMoveBuy(for: orderItems)
                    .padding(.bottom, 16)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(String.productAccessibilityLabel(for: orderItems.products))
            }
        }
        .scrollIndicators(.hidden)
        .accessibilityLabel(String.productList)
    }
    
    func cardMoveBuy(for orderItems: Order) -> some View {
        VStack {
            VStack(spacing: 8) {
                ImageView(imageURL: URL(string: orderItems.products.image), width: 147, height: 188)
                    .accessibilityLabel(String.productImageLabel(for: orderItems.products))
                
                Text(orderItems.products.title)
                    .foregroundStyle(Color.textDark)
                    .font(.openSansBold(size: 12))
                    .accessibilityLabel(orderItems.products.title)
                
                Text(String.priceLabel(for: orderItems.products.price))
                    .foregroundStyle(Color.textCustom)
                    .font(.openSansBold(size: 16))
                    .accessibilityLabel(String.priceAccessibilityLabel(for: orderItems.products.price))
                
                buttonAddCart(for: orderItems)
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity)
        .background(Color.textlight)
        .cornerRadius(4)
    }
    
    func buttonAddCart(for orderItems: Order) -> some View {
        Button(action: {
            viewModel.addToCart(product: orderItems.products, quantity: 1)
            HapticManager.shared.playStandardFeedback(type: .success)
        }) {
            VStack {
                HStack(spacing: 12) {
                    HStack(spacing: 3.4) {
                        ImageView(image: .cartAdd, width: 13.6, height: 13.6)
                            .accessibilityLabel(String.cartIcon)
                        Text("\(orderItems.quantity)")
                            .font(.caption)
                            .foregroundStyle(Color.textlight)
                            .bold()
                            .accessibilityLabel(String.cartQuantityLabel(for: orderItems.quantity))
                    }
                    Text(verbatim: .addToCartButton)
                        .font(.openSansBold(size: 12))
                        .foregroundStyle(Color.textlight)
                        .lineLimit(0)
                        .accessibilityLabel(String.addToCartAccessibilityLabel)
                }
                .padding(.vertical, 11)
                .padding(.horizontal, 43)
            }
            .background(orderItems.quantity > 0 ? Color.ButtonPrimaryaddCart : Color.ButtonPrimary)
            .cornerRadius(4)
        }
    }

    var emptyState: some View {
        VStack {
            VStack(alignment: .center, spacing: 24) {
                Text(verbatim: .emptyStateMessage)
                    .font(.openSansBold(size: 20))
                    .foregroundStyle(Color.textCustom)
                    .multilineTextAlignment(.center)
                    .accessibilityLabel(String.emptyStateAccessibilityLabel)
                
                ImageView(image: .personReload, width: 178, height: 364)
                    .accessibilityLabel(String.reloadImage)
                
                Button(action: {
                }) {
                    VStack {
                        HStack {
                            Text(verbatim: .reloadButton)
                                .font(.openSansBold(size: 12))
                                .foregroundStyle(Color.textlight)
                                .accessibilityLabel(String.reloadButtonAccessibilityLabel)
                        }
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
        .accessibilityLabel(String.emptyScreen)
    }
}
private extension String {
    static let mostSoldTitle = "Mais vendidos"
    static let mostSoldSection = "Seção de produtos mais vendidos"
    static let mostSoldSubtitle = "Maiores sucessos do WeMovies"
    static let mostSoldDescription = "Descrição dos maiores sucessos"
    static let productList = "Lista de produtos"
    static let cartIcon = "Ícone adicionar ao carrinho"
    static let addToCartButton = "ADICIONAR AO CARRINHO"
    static let addToCartAccessibilityLabel = "Botão para adicionar ao carrinho"
    static let emptyStateMessage = "Parece que não há nada por aqui :("
    static let emptyStateAccessibilityLabel = "Estado vazio: Nenhum produto encontrado."
    static let reloadImage = "Imagem de recarga"
    static let reloadButton = "Recarregar página"
    static let reloadButtonAccessibilityLabel = "Botão de recarregar página"
    static let emptyScreen = "Tela de erro: Nenhum conteúdo disponível"
    
    static func productAccessibilityLabel(for product: products) -> String {
        "Produto: \(product.title), preço: R$ \(String(format: "%.2f", product.price))"
    }
    
    static func productImageLabel(for product: products) -> String {
        "Imagem do produto \(product.title)"
    }
    
    static func priceLabel(for price: Double) -> String {
        "R$ \(String(format: "%.2f", price))"
    }
    
    static func priceAccessibilityLabel(for price: Double) -> String {
        "Preço: R$ \(String(format: "%.2f", price))"
    }
    
    static func cartQuantityLabel(for quantity: Int) -> String {
        "Quantidade no carrinho: \(quantity)"
    }
}
