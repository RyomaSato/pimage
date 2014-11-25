//
//  ImageViewController.h
//  pimage
//
//  Created by 佐藤凌馬 on 2014/11/24.
//  Copyright (c) 2014年 RyomaSato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController

//@property (nonatomic,assign) NSInteger num;

@property(nonatomic,retain) UIImage *ivc_image;//1124
@property (nonatomic, retain) NSData *ivc_data;//1124
@property(nonatomic,retain) NSString *ivc_fileName;//1124
@property(nonatomic,retain) NSString *ivc_imageSavePath;//1124


@end
