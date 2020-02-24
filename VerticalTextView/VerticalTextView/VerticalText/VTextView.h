//
//  VTextView.h
//  VerticalTextView
//
//  Created by shao xionghua on 2020/2/24.
//  Copyright © 2020 shao xionghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VTextView : UIView

@property (nonatomic, strong) NSAttributedString *attString;

@property (nonatomic, assign) BOOL isVertical;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) NSInteger showStrlen;

@property (nonatomic, copy) NSString *showStr;

- (CGSize)textBoundingSize;

- (void)setTextAlignment:(int)textAlignment;

@end

