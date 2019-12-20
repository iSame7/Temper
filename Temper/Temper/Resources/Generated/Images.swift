// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import UIKit.UIImage

// MARK: - Image Asset Catalog

internal enum Image {
  internal static let drowning = "drowning"
  internal static let filter = "filter"
  internal enum Icon {
    internal static let closeBlack = "icon/close-black"
    internal static let close = "icon/close"
  }

  internal static let img1 = "img1"
  internal static let img2 = "img2"
  internal static let mapPin = "map-pin"
}

// MARK: - Implementation Details

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: UIImage {
    let bundle = Bundle(for: BundleToken.self)
    let image = UIImage(named: name, in: bundle, compatibleWith: nil)
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal extension UIImage {
  convenience init!(asset: ImageAsset) {
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
  }
}

private final class BundleToken {}
