//
//  Product.swift
//  iBuyApp
//
//  Created by Cleís Aurora Pereira on 30/10/20.
//

final class Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.name == rhs.name && lhs.isCompleted == rhs.isCompleted
    }

    var name: String
    var isCompleted: Bool

    init(name: String, isCompleted: Bool) {
        self.name = name
        self.isCompleted = isCompleted
    }
}
