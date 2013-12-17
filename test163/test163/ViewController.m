//
//  ViewController.m
//  test163
//
//  Created by 佐筱猪 on 13-12-6.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "ViewController.h"
#import "UIViewExt.h"
@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            self.title =@"东北新闻网";
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleScroll.contentSize = CGSizeMake(320*2, 50);
    int _x=0;
    for (int i=0 ; i<6; i++){
        UIButton *button = [[UIButton alloc] init];
        
        [button setTitle:[NSString stringWithFormat:@"button%d",i] forState:UIControlStateNormal];
        [button setTitle:[NSString stringWithFormat:@"select%d",i] forState:UIControlStateSelected];
        
        [button setTitle:[NSString stringWithFormat:@"select%d",i] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button.backgroundColor= [UIColor whiteColor];
        button.frame = CGRectMake(10+_x, 90/2-60/2,90, 60);
        [button addTarget:self action:@selector(testAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=100+i;
        [self.titleScroll addSubview:button];
        [button release];
        _x+=110;
    }
    self.titleScroll.tag =1000;
    self.titleScroll.showsHorizontalScrollIndicator= NO;
    self.mainScroll.contentSize = CGSizeMake(340 *6, 350);
    self.mainScroll.pagingEnabled = YES;
    self.mainScroll.showsHorizontalScrollIndicator = NO;
    self.mainScroll.showsVerticalScrollIndicator = NO;
    int _tx=0;
    for (int i = 0 ; i<6; i++) {
        UILabel *label =[[UILabel alloc]init];
        label.frame = CGRectMake(10 +_tx, 0,320 , 350);
        label.text = [NSString stringWithFormat:@"label--->%d",i];
        label.backgroundColor = [UIColor blackColor];
        label.textColor =[UIColor redColor];
        [self.mainScroll addSubview:label];
        [label release];
        _tx +=340;
    }
    self.mainScroll.delegate =self;
    self.mainScroll.tag=1001;
    self.mainScroll.contentInset = UIEdgeInsetsMake(0, 10, 0, 0);
    NSLog(@"%@",[self.mainScroll subviews]);
}
-(void)testAction:(UIButton *)button{
    button.selected = YES;
    NSLog(@"tag->%d",button.tag);
//    CGPoint point =CGPointMake(, <#CGFloat y#>)
    NSLog(@"偏移量->%f", self.mainScroll.contentOffset.x /340);
    int count =(button.tag -100)*340;
    CGPoint point =self.mainScroll.contentOffset;
    point.x =count;
    self.mainScroll.contentOffset =point;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_mainScroll release];
    [_titleScroll release];
    [super dealloc];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndDecelerating");
    int count = scrollView.contentOffset.x/340;
    UIButton *button =(UIButton *) [self.titleScroll viewWithTag:(count+100)];
    button.selected =YES;
    for (int i =0; i<6 ; i++) {
        UIButton *otherButton =(UIButton *) [self.titleScroll viewWithTag:(i+100)];

        if (i !=count) {
//            otherButton.titleLabel.text = [NSString stringWithFormat:@"button%d",i];
            otherButton.selected = NO;
        }
    }
    if(count*110<320+110){
        [self.titleScroll setContentOffset:CGPointMake(count*110,0) animated:YES];
    }
}


//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    //偏移量
//    float offset=scrollView.contentOffset.x;
//    float contentHeight=scrollView.contentSize.width;
//    NSLog(@"偏移量y:%f",offset);
//    NSLog(@"content高度%f",contentHeight);
//    //当offset偏移量滑到底部时，差值是scrollView的高度
//    float sub=contentHeight-offset;
//    if(scrollView.width-sub>160){
//        NSLog(@"123");
//    }
//}

@end
