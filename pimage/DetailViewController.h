//
//  DetailViewController.h
//  pimage
//
//  Created by 佐藤凌馬 on 2014/11/01.
//  Copyright (c) 2014年 RyomaSato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic,assign) double select_num;//intからdoubleに変更11/1

@property (weak, nonatomic) IBOutlet UIImageView *dtlImageView;


@property(nonatomic,assign) NSString *documentKey;//1104
@property(nonatomic,assign) NSString *documentImageName;//1104


@end
