//
// Created by Kevin Tan on 2021/6/14.
//

import SwiftUI

extension Font {

    /// Create a font with the large title text style.
    public static var headTitle: Font {
        Font.custom("FZSSJW--GB1-0", size: 35.0)
    }
    
    public static var largeTitle: Font {
        Font.custom("FZSSJW--GB1-0", size: 30.0)
    }

    /// Create a font with the title text style.
    public static var title1: Font {
        Font.custom("FZSSJW--GB1-0", size: 45.0)
    }

    public static var title2: Font {
        Font.custom("FZSSJW--GB1-0", size: 20.0)
    }

    public static var title3: Font {
        Font.custom("FZSSJW--GB1-0", size: 15.0)
    }

    /// Create a font with the headline text style.
    public static var headline: Font {
        Font.custom("FZSSJW--GB1-0", size: 15.0)
    }

    /// Create a font with the subheadline text style.
    public static var subheadline: Font {
        Font.custom("FZSSJW--GB1-0", size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize)
    }

    /// Create a font with the body text style.
    public static var body: Font {
        Font.custom("FZSSJW--GB1-0", size: 13.0)
    }

    /// Create a font with the callout text style.
    public static var callout: Font {
        Font.custom("FZSSJW--GB1-0", size: UIFont.preferredFont(forTextStyle: .callout).pointSize)
    }

    /// Create a font with the footnote text style.
    //public static var footnote: Font {
    //    Font.custom("FZSSJW--GB1-0", size: UIFont.preferredFont(forTextStyle: .footnote).pointSize)
    //}

    /// Create a font with the caption text style.
    public static var caption1: Font {
        Font.custom("FZSSJW--GB1-0", size: 15.0)
    }

    public static var caption2: Font {
        Font.custom("FZSSJW--GB1-0", size: UIFont.preferredFont(forTextStyle: .caption2).pointSize)
    }
    
    public static var chapterNumber: Font {
        Font.custom("FZSSJW--GB1-0", size: 20.0)
    }
    
    public static var chapterName: Font {
        Font.custom("FZSSJW--GB1-0", size: 25.0)
    }
    
    public static var selectedQuestionList: Font {
        Font.custom("FZSSJW--GB1-0", size: 25.0)
    }
    
    public static var unselectedQuestionList: Font {
        Font.custom("FZSSJW--GB1-0", size: 15.0)
    }
    
    public static var infoModalBody: Font {
        Font.custom("FZSSJW--GB1-0", size: 17.0)
    }
    
    public static var answerButtonText: Font {
        Font.custom("FZSSJW--GB1-0", size: 15.5)
    }
    
    public static var navigationNotice: Font {
        Font.custom("FZSSJW--GB1-0", size: 15.0)
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
