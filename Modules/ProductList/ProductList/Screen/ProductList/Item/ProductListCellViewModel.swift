//
//  ProductListCellViewModel.swift
//  Core
//
//  Created by Paulo Correa on 1/11/2564 BE.
//

import Core
import RxSwift
import RxCocoa

class ProductListCellViewModel: ViewModelType {
    private let image = BehaviorSubject<UIImage?>.init(value: nil)
    
    struct Input {

    }
    struct Output {
        let name: Observable<String>
        let image: Observable<UIImage?>
        let price: Observable<String>
        let description: Observable<String>
        let id: Observable<String>
    }

    let input: Input
    let output: Output

    init(name: String,
         imageUrl: String,
         price: String,
         description: String,
         id: String) {
        input = Input()
        output = Output(name: BehaviorSubject<String>.init(value: name),
                        image: image,
                        price: BehaviorSubject<String>.init(value: price),
                        description: BehaviorSubject<String>.init(value: description),
                        id: BehaviorSubject<String>.init(value: id))

        DispatchQueue.global().async { [weak self] in
            self?.image.onNext(downloadImage(from: URL(string: imageUrl)!))
        }
    }
}
