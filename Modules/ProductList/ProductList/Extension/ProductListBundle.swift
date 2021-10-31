//
//  ProductListBundle.swift
//  ProductList
//
//  Created by Paulo Correa on 30/4/2564 BE.
//

import Foundation

public enum ProductListFramework {
    public static let useResourceBundles = true
    public static let bundleName = "ProductList.bundle"
}

private class GetBundle {}

extension Bundle {
    public class func ProductListResourceBundle() -> Bundle {
        let framework = Bundle(for: GetBundle.self)
        guard ProductListFramework.useResourceBundles else {
            return framework
        }
        guard let resourceBundleURL = framework.url(
            forResource: ProductListFramework.bundleName,
            withExtension: nil)
        else {
            fatalError("\(ProductListFramework.bundleName) not found!")
        }
        guard let resourceBundle = Bundle(url: resourceBundleURL) else {
            fatalError("Cannot access \(ProductListFramework.bundleName)")
        }
        return resourceBundle
    }
}

extension UIImage {
    class func image(named: String) -> UIImage {
        return UIImage(named: named, in: Bundle.ProductListResourceBundle(), compatibleWith: nil) ?? UIImage()
    }
}
