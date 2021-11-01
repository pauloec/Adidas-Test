//
//  ProductListCell.swift
//  ProductList
//
//  Created by Paulo Correa on 1/11/2564 BE.
//

import UIKit
import SnapKit
import Core

class ProductListCell: UITableViewCell, ControllerType {
    typealias ViewModelType = ProductListCellViewModel
    private weak var viewModel: ViewModelType!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        setupViews()
    }

    func configViewModel(viewModel: ProductListCellViewModel) {
        self.viewModel = viewModel
        bindViewModel()
    }

    func bindViewModel() {
        
    }

    func setupViews() {
        
    }
}
