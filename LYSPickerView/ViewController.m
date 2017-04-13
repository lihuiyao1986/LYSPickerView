//
//  ViewController.m
//  LYSPickerView
//
//  Created by jk on 2017/4/13.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "ViewController.h"
#import "LYSPickerView.h"

@interface ViewController ()<LYSPickerViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 120, self.view.bounds.size.width, 44);
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    [btn setTitle:@"开始" forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    // Do any additional setup after loading the view, typically from a nib.
}


-(void)btnClicked:(UIButton*)sender{
    
    
    LYSPickerView *picker = [LYSPickerView new];
    picker.delegate = self;
    picker.items = @[@{@"title":@"C++"},@{@"title":@"JAVA"},@{@"title":@".Net"},@{@"title":@"PHP"}];
    picker.selectedIndex = 1;
    [picker show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView*)itemForView:(NSDictionary*)item atIndex:(NSUInteger)index itemH:(CGFloat)itemH withView:(LYSPickerView*)view reuseView:(UIView *)reuseView{
    UILabel *label = (UILabel*)reuseView;
    if (!label) {
        label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, view.frame.size.width - 40, itemH)];
        label.textColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        label.font = [UIFont systemFontOfSize:16];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        //label.backgroundColor = [UIColor greenColor];
    }
    label.text = [item objectForKey:@"title"];
    return label;
}

-(void)itemSelectedAtIndex:(NSUInteger)index item:(NSDictionary*)item withView:(LYSPickerView *)view{
    NSLog(@"you picked item %@",item);
}


@end
