//
//  VTextView.m
//  VerticalTextView
//
//  Created by shao xionghua on 2020/2/24.
//  Copyright © 2020 shao xionghua. All rights reserved.
//

#import "VTextView.h"
#import "VTextLayout.h"

@interface VTextView ()

@property (nonatomic, strong) VTextLayout *textLayout;

@end

@implementation VTextView

- (void)drawRect:(CGRect)rect{
    [self.textLayout drawInContext:UIGraphicsGetCurrentContext() size:self.bounds.size];
}

- (void)setAttString:(NSAttributedString *)attString{
    
    _attString = attString;
    [self updateLayout];
}


- (void)updateLayout{
    
    //计算文本 在布局之后的 范围
    self.textLayout = [[VTextLayout alloc] initWithText:self.attString vertical:self.isVertical size:self.size];
    
    //每次排版之后，要重设view的大小
    self.frame = CGRectMake(0, 0, self.textLayout.textBoundingSize.width, self.textLayout.textBoundingSize.height);
    
    NSLog(@"显示的字符长度：%ld",self.textLayout.showedIndex);
    self.showStr = [_attString.string  substringToIndex:self.textLayout.showedIndex];//（length为7）
    self.showStrlen =self.textLayout.showedIndex;
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (CGSize)textBoundingSize{
    
    return self.textLayout.textBoundingSize;
}


#pragma mark -- Getter and Setter
- (void)setTextAlignment:(int)textAlignment{
    if(self.textLayout.textAlignment != textAlignment){
        self.textLayout.textAlignment = textAlignment;
        [self setNeedsDisplay];
    }
}

- (void)setIsVertical:(BOOL)isVertical{
    
    if(isVertical != _isVertical){
        _isVertical = isVertical;
        [self updateLayout];
    }
}

- (void)setSize:(CGSize )size{
    _size = size;
}

@end
