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

typedef void(^UMHeightIncreaseHeightChange)(CGFloat newHeight);
typedef void(^UMHeightIncreaseTextChange)(NSString * text);
typedef void(^UMHeightIncreaseTextNumberChange)(NSUInteger textLength);

@interface UMHeightIncrease : UIView

@property (nonatomic, strong) YYTextView * textView;

/**
*  是否移除自定义辅助视图（默认未添加）
*/

@property (nonatomic, assign) BOOL isHiddenCustomInputAccessoryView;
/**
*  自定义辅助视图背景色 （前提isHiddenCustomInputAccessoryView = NO）
*/

@property (nonatomic, strong) UIColor *doneBgColor;
/**
*  自定义辅助视图按钮的颜色 （前提isHiddenCustomInputAccessoryView = NO）
*/
@property (nonatomic, strong) UIColor *doneTextColor;

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
 *  textView最大高度 一定要在初始化frame后设置否则会被重置
 */
@property (nonatomic, assign) NSUInteger maxHeight;
/**
 *  textView字数限制 表情占2个字数（黏贴超过长度字符会失败）
 *
 **/
@property (nonatomic, assign) NSUInteger maxNumberCharacter;

/**
 *  文字高度改变block → 文字高度改变会自动调用
 */
@property (nonatomic, copy) UMHeightIncreaseHeightChange viewHeightChangeBlock;
/**
*  文本改变
*/
@property (nonatomic, copy) UMHeightIncreaseTextChange viewTextChangeBlock;
/**
*  当前输入字符数
*/
@property (nonatomic, copy) UMHeightIncreaseTextNumberChange viewTextLengthChangeBlock;

/**
 *  设置圆角
 */
@property (nonatomic, assign) NSUInteger cornerRadius;

@property (nonatomic, strong) UIColor *cornerColor;

@property (nonatomic, assign) NSUInteger borderWidth;

/*
* 手动设置textView的文本
*/
@property (nonatomic, strong) NSString *text;

/*
 * 使用kvo观察这个属性来实时获取text
 */
@property (nonatomic, copy ,readonly)  NSString *realTimeChangedText;


@end

NS_ASSUME_NONNULL_END
