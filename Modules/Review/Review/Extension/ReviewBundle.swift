//
//  ReviewBundle.swift
//  Review
//
//  Created by Paulo Correa on 30/4/2564 BE.
//

import Foundation

public enum ReviewFramework {
    public static let useResourceBundles = true
    public static let bundleName = "Review.bundle"
}

private class GetBundle {}

extension Bundle {
    public class func ReviewResourceBundle() -> Bundle {
        let framework = Bundle(for: GetBundle.self)
        guard ReviewFramework.useResourceBundles else {
            return framework
        }
        guard let resourceBundleURL = framework.url(
            forResource: ReviewFramework.bundleName,
            withExtension: nil)
        else {
            fatalError("\(ReviewFramework.bundleName) not found!")
        }
        guard let resourceBundle = Bundle(url: resourceBundleURL) else {
            fatalError("Cannot access \(ReviewFramework.bundleName)")
        }
        return resourceBundle
    }
}

extension UIImage {
    class func image(named: String) -> UIImage {
        return UIImage(named: named, in: Bundle.ReviewResourceBundle(), compatibleWith: nil) ?? UIImage()
    }
}
