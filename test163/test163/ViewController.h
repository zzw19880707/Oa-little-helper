//
//  ViewController.h
//  test163
//
//  Created by 佐筱猪 on 13-12-6.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate>

@property (retain, nonatomic) IBOutlet UIScrollView *mainScroll;
@property (retain, nonatomic) IBOutlet UIScrollView *titleScroll;

@end
