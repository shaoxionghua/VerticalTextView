//
//  ViewController.m
//  VerticalTextView
//
//  Created by shao xionghua on 2020/2/24.
//  Copyright © 2020 shao xionghua. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
#import "VTextView.h"

@interface ViewController ()

@property (nonatomic, strong) VTextView *boundView;

@property (nonatomic, assign) CGFloat spacing;

@property (nonatomic, assign) CGFloat kern;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.spacing = 2;//行间距
    self.kern = 3;//字间距
    
    //直接使用FOTextView
    //第一种不需要换行显示的

    self.boundView = [[VTextView alloc] init];
    //*****************************************************************//
  //  self.boundView.size = CGSizeMake(375, 180);//指定显示区域  如果不传该参数则返回自适应的宽和高  设置该参数文字显示只有该区域的长度  可能显示不完整所有的字符
    //*****************************************************************//
    NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:@"先帝创业未半而中道崩殂，\n今天下三分，益州疲弊，\n此诚危急存亡之秋也。\n然侍卫之臣不懈于内，\n忠志之士忘身于外者，\n盖追先帝之殊遇，\n欲报之于陛下也。\n诚宜开张圣听，\n以光先帝遗德，\n恢弘志士之气，\n不宜妄自菲薄，引喻失义，以塞忠谏之路也。\n宫中府中，俱为一体，陟罚臧否，不宜异同\n若有作奸犯科及为忠善者，\n宜付有司论其刑赏，\n以昭陛下平明之理，不宜偏私，使内外异法也。"];
    //构造富文本信息
    NSAttributedString* result = [self buildAttrString:string1.string withFont:@"Copperplate-Light" fontSize:13
                                             lineSpace:2 kern:self.kern fontColor:[UIColor blackColor] delLine:NO];
    self.boundView.isVertical = YES;
    [self.boundView setAttString:result];
    [self.view addSubview:self.boundView];
    
    self.boundView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.boundView.center = self.view.center;
    
//    //第二种需要换行显示的
//    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:@"《12》\n东皋嘉😈🤓🙄雨新痕涨,\n我们sweet我的世界\n我们一起快乐的玩吃鸡\n《出师表》\n先帝创业未半而中道崩殂，今天下三分，益州疲弊，此诚危急存亡之秋也。\n然侍卫之臣不懈于内，\n忠志之士忘身于外者，\n😈🤓🙄盖追先帝之殊遇，\n欲报之于陛下也13666668888\n😈🤓🙄😈🤓🙄😈🤓🙄😈先帝创业未半而中道崩殂，今天下三分，益州疲弊，此诚危急存亡之秋也。先帝创业未半而中道崩殂，今天下三分，益州疲弊，此诚危急存亡之秋也。先帝创业未半而中道崩殂，今天下三分，益州疲弊，此诚危急存亡之秋也。先帝创业未半而中道崩殂，今天下三分，益州疲弊，此诚危急存亡之秋也。"];
//
//
//    NSInteger len = 0;
//    NSString *lastString = string2.string;
//    for (int i = 0; i<10000; i++) {
//        VTextView *boundView = [[VTextView alloc] init];
//        boundView.size = CGSizeMake(375, 180);
//        NSAttributedString* result = [self buildAttrString:lastString withFont:@"PingFangSC-Regular" fontSize:16
//                                                 lineSpace:self.spacing kern:self.kern fontColor:[UIColor blackColor] delLine:NO];
//        boundView.isVertical = YES;
//        [boundView setAttString:result];
//        [self.view addSubview:boundView];
//        boundView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
//        boundView.frame = CGRectMake(20, 180*i+50, 375, 180);
//        len =boundView.showStrlen;
//        lastString  = [lastString substringWithRange:NSMakeRange(boundView.showStrlen, lastString.length-boundView.showStrlen)];
//        if (lastString.length ==0) {
//            break;
//        }
//    }
    
}



- (NSMutableAttributedString *)buildAttrString:(NSString *)content
                                      withFont:(NSString *)fontName
                                      fontSize:(CGFloat)fontSize
                                     lineSpace:(CGFloat)lineSpace
                                          kern:(CGFloat)kernValue
                                     fontColor:(UIColor *)textColor
                                       delLine:(BOOL)delLine
{
    
    
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)fontName, fontSize, NULL);
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]
                                            initWithString:content
                                            attributes:
                                            @{
                                              (NSString *)kCTFontAttributeName : (__bridge id)fontRef,
                                              (NSString *)kCTForegroundColorAttributeName :(id)textColor.CGColor
                                              }];

    
    
    //line break
    CTParagraphStyleSetting lineBreakMode;
    CTLineBreakMode lineBreak = kCTLineBreakByWordWrapping; //换行模式
    lineBreakMode.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakMode.value = &lineBreak;
    lineBreakMode.valueSize = sizeof(CTLineBreakMode);
    //行间距
    CTParagraphStyleSetting LineSpacing;
    CGFloat spacing = lineSpace;  //指定间距
    LineSpacing.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
    LineSpacing.value = &spacing;
    LineSpacing.valueSize = sizeof(CGFloat);

    CTParagraphStyleSetting settings[] = {lineBreakMode,LineSpacing};
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, 2);   //第二个参数为settings的长度
    [attString addAttribute:(NSString *)kCTParagraphStyleAttributeName
                      value:(__bridge id)paragraphStyle
                      range:NSMakeRange(0, attString.length)];
    
    if(kernValue != 0){
        [attString addAttribute:NSKernAttributeName
                                 value:[NSNumber numberWithFloat:kernValue]
                                 range:NSMakeRange(0, [attString length])];
    }
    if (delLine){
        NSNumber *underline = [NSNumber numberWithInt:kCTTextAlignmentCenter];
        [attString addAttribute:(id)kCTUnderlineStyleAttributeName value:underline range:NSMakeRange(0, attString.length) ];
    }
    return attString;
}

@end
