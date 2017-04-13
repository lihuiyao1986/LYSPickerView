//
//  LYSPickerView.h
//  LYSPickerView
//
//  Created by jk on 2017/4/13.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYSPickerView;

@protocol LYSPickerViewDelegate <NSObject>

@optional

-(UIView*)itemForView:(NSDictionary*)item atIndex:(NSUInteger)index itemH:(CGFloat)itemH withView:(LYSPickerView*)view reuseView:(UIView*)reuseView;

-(void)itemSelectedAtIndex:(NSUInteger)index item:(NSDictionary*)item withView:(LYSPickerView*)view;

@end

@interface LYSPickerView : UIView

#pragma mark - 按钮的字体颜色
@property(nonatomic,strong)UIColor *btnFontColor;

#pragma mark - 左按钮的标题
@property(nonatomic,copy)NSString *leftBtnTitle;

#pragma mark - 右按钮的标题
@property(nonatomic,copy)NSString *rightBtnTitle;

#pragma mark - 数据源
@property(nonatomic,copy)NSArray *items;

#pragma mark - item高度
@property(nonatomic,assign)CGFloat itemH;

#pragma mark - 点击外面是否消失
@property(nonatomic,assign)BOOL dismissTouchOutside;

#pragma mark - 选中操作
@property(nonatomic,weak)id<LYSPickerViewDelegate>delegate;

#pragma mark - 选中索引
@property(nonatomic,assign)NSUInteger selectedIndex;

#pragma mark - 显示
-(void)show;

#pragma mark - 显示
-(void)showInView:(UIView*)targetView;

@end
