//
//  ImageView.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 09/11/24.
//

import SwiftUI

public struct ImageView: View {
    
    // MARK: - Init
    
    public init(
        image: Image?,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        contentMode: ContentMode = .fit
    ) {
        self.image = image ?? .init("")
        self.width = width
        self.height = height
        self.contentMode = contentMode
    }
    
    public init(
        image: UIImage?,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        contentMode: ContentMode = .fit
    ) {
        self.image = Image(uiImage: image ?? .init())
        self.width = width
        self.height = height
        self.contentMode = contentMode
    }
    
    public init(
        imageURL: URL?,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        contentMode: ContentMode = .fit
    ) {
        self.imageURL = imageURL
        self.width = width
        self.height = height
        self.contentMode = contentMode
    }
    
    // MARK: - Variables
    
    private var image: Image?
    private var imageURL: URL?
    private var width: CGFloat?
    private var height: CGFloat?
    private var contentMode: ContentMode
    
    // MARK: - Layout
    
    public var body: some View {
        Group {
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .frame(width: width, height: height, alignment: .center)
            } else if let imageURL = imageURL {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: width, height: height)
                    case .success(let loadedImage):
                        loadedImage
                            .resizable()
                            .aspectRatio(contentMode: contentMode)
                            .frame(width: width, height: height, alignment: .center)
                    case .failure:
                        Image(systemName: "exclamationmark.triangle")
                            .resizable()
                            .aspectRatio(contentMode: contentMode)
                            .frame(width: width, height: height, alignment: .center)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .frame(width: width, height: height, alignment: .center)
            }
        }
    }
}
