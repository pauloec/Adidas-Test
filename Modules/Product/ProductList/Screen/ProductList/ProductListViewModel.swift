//
//  ProductListViewModel.swift
//  ProductList
//
//  Created by Paulo Correa on 10/5/2564 BE.
//

import RxCocoa
import RxSwift
import Core
import APILayer

class ProductListViewModel: ViewModelType {
    var input: Input
    var output: Output
    private let disposeBag = DisposeBag()
    private let apiClient = APIClient()

    private let onDidLoad = PublishSubject<Void>()
    private let onTapProduct = PublishSubject<String>()
    private let display = PublishSubject<ProductListDisplayModel>()
    private let onNext = PublishSubject<String>()

    struct Input {
        let onDidLoad: AnyObserver<Void>
        let onTapProduct: AnyObserver<String>
    }
    struct Output {
        let display: Observable<ProductListDisplayModel>
        let onNext: Observable<String>
    }
    
    init() {
        input = Input(onDidLoad: onDidLoad.asObserver(),
                      onTapProduct: onTapProduct.asObserver())

        output = Output(
            display: display.asObservable(),
            onNext: onNext.asObservable()
        )

        observeInput()
    }

    private func observeInput() {
        disposeBag.insert(
            onDidLoad
                .map { ProductListRequest() }
                .flatMapLatest { [unowned self] request -> Observable<[ProductModel]> in
                    return self.apiClient.send(apiRequest: request)
                }
                .map { $0.map { ProductListCellViewModel(name: $0.name,
                                                         imageUrl: $0.imgUrl,
                                                         price: "\($0.currency) \($0.price)",
                                                         description: $0.description,
                                                         id: $0.id) } }
                .map { ProductListDisplayModel(title: "Product List", productList: $0) }
                .bind(to: display),

            onTapProduct
                .bind(to: onNext)
        )
    }
}
