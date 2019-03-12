//
//  UMHeightIncrease.m
//  UmerAI
//
//  Created by umer on 2019/3/7.
//  Copyright © 2019年 Umer. All rights reserved.
//

#import "UMHeightIncrease.h"
#import "YYTextView.h"
@interface UMHeightIncrease()<YYTextViewDelegate>
/**
 *  UITextView作为placeholderView，使placeholderView等于UITextView的大小，字体重叠显示，方便快捷，解决占位符问题.
 */
@property (nonatomic, weak) UITextView *placeholderView;

/**
 *  文字高度
 */
@property (nonatomic, assign) NSInteger textH;

/**
 *  文字最大高度
 */
@property (nonatomic, assign) NSInteger maxTextH;
/**
 *  是否是外部直接初始化一个值由于直接赋值会导致判断长度的时候出现问题
 *  由于YY里面的内部赋值的时候是先赋值后调用shouldChangeTextInRange判断
 */
@property (nonatomic, assign) BOOL isExternalVariable;

@end
@implementation UMHeightIncrease

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initSubViews:frame];
    }
    return self;
}
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.textView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}
- (void)initSubViews:(CGRect)frame
{
    self.textView.scrollEnabled = NO;
    self.textView.scrollsToTop = NO;
    self.textView.showsHorizontalScrollIndicator = NO;
    self.textView.enablesReturnKeyAutomatically = YES;
    self.textView.delegate = self;
    [self addSubview:self.textView];
}

- (void)textDidChange{
    
    NSInteger height = ceilf(self.textView.textLayout.textBoundingSize.height);
    if(self.maxTextH == 0 || self.maxNumberOfLines == 0){
        return;
    }
    if (_textH != height) { // 高度不一样，就改变了高度
        // 当高度大于最大高度时，需要滚动
        self.textView.scrollEnabled = height  > _maxTextH && _maxTextH > 0;
        // 限制最小高度
        _textH = (height > _minNumberOfHeight?height:_minNumberOfHeight);
        //当不可以滚动（即 <= 最大高度）时，传值改变textView高度
        if (_textChangedBlock && self.textView.scrollEnabled == NO) {
            _textChangedBlock(self.textView.text,_textH);
            __weak typeof(self) weakself = self;
            [UIView animateWithDuration:0.25 animations:^{
                __strong typeof(weakself)strongSelf = weakself;
                CGRect frame = strongSelf.textView.frame;
                frame.size.height = strongSelf.textH;
                strongSelf.textView.frame = frame;
            } completion:^(BOOL finished) {
                
            }];
            
        }
    }
//    [self.textView scrollRangeToVisible:self.textView.selectedRange];
}


#pragma mark -- YYTextViewDelegate
- (BOOL)textViewShouldBeginEditing:(YYTextView *)textView{
//    MNPrintFileInfo;
    return YES;
}
- (BOOL)textViewShouldEndEditing:(YYTextView *)textView{
//    MNPrintFileInfo;
    return YES;
}
- (void)textViewDidBeginEditing:(YYTextView *)textView{
//    MNPrintFileInfo;
}
- (void)textViewDidEndEditing:(YYTextView *)textView{
//    MNPrintFileInfo;
}
- (BOOL)textView:(YYTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (self.maxNumberOfChinaCharacter <= 0) {
        return YES;
    }else{
        if(range.length + range.location > self.textView.text.length)
        {
            return NO;
        }
        if (self.isExternalVariable) {
            self.isExternalVariable = NO;
            return YES;
        }
        NSUInteger newLength = [self.textView.text length] + [text length] - range.length;
        return newLength <= self.maxNumberOfChinaCharacter;
    }
//    MNPrintFileInfo;
//    NSLog(@"%@",text);
    
}
- (void)textViewDidChange:(YYTextView *)textView{
//    MNPrintFileInfo;
//    NSLog(@"%@",textView.text);
    [self textDidChange];
}
- (void)textViewDidChangeSelection:(YYTextView *)textView{
//    MNPrintFileInfo;
}
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.textView.placeholderText = placeholder;
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    self.textView.placeholderTextColor = placeholderColor;
}
- (void)setPlaceholderFontValue:(UIFont *)placeholderFontValue{
    _placeholderFontValue = placeholderFontValue;
    self.textView.placeholderFont = placeholderFontValue;
}

- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines{
    _maxNumberOfLines = maxNumberOfLines;
    _maxTextH = ceil(self.textView.font.lineHeight * maxNumberOfLines + self.textView.textContainerInset.top + self.textView.textContainerInset.bottom);
}
- (void)setContentFontValue:(UIFont *)contentFontValue{
    _contentFontValue = contentFontValue;
    self.textView.font = contentFontValue;
}
- (void)setContentInsetValue:(UIEdgeInsets)contentInsetValue{
    _contentInsetValue = contentInsetValue;
    self.textView.textContainerInset = contentInsetValue;
}
- (void)setCornerRadius:(NSUInteger)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.textView.layer.cornerRadius = cornerRadius;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
}
- (void)textValueDidChanged:(MN_textHeightChangedBlock)block{
    
    _textChangedBlock = block;
    
}
- (void)setText:(NSString *)text{
    self.isExternalVariable = YES;
    self.textView.text = text;
}
- (NSString *)text{
    return self.textView.text;
}
- (YYTextView *)textView{
    if(_textView) return _textView;
    _textView = [[YYTextView alloc]init];
    return _textView;
}
@end
