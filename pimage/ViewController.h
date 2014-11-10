//
//  ViewController.h
//  pimage
//
//  Created by 佐藤凌馬 on 2014/10/30.
//  Copyright (c) 2014年 RyomaSato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *documentListTableView;

@end

