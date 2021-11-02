//
//  ImageView+Download.swift
//  ProductList
//
//  Created by Paulo Correa on 1/11/2564 BE.
//

func downloadImage(from url: URL) -> UIImage? {
    guard let data = try? Data(contentsOf: url) else { return UIImage() }
    return UIImage(data: data)
}
