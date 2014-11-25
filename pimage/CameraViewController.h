//
//  CameraViewController.h
//  pimage
//
//  Created by 佐藤凌馬 on 2014/11/25.
//  Copyright (c) 2014年 RyomaSato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageViewController.h"//1124

@interface CameraViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{

    UIImagePickerController *imagePickerController;
    ImageViewController *imageViewController;//1124
    BOOL _takePictureFlag;
    BOOL _cameraViewFlag;//試し1125

}

@end
