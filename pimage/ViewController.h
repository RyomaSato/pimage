//
//  ViewController.h
//  pimage
//
//  Created by 佐藤凌馬 on 2014/10/30.
//  Copyright (c) 2014年 RyomaSato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageViewController.h"//1124
#import "CameraViewController.h"//1124

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIAlertViewDelegate>{

    BOOL _takePictureFlag;
    UIImagePickerController *imagePickerController;//1124
    ImageViewController *imageViewController;//1124
    CameraViewController *cameraViewController;//1125
    BOOL _cameraViewFlag;//試し1125

}

@property (weak, nonatomic) IBOutlet UITableView *documentListTableView;



@end

