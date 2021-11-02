//
//  ProductDetailDisplayModel.swift
//  Core
//
//  Created by Paulo Correa on 1/11/2564 BE.
//

import RxSwift
import RxCocoa

struct ProductDetailDisplayModel {
    let title: String
    let name: String
    let price: String
    let description: String
    let image: BehaviorSubject<UIImage?>
    let reviews: [String]
}
