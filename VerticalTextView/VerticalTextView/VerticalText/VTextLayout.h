//
//  VTextLayout.h
//  VerticalTextView
//
//  Created by shao xionghua on 2020/2/24.
//  Copyright © 2020 shao xionghua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

typedef NS_ENUM(NSInteger,VTextAlignment) {
    VTextAlignmentLeft,
    VTextAlignmentCenter,
    VTextAlignmentRight
};

@interface VTextLayout : NSObject

@property (nonatomic, assign) BOOL vertical;

@property (nonatomic, strong, readonly) NSAttributedString *text;

@property (nonatomic, assign, readonly) CGRect textBoundingRect;

@property (nonatomic, assign, readonly) CGSize textBoundingSize;

@property (nonatomic, assign) VTextAlignment textAlignment;

@property (nonatomic, assign) NSInteger showedIndex;



- (instancetype)initWithText:(NSAttributedString*)text vertical:(BOOL)vertical size:(CGSize)size;

- (void)drawInContext:(CGContextRef)context size:(CGSize)size;


@end

