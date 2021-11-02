//
//  ProductListViewController.swift
//  ProductList
//
//  Created by Paulo Correa on 10/5/2564 BE.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Core

class ProductListViewController: UIViewController {
    private let tableView: UITableView =  {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        return tableView
    }()

    private var viewModel: ProductListViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
        viewModel.input.onDidLoad.onNext(())
    }
}

extension ProductListViewController: ControllerType {
    typealias ViewModelType = ProductListViewModel
    
    func configViewModel(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }

    func bindViewModel() {
        let output = viewModel.output
        let input = viewModel.input
        disposeBag.insert([
            output.display
                .map { $0.productList }
                .bind(to: tableView.rx.items(cellIdentifier: "ProductList",
                                             cellType: ProductListCell.self)) { index, viewModel, cell in
                                                 cell.configViewModel(viewModel: viewModel)
                                             },
            output.display
                .map { $0.title }
                .bind(to: rx.title),

            tableView.rx.modelSelected(ProductListCellViewModel.self)
                .flatMap { $0.output.id }
                .bind(to: input.onTapProduct)
        ])
    }

    func setupViews() {
        view.backgroundColor = .white
        setupTableView()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.register(ProductListCell.self, forCellReuseIdentifier: "ProductList")
    }
}
