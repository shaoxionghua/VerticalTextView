//
//  VTextLine.h
//  VerticalTextView
//
//  Created by shao xionghua on 2020/2/24.
//  Copyright © 2020 shao xionghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

typedef NS_ENUM(NSUInteger, VTextRunGlyphDrawMode) {
    /// No rotate.
    VTextRunGlyphDrawModeHorizontal = 0,
    
    /// Rotate vertical for single glyph.
    VTextRunGlyphDrawModeVerticalRotate = 1,
    
    /// Rotate vertical for single glyph, and move the glyph to a better position,
    /// such as fullwidth punctuation.
    VTextRunGlyphDrawModeVerticalRotateMove = 2,
};


/**
 A range in CTRun, used for vertical form.
 */
@interface VTextRunGlyphRange : NSObject
@property (nonatomic) NSRange glyphRangeInRun;
@property (nonatomic) VTextRunGlyphDrawMode drawMode;
+ (instancetype)rangeWithRange:(NSRange)range drawMode:(VTextRunGlyphDrawMode)mode;
@end


@interface VTextLine : NSObject

@property (nonatomic, readonly) CTLineRef ctLine;

@property (nonatomic, readonly) NSRange range;

@property (nonatomic, readonly) CGPoint position;

@property (nonatomic, readonly) BOOL vertical;

@property (nonatomic, readonly) CGRect bounds;

@property (nonatomic, readonly) CGFloat ascent;

@property (nonatomic, readonly) CGFloat descent;

@property (nonatomic, readonly) CGFloat leading;

@property (nonatomic, readonly) CGFloat trailingWhitespaceWidth;

@property (nonatomic, readonly) CGFloat lineHeight;

@property (nonatomic, readonly) CGFloat lineWidth;

- (instancetype)initWithCTLine:(CTLineRef)ctLine position:(CGPoint)position vertical:(BOOL)vertical;

@property (nonatomic, strong) NSMutableArray *verticalTextRange;

@end

