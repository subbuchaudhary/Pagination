//
//  MyImage.swift
//  Pagination
//
//  Created by Subba Nelakudhiti on 9/10/24.
//

import SwiftUI

/// A view that is used to display an icon.
/// Should only be used for icons. Any image bigger than
/// 32x32 should use the Image with Image Name initializer.
public struct MyImage: View {
    /// The  Image name for the asset to be displayed.
    private var imageName: String
    /// The Color of the image will be tinted.
    private var tintColor: Color
    /// Determines the frame of the Image.
    private var imageSize: ImageSize
    /// Determines whether the image will be tinted or kept raw.
    private var isRawImage: Bool

    // MARK: - Init

    public init(imageName: String, tintColor: Color = .black, isRawImage: Bool = false, imageSize: ImageSize = .medium) {
        self.imageName = imageName
        self.tintColor = tintColor
        self.isRawImage = isRawImage
        self.imageSize = imageSize
    }

    public var body: some View {
        VStack {
            Image(systemName: imageName)
                .renderingMode(isRawImage ? .original : .template)
                .resizable()
                .scaledToFit()
                .foregroundColor(tintColor)
        }
        .frame(width: imageSize.rawValue, height: imageSize.rawValue)
    }
}

public extension MyImage {
    // MARK: - Image Size

    enum ImageSize: CGFloat {
        /// 16x16
        case extraSmall = 12
        /// 20x20
        case small =  20
        /// 24x24
        case medium = 24
        /// 32x32
        case large = 32
        /// 40x40
        case extraLarge = 48
    }
}

#if DEBUG
struct MyImage_Previews: PreviewProvider {
    static var previews: some View {
        Image(systemName: "house")
    }
}
#endif
