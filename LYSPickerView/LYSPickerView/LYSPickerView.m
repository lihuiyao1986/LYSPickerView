//
//  LYSPickerView.m
//  LYSPickerView
//
//  Created by jk on 2017/4/13.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "LYSPickerView.h"

@interface LYSPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    CGFloat _toolbarH;
    CGFloat _pickerH;
}

@property(nonatomic,strong)UIPickerView *pickerView;

@property(nonatomic,strong)UIView *containerView;

@property(nonatomic,strong)UIView *toolBar;

@property(nonatomic,strong)UIButton *leftBtn;

@property(nonatomic,strong)UIButton *rightBtn;

@end

static NSTimeInterval duration = 0.35;

@implementation LYSPickerView

#pragma mark - 初始化方法
- (instancetype)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self initConfig];
    }
    return self;
}


#pragma mark - 初始化配置
-(void)initConfig{
    
    self.backgroundColor = [self colorWithHexString:@"000000" alpha:0.4];
    
    [self setDefaults];
    
    [self setupUI];
}

#pragma mark - 创建ui
-(void)setupUI{
    [self.toolBar addSubview:self.leftBtn];
    [self.toolBar addSubview:self.rightBtn];
    [self.containerView addSubview:self.toolBar];
    [self.containerView addSubview:self.pickerView];
    [self addSubview:self.containerView];
}

#pragma mark - toolBar
-(UIView*)toolBar{
    if (!_toolBar) {
        _toolBar = [UIView new];
        _toolBar.backgroundColor = [self colorWithHexString:@"ffffff" alpha:1.0];
        _toolBar.layer.borderWidth = 0.5;
        _toolBar.layer.borderColor = [self colorWithHexString:@"e3e2e2" alpha:1.0].CGColor;
    }
    return _toolBar;
}

-(void)setItems:(NSArray *)items{
    _items = items;
    [self.pickerView reloadAllComponents];
}

-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    if (_selectedIndex!=-1 && _selectedIndex > 0 && _selectedIndex <= self.items.count) {
        [self.pickerView selectRow:selectedIndex inComponent:0 animated:YES];
    }
}

#pragma mark - 代理方法

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.items.count;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return CGRectGetWidth(self.frame);
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return self.itemH;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _selectedIndex = row;
}

-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemForView:atIndex:itemH:withView:reuseView:)]) {
        return [self.delegate itemForView:self.items[row] atIndex:row itemH:self.itemH withView:self reuseView:view];
    }else{
        return view;
    }
}

#pragma mark - 设置默认
-(void)setDefaults{
    _toolbarH = 44.f;
    _pickerH = 216.f;
    _itemH = 44.f;
    _selectedIndex = -1;
    _leftBtnTitle = @"取消";
    _rightBtnTitle = @"确定";
    _dismissTouchOutside = YES;
    _btnFontColor = [self colorWithHexString:@"1686D5" alpha:1.0];
}


-(void)setLeftBtnTitle:(NSString *)leftBtnTitle{
    _leftBtnTitle = leftBtnTitle;
    [_leftBtn setTitle:self.leftBtnTitle forState:UIControlStateNormal];
    [_leftBtn setTitle:self.leftBtnTitle forState:UIControlStateHighlighted];
}

-(void)setRightBtnTitle:(NSString *)rightBtnTitle{
    _rightBtnTitle = rightBtnTitle;
    [_rightBtn setTitle:self.rightBtnTitle forState:UIControlStateNormal];
    [_rightBtn setTitle:self.rightBtnTitle forState:UIControlStateHighlighted];
}

-(void)setBtnFontColor:(UIColor *)btnFontColor{
    _btnFontColor = btnFontColor;
    [_leftBtn setTitleColor:self.btnFontColor forState:UIControlStateNormal];
    [_leftBtn setTitleColor:self.btnFontColor forState:UIControlStateHighlighted];
    [_rightBtn setTitleColor:self.btnFontColor forState:UIControlStateNormal];
    [_rightBtn setTitleColor:self.btnFontColor forState:UIControlStateHighlighted];
}

#pragma mark - monthPicker
-(UIPickerView*)pickerView{
    if (!_pickerView) {
        _pickerView = [UIPickerView new];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor clearColor];
    }
    return _pickerView;
}

#pragma mark - 
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    CGPoint point = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(self.containerView.frame, point)) {
        if (self.dismissTouchOutside) {
            [self dismiss:nil];
        }
    }
}

#pragma mark - 左按钮
-(UIButton*)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setTitle:self.leftBtnTitle forState:UIControlStateNormal];
        [_leftBtn setTitle:self.leftBtnTitle forState:UIControlStateHighlighted];
        [_leftBtn setTitleColor:self.btnFontColor forState:UIControlStateNormal];
        [_leftBtn setTitleColor:self.btnFontColor forState:UIControlStateHighlighted];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [_leftBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

#pragma mark - 右按钮
-(UIButton*)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:self.rightBtnTitle forState:UIControlStateNormal];
        [_rightBtn setTitle:self.rightBtnTitle forState:UIControlStateHighlighted];
        [_rightBtn setTitleColor:self.btnFontColor forState:UIControlStateNormal];
        [_rightBtn setTitleColor:self.btnFontColor forState:UIControlStateHighlighted];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _rightBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
        [_rightBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

#pragma mark - 按钮被点击
-(void)btnClicked:(UIButton*)sender{
    if(sender == _leftBtn){
        [self dismiss:nil];
    }else{
        __weak typeof (self)MyWeakSelf = self;
        [self dismiss:^{
            if (MyWeakSelf.delegate && [MyWeakSelf.delegate respondsToSelector:@selector(itemSelectedAtIndex:item:withView:)] && self.selectedIndex != -1) {
                [MyWeakSelf.delegate itemSelectedAtIndex:self.selectedIndex item:self.items[self.selectedIndex] withView:self];
            }
        }];
    }
}

#pragma mark - layoutSubviews
-(void)layoutSubviews{
    [super layoutSubviews];
    self.containerView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - (_toolbarH + _pickerH), CGRectGetWidth(self.frame), _toolbarH + _pickerH);
    self.toolBar.frame = CGRectMake(-1 , 0, CGRectGetWidth(self.frame) + 2, _toolbarH);
    self.pickerView.frame = CGRectMake(0, CGRectGetMaxY(self.toolBar.frame), CGRectGetWidth(self.frame), _pickerH);
    self.leftBtn.frame = CGRectMake(0, 0, 60.f, _toolbarH);
    self.rightBtn.frame = CGRectMake(CGRectGetWidth(self.toolBar.frame) - 60, 0, 60, _toolbarH);
}

#pragma mark - 格式化日期
-(NSString*)formatDate:(NSDate*)date format:(NSString*)format{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    return [formatter stringFromDate:date];
}

#pragma mark - 内容视图
-(UIView*)containerView{
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.backgroundColor = [self colorWithHexString:@"ffffff" alpha:1.0];
    }
    return _containerView;
}

#pragma mark - 显示
-(void)showInView:(UIView*)targetView{
    if (!targetView){
        targetView = [UIApplication sharedApplication].keyWindow;
    }
    [targetView addSubview:self];
    __block CGRect containerViewFrame = self.containerView.frame;
    containerViewFrame.origin.y = CGRectGetHeight(self.frame);
    self.containerView.frame = containerViewFrame;
    __weak typeof (self)MyWeakSelf = self;
    self.alpha = 0;
    [UIView animateWithDuration:duration animations:^{
        MyWeakSelf.alpha = 1.0;
        containerViewFrame.origin.y = CGRectGetHeight(MyWeakSelf.frame) - (_toolbarH  + _pickerH);
        MyWeakSelf.containerView.frame = containerViewFrame;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 显示
-(void)show{
    [self showInView:nil];
}


#pragma mark - 隐藏
-(void)dismiss:(void(^)())finishBlock{
    __weak typeof (self)MyWeakSelf = self;
    __block CGRect containerViewFrame = self.containerView.frame;
    [UIView animateWithDuration:duration animations:^{
        MyWeakSelf.alpha = 0;
        containerViewFrame.origin.y = CGRectGetHeight(MyWeakSelf.frame);
        MyWeakSelf.containerView.frame = containerViewFrame;
    } completion:^(BOOL finished) {
        if (finishBlock) {
            finishBlock();
        }
        [MyWeakSelf removeFromSuperview];
    }];
}

#pragma mark - 生成16进制颜色
-(UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}


@end
