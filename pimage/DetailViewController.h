//
//  DetailViewController.h
//  pimage
//
//  Created by 佐藤凌馬 on 2014/11/01.
//  Copyright (c) 2014年 RyomaSato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic,assign) double select_num;//intからdoubleに変更11/1

@property(nonatomic,assign) NSDictionary *documentImageList;//1113

@property(nonatomic,assign) NSString *documentDataKey;//1127

@end
