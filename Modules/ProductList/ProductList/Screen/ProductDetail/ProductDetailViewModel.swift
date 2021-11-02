//
//  ProductListViewModel.swift
//  Core
//
//  Created by Paulo Correa on 1/11/2564 BE.
//

import RxCocoa
import RxSwift
import Core
import APILayer

class ProductDetailViewModel: ViewModelType {
    var input: Input
    var output: Output
    private let disposeBag = DisposeBag()
    private let apiClient = APIClient()

    private let onDidLoad = PublishSubject<Void>()
    private let onTapProduct = PublishSubject<String>()
    private let display = PublishSubject<ProductDetailDisplayModel>()
    private let onNext = PublishSubject<String>()

    private let productId: BehaviorSubject<String>

    struct Input {
        let onDidLoad: AnyObserver<Void>
        let onTapProduct: AnyObserver<String>
    }
    struct Output {
        let display: Observable<ProductDetailDisplayModel>
        let onNext: Observable<String>
    }

    init(productId: String) {
        self.productId = .init(value: productId)

        input = Input(onDidLoad: onDidLoad.asObserver(),
                      onTapProduct: onTapProduct.asObserver())

        output = Output(
            display: display.asObservable(),
            onNext: onNext.asObservable()
        )

        observeInput()
    }

    private func observeInput() {
        let image = BehaviorSubject<UIImage?>.init(value: UIImage())

        disposeBag.insert(
            onDidLoad
                .withLatestFrom(productId)
                .map { ProductDetailRequest(id: $0) }
                .flatMapLatest { [unowned self] request -> Observable<ProductModel> in
                    return self.apiClient.send(apiRequest: request)
                }
                .do (onNext: { product in
                    DispatchQueue.global().async {
                        image.onNext(downloadImage(from: URL(string: product.imgUrl)!))
                    }
                })
                .map { ProductDetailDisplayModel(title: "Product Detail",
                                                 name: $0.name,
                                                 price: "\($0.currency) \($0.price)",
                                                 description: $0.description,
                                                 image: image,
                                                 reviews: ["Review One", "Review Two", "Review Three"]) }

                .bind(to: display),

            onTapProduct
                .bind(to: onNext)
        )
    }

    private func sendRequest() {

    }
}
