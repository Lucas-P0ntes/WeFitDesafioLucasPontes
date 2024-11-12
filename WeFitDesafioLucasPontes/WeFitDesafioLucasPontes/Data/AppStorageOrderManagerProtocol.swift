//
//  OderDataStoreProtocol.swift
//  WeFitDesafioLucasPontes
//
//  Created by Lucas Pontes on 10/11/24.
//

import Combine

protocol AppStorageOrderManagerProtocol: AnyObject {
    var ordersPublisher: AnyPublisher<[Order], Never> { get }
    func getAllOrders() -> [Order]
    func updateOrder(idProduct: Int, product: products, _ quantity: Int?)
    func addOrder(_ product: products, _ quantity: Int)
    func removeOrder(_ product: products)
    func endOrders()
}
