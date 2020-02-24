//
//  VTextLine.m
//  VerticalTextView
//
//  Created by shao xionghua on 2020/2/24.
//  Copyright © 2020 shao xionghua. All rights reserved.
//

#import "VTextLine.h"

@implementation VTextRunGlyphRange
+ (instancetype)rangeWithRange:(NSRange)range drawMode:(VTextRunGlyphDrawMode)mode {
    VTextRunGlyphRange *one = [self new];
    one.glyphRangeInRun = range;
    one.drawMode = mode;
    return one;
}
@end


@interface VTextLine(){
    CGFloat _firstGlyphPos;
}

@property (nonatomic, assign) CGFloat lineWidth;

@end

@implementation VTextLine

- (instancetype)initWithCTLine:(CTLineRef)ctLine position:(CGPoint)position vertical:(BOOL)vertical{
    self = [super init];
    if(self){
        _vertical = vertical;
        _position = position;
        [self setCtLine:ctLine];
    }
    return self;
}

- (void)setCtLine:(CTLineRef)ctLine{
    if(_ctLine != ctLine){
        if(_ctLine){
            CFRelease(_ctLine);
        }
        if (ctLine){
            CFRetain(ctLine);
        }
        _ctLine = ctLine;
        if(_ctLine){
            _lineWidth = CTLineGetTypographicBounds(_ctLine, &_ascent, &_descent, &_leading);
            CFRange range = CTLineGetStringRange(_ctLine);
            _range = NSMakeRange(range.location, range.length);
            if (CTLineGetGlyphCount(_ctLine) > 0) {
                CFArrayRef runs = CTLineGetGlyphRuns(_ctLine);
                CTRunRef run = CFArrayGetValueAtIndex(runs, 0);
                CGPoint pos;
                CTRunGetPositions(run, CFRangeMake(0, 1), &pos);
                _firstGlyphPos = pos.x;
            } else {
                _firstGlyphPos = 0;
            }
            _trailingWhitespaceWidth = CTLineGetTrailingWhitespaceWidth(_ctLine);
        } else {
            _lineWidth = _ascent = _descent = _leading = _firstGlyphPos = _trailingWhitespaceWidth = 0;
            _range = NSMakeRange(0, 0);
        }
        [self realoadBounds];
    }
}

- (void)realoadBounds{
    if (_vertical) {
        _bounds = CGRectMake(_position.x - _descent, _position.y, _ascent + _descent, _lineWidth);
        _bounds.origin.y += _firstGlyphPos;
    } else {
        _bounds = CGRectMake(_position.x, _position.y - _ascent, _lineWidth, _ascent + _descent);
        _bounds.origin.x += _firstGlyphPos;
    }
}

- (CGFloat)lineWidth{
    return CGRectGetWidth(self.bounds);
}

- (CGFloat)lineHeight{
    return CGRectGetHeight(self.bounds);
}

- (void)dealloc {
    if (_ctLine){
        CFRelease(_ctLine);
    }
}
@end
