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

@property (nonatomic, copy ,readwrite)  NSString *realTimeChangedText;

@property (nonatomic, weak) UIButton *inputAccessoryViewButton;
/**
 *  完成按钮占位视图
 *
 */
@property (nonatomic, weak) UIView *customInputAccessoryView;

/**
 *UITextView作为placeholderView，使placeholderView等于UITextView的大小，字体重叠显示，方便快捷，解决占位符问题.
 */
@property (nonatomic, weak) UITextView *placeholderView;

/**
 *  文字高度
 */
@property (nonatomic, assign) NSInteger currentHeight;
/**
 *  是否是外部直接初始化一个值由于直接赋值会导致判断长度的时候出现问题
 *  由于YY里面的内部赋值的时候是先赋值后调用shouldChangeTextInRange判断
 */
@property (nonatomic, assign) BOOL isExternalVariable;

//是否是外部修改的frame而非初始化
@property (nonatomic, assign) BOOL isExternalUpdateFrame;

@property (nonatomic, assign) CGFloat minHeight;

@end
@implementation UMHeightIncrease

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews:frame];
    }
    return self;
}
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.textView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    if (!self.isExternalUpdateFrame) {
        self.maxHeight = frame.size.height;
        self.minHeight = frame.size.height;
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
}
- (void)initSubViews:(CGRect)frame {
    self.textView.scrollEnabled = NO;
    self.textView.scrollsToTop = NO;
    self.textView.showsHorizontalScrollIndicator = NO;
    self.textView.enablesReturnKeyAutomatically = YES;
    self.textView.delegate = self;
    [self addSubview:self.textView];
}
- (void)addCustomInputAccessoryView {
    __weak typeof(self)weakSelf = self;
   UIView *customInputAccessoryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 40)];
   UIButton *accesssoryButton = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 40 - 10, 0, 40, 40)];
   [accesssoryButton setTitle:@"完成" forState:UIControlStateNormal];
    [accesssoryButton setTitleColor:self.doneTextColor?self.doneTextColor:[UIColor blackColor] forState:UIControlStateNormal];
   [accesssoryButton addTarget:weakSelf.textView action:@selector(resignFirstResponder)forControlEvents:UIControlEventTouchUpInside];
   [customInputAccessoryView addSubview:accesssoryButton];
   customInputAccessoryView.backgroundColor = self.doneBgColor?self.doneBgColor:[UIColor grayColor];
    
   self.textView.inputAccessoryView = customInputAccessoryView;
   self.customInputAccessoryView = customInputAccessoryView;
   self.inputAccessoryViewButton = accesssoryButton;

}

- (void)textDidChange {
    
    self.realTimeChangedText = self.textView.text;
    
    if (self.viewTextChangeBlock) {
        self.viewTextChangeBlock(self.textView.text);
    }
    //当前文字高度
    NSInteger height = ceilf(self.textView.textLayout.textBoundingSize.height);
    if(self.minHeight == 0 || self.maxHeight == 0) {
        return;
    }
    _currentHeight = height > _maxHeight?_maxHeight:height;
    _currentHeight = _currentHeight > _minHeight ?_currentHeight:_minHeight;
    self.textView.scrollEnabled = height  > _currentHeight && _currentHeight > 0;
    if (_viewHeightChangeBlock&&self.textView.scrollEnabled == NO) {
        self.isExternalUpdateFrame = YES;
        _viewHeightChangeBlock(_currentHeight);
        self.isExternalUpdateFrame = NO;
        __weak typeof(self) weakself = self;
        [UIView animateWithDuration:0.25 animations:^{
            __strong typeof(weakself)strongSelf = weakself;
            CGRect frame = strongSelf.textView.frame;
            frame.size.height = strongSelf.currentHeight;
            strongSelf.textView.frame = frame;
        } completion:^(BOOL finished) {
            
        }];
        
    }
    if (_viewTextChangeBlock) {
        _viewTextChangeBlock(self.textView.text);
    }
    if (_viewTextLengthChangeBlock) {
        _viewTextLengthChangeBlock(self.textView.text.length);
    }
    
}


#pragma mark -- YYTextViewDelegate
- (BOOL)textViewShouldBeginEditing:(YYTextView *)textView {
    return YES;
}
- (BOOL)textViewShouldEndEditing:(YYTextView *)textView {
    return YES;
}
- (void)textViewDidBeginEditing:(YYTextView *)textView {
}
- (void)textViewDidEndEditing:(YYTextView *)textView {
}
- (BOOL)textView:(YYTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (self.maxNumberCharacter <= 0) {
        return YES;
    } else {
        if (self.isExternalVariable) {
            self.isExternalVariable = NO;
            if(text.length > self.maxNumberCharacter) {
                self.text = [text substringToIndex:self.maxNumberCharacter];
                return NO;
            }
            return YES;
        }
        if(range.length + range.location > self.textView.text.length)
        {
            return NO;
        }
        NSUInteger newLength = [self.textView.text length] + [text length] - range.length;
        return newLength <= self.maxNumberCharacter;
    }
}
- (void)textViewDidChange:(YYTextView *)textView {
    [self textDidChange];
}
- (void)textViewDidChangeSelection:(YYTextView *)textView {
}
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.textView.placeholderText = placeholder;
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    self.textView.placeholderTextColor = placeholderColor;
}
- (void)setPlaceholderFontValue:(UIFont *)placeholderFontValue {
    _placeholderFontValue = placeholderFontValue;
    self.textView.placeholderFont = placeholderFontValue;
}
- (void)setMaxHeight:(NSUInteger)maxHeight {
    _maxHeight = maxHeight;
}

- (void)setContentFontValue:(UIFont *)contentFontValue {
    _contentFontValue = contentFontValue;
    self.textView.font = contentFontValue;
}
- (void)setContentInsetValue:(UIEdgeInsets)contentInsetValue {
    _contentInsetValue = contentInsetValue;
    self.textView.textContainerInset = contentInsetValue;
}
- (void)setCornerRadius:(NSUInteger)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}
- (void)setBorderWidth:(NSUInteger)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}
- (void)setCornerColor:(UIColor *)cornerColor {
    _cornerColor = cornerColor;
    self.layer.borderColor = cornerColor.CGColor;
}
- (void)setText:(NSString *)text {
    self.isExternalVariable = YES;
    self.textView.text = text;
}
- (NSString *)text {
    return self.textView.text;
}
- (YYTextView *)textView {
    if(_textView) return _textView;
    _textView = [[YYTextView alloc]init];
    return _textView;
}

- (void)setIsHiddenCustomInputAccessoryView:(BOOL)isHiddenCustomInputAccessoryView {
    _isHiddenCustomInputAccessoryView = isHiddenCustomInputAccessoryView;
    if (_isHiddenCustomInputAccessoryView) {
        self.textView.inputAccessoryView = nil;
    } else {
        [self addCustomInputAccessoryView];
    }
}
- (void)setDoneBgColor:(UIColor *)doneBgColor {
    _doneBgColor = doneBgColor;
    self.customInputAccessoryView.backgroundColor = doneBgColor;
}
- (void)setDoneTextColor:(UIColor *)doneTextColor {
    _doneTextColor = doneTextColor;
    [self.inputAccessoryViewButton setTitleColor:doneTextColor forState:UIControlStateNormal];
}
@end
