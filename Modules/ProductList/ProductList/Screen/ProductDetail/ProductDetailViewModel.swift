//
//  ProductListViewModel.swift
//  Core
//
//  Created by Paulo Correa on 1/11/2564 BE.
//

import RxCocoa
import RxSwift
import Core

class ProductDetailViewModel: ViewModelType {
    var input: Input
    var output: Output
    private let disposeBag = DisposeBag()
    private let activityIndicator = ActivityIndicator()
    private let errorTracker = ErrorTracker()
    private let onLoading = PublishSubject<Void>()
    private let onTapProduct = PublishSubject<Int>()
    private let display = PublishSubject<ProductDetailDisplayModel>()
    private let onNext = PublishSubject<String>()

    struct Input {
        let onLoad: AnyObserver<Void>
        let onTapProduct: AnyObserver<Int>
    }
    struct Output {
        let loading: Observable<Bool>
        let display: Observable<ProductDetailDisplayModel>
        let onNext: Observable<String>
        let error: Observable<Error>
    }

    init() {
        input = Input(onLoad: onLoading.asObserver(),
                      onTapProduct: onTapProduct.asObserver())

        output = Output(
            loading: activityIndicator.asDriver(onErrorJustReturn: false).asObservable(),
            display: display.asObservable(),
            onNext: onNext.asObservable(),
            error: errorTracker.asObservable()
        )

        observeInput()
    }

    private func observeInput() {
        disposeBag.insert([
            onLoading.subscribe(onNext: { [weak self] in
                self?.sendRequest()
            })
        ])
    }

    private func sendRequest() {

    }
}
