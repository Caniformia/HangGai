//
// Created by Kevin Tan on 2021/6/14.
//

import SwiftUI

extension Font {

    /// Create a font with the large title text style.
    public static var largeTitle: Font {
        Font.custom("FZSSJW--GB1-0", size: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize)
    }

    /// Create a font with the title text style.
    public static var title1: Font {
        Font.custom("FZSSJW--GB1-0", size: UIFont.preferredFont(forTextStyle: .title1).pointSize)
    }

    public static var title2: Font {
        Font.custom("FZSSJW--GB1-0", size: UIFont.preferredFont(forTextStyle: .title2).pointSize)
    }

    public static var title3: Font {
        Font.custom("FZSSJW--GB1-0", size: UIFont.preferredFont(forTextStyle: .title3).pointSize)
    }

    /// Create a font with the headline text style.
    public static var headline: Font {
        Font.custom("FZSSJW--GB1-0", size: UIFont.preferredFont(forTextStyle: .headline).pointSize)
    }

    /// Create a font with the subheadline text style.
    public static var subheadline: Font {
        Font.custom("FZSSJW--GB1-0", size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize)
    }

    /// Create a font with the body text style.
    public static var body: Font {
        Font.custom("FZSSJW--GB1-0", size: UIFont.preferredFont(forTextStyle: .body).pointSize)
    }

    /// Create a font with the callout text style.
    public static var callout: Font {
        Font.custom("FZSSJW--GB1-0", size: UIFont.preferredFont(forTextStyle: .callout).pointSize)
    }

    /// Create a font with the footnote text style.
    public static var footnote: Font {
        Font.custom("FZSSJW--GB1-0", size: UIFont.preferredFont(forTextStyle: .footnote).pointSize)
    }

    /// Create a font with the caption text style.
    public static var caption1: Font {
        Font.custom("FZSSJW--GB1-0", size: UIFont.preferredFont(forTextStyle: .caption1).pointSize)
    }

    public static var caption2: Font {
        Font.custom("FZSSJW--GB1-0", size: UIFont.preferredFont(forTextStyle: .caption2).pointSize)
    }
}