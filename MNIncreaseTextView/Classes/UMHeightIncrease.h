//
//  UMHeightIncrease.h
//  UmerAI
//
//  Created by umer on 2019/3/7.
//  Copyright © 2019年 Umer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYTextView;

NS_ASSUME_NONNULL_BEGIN

typedef void(^MN_textHeightChangedBlock)(NSString *text,CGFloat textHeight);

@interface UMHeightIncrease : UIView
@property (nonatomic, strong) YYTextView * textView;
/**
 *  完成按钮占位视图
 *
 */
@property (nonatomic, weak) UIView *customInputAccessoryView;

/**
 *  占位文字
 */
@property (nonatomic, strong) NSString *placeholder;

/**
 *  占位文字颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;

/**
 *  占位符字体大小
 */
@property (nonatomic,strong) UIFont *placeholderFontValue;

/**
 *  内容字体大小
 */
@property (nonatomic,strong) UIFont *contentFontValue;


/**
 *  内容内边距
 */
@property (nonatomic,assign) UIEdgeInsets contentInsetValue;

/**
 *  textView最大高度
 */
@property (nonatomic, assign) NSUInteger maxNumberOfHeight;
/**
 *  textView最小高度
 */
@property (nonatomic, assign) NSUInteger minNumberOfHeight;
/**
 *  textView字数限制 表情占2个字数（黏贴超过长度字符会失败）
 *
 **/
@property (nonatomic, assign) NSUInteger maxNumberOfChinaCharacter;

/**
 *  文字高度改变block → 文字高度改变会自动调用
 *  block参数(text) → 文字内容
 *  block参数(textHeight) → 文字高度
 */
@property (nonatomic, copy) MN_textHeightChangedBlock textChangedBlock;
/**
 *  设置圆角
 */
@property (nonatomic, assign) NSUInteger cornerRadius;

@property (nonatomic, strong) NSString * text;

- (void)textValueDidChanged:(MN_textHeightChangedBlock)block;

@end

NS_ASSUME_NONNULL_END
