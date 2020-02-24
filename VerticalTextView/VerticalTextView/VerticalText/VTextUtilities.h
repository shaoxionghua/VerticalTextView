//
//  VTextUtilities.h
//  VerticalTextView
//
//  Created by shao xionghua on 2020/2/24.
//  Copyright © 2020 shao xionghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

static inline BOOL VTextCTFontContainsColorBitmapGlyphs(CTFontRef font) {
    return  (CTFontGetSymbolicTraits(font) & kCTFontTraitColorGlyphs) != 0;
}

static inline CGFloat VTextDegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180;
}


@interface VTextUtilities : NSObject


/**
 Get the character set which should rotate in vertical form.
 @return The shared character set.
 */
NSCharacterSet *VTextVerticalRotateCharacterSet(void);

/**
 Get the character set which should rotate and move in vertical form.
 @return The shared character set.
 */
NSCharacterSet *VTextVerticalRotateAndMoveCharacterSet(void);

@end
