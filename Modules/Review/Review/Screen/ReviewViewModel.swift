//
//  ReviewViewModel.swift
//  Review
//
//  Created by Paulo Correa on 10/5/2564 BE.
//

import Core
import RxCocoa
import RxSwift

class ReviewViewModel: ViewModelType {
    var input: Input
    var output: Output
    private let disposeBag = DisposeBag()
    private let activityIndicator = ActivityIndicator()
    private let errorTracker = ErrorTracker()
    private let onLoading = PublishSubject<Void>()
    private let display = PublishSubject<ReviewDisplayModel>()

    struct Input {
        let onLoading: AnyObserver<Void>
    }
    struct Output {
        let loading: Observable<Bool>
        let display: Observable<ReviewDisplayModel>
        let onNext: Observable<Void>
        let error: Observable<Error>
    }

    init() {
        input = Input(onLoading: onLoading.asObserver())
        output = Output(
            loading: activityIndicator.asDriver(onErrorJustReturn: false).asObservable(),
            display: display.asObservable(),
            onNext: PublishSubject<Void>(),
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
