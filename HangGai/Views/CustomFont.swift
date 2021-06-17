//
// Created by Kevin Tan on 2021/6/14.
//

import SwiftUI

extension Font {

    /// Create a font with the large title text style.
    public static var largeTitle: Font {
        Font.custom("SourceHanSerifCN-Regular", size: 45, relativeTo: .largeTitle)
    }

    /// Create a font with the title text style.
    public static var title1: Font {
        Font.custom("SourceHanSerifCN-Regular", size: 30, relativeTo: .title)
    }

    public static var title2: Font {
        Font.custom("SourceHanSerifCN-Regular", size: 20, relativeTo: .title2)
    }

    public static var title3: Font {
        Font.custom("SourceHanSerifCN-Regular", size: UIFont.preferredFont(forTextStyle: .title3).pointSize)
    }

    /// Create a font with the headline text style.
    public static var headline: Font {
        Font.custom("SourceHanSerifCN-Regular", size: 17, relativeTo: .headline)
    }

    /// Create a font with the subheadline text style.
    public static var subheadline: Font {
        Font.custom("SourceHanSerifCN-Regular", size: 13, relativeTo: .subheadline)
    }

    /// Create a font with the body text style.
    public static var body: Font {
        Font.custom("SourceHanSerifCN-Medium", size: 15, relativeTo: .body)
    }

    /// Create a font with the callout text style.
    public static var callout: Font {
        Font.custom("SourceHanSerifCN-Regular", size: UIFont.preferredFont(forTextStyle: .callout).pointSize)
    }

    /// Create a font with the footnote text style.
    public static var footnote: Font {
        Font.custom("SourceHanSerifCN-Regular", size: UIFont.preferredFont(forTextStyle: .footnote).pointSize)
    }

    /// Create a font with the caption text style.
    public static var caption1: Font {
        Font.custom("SourceHanSerifCN-Regular", size: 13, relativeTo: .caption)
    }

    public static var caption2: Font {
        Font.custom("SourceHanSerifCN-Regular", size: 14, relativeTo: .caption)
    }
}

struct AnimatableCustomFontModifier: AnimatableModifier {
    let name: String
    var size: CGFloat

    var animatableData: CGFloat {
        get { size }
        set { size = newValue }
    }

    func body(content: Content) -> some View {
        content
            .font(.custom(name, size: size))
    }
}

extension View {
    func animatableFont(name: String, size: CGFloat) -> some View {
        self.modifier(AnimatableCustomFontModifier(name: name,size: size))
    }
}
