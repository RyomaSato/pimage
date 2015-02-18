//
//  ImageViewController.m
//  pimage
//
//  Created by 佐藤凌馬 on 2014/11/24.
//  Copyright (c) 2014年 RyomaSato. All rights reserved.
//

#import "ImageViewController.h"
#import "AppDelegate.h"

@interface ImageViewController ()

@end

@implementation ImageViewController{

    UIImageView *present_imageView;//1124
    
}


-(void)usePhoto:(id)sender{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [_ivc_data writeToFile:_ivc_imageSavePath atomically:YES];
    NSDictionary *documentData = [defaults objectForKey:@"documentData"];
 
    NSDictionary *temp_second_dictionary = [[NSMutableDictionary alloc] initWithDictionary:documentData];
    NSMutableDictionary *second_dictionary = temp_second_dictionary.mutableCopy;
   
    
    
//    //1126(途中)1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
    NSDictionary *imageData = [defaults objectForKey:@"imageData"];
    NSDictionary *temp_third_dictionary = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *third_dictionary = temp_third_dictionary.mutableCopy;
//////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *number = [NSString stringWithFormat:@"%d", app.i];//1113

    
    
    
    
    
//    //1126(途中)11111111111111111111111111111111111111111111111111111111111111111111111111111111111111
    [third_dictionary setObject:_ivc_fileName forKey:@"fileName"];
   
    imageData = third_dictionary;
    
    [defaults setObject:imageData forKey:@"imageData"];
    [defaults synchronize];

    
    [second_dictionary setObject:third_dictionary forKey:number];
//////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
   // [second_dictionary setObject:_ivc_fileName forKey:number];
    
    documentData = second_dictionary;
    
    [defaults setObject:documentData forKey:@"documentData"];
    [defaults synchronize];
    
    
    [self dismissViewControllerAnimated:NO completion:nil];///?
    
}






-(void)retake:(id)sender{

    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.i = app.i -1;
    
    [self dismissViewControllerAnimated:NO completion:nil];///?
  
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    UIView *belowV = [[UIView alloc] init];
//    belowV.frame = CGRectMake(0, 528, 320, 40);
//    belowV.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:belowV];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.122 green:0.122 blue:0.122 alpha:1.0];

    
    
    UIButton *usePhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//0211    usePhoto.frame = CGRectMake(190, 510, 120, 34);
    
    usePhoto.frame = CGRectMake(self.view.bounds.size.width - 130, 510 * self.view.bounds.size.height/568 , 120, 34);//0211
    UIImage *use_photo = [UIImage imageNamed:@"use_photo.png"];  // ボタンにする画像を生成する
    [usePhoto setBackgroundImage:use_photo forState:UIControlStateNormal];  // 画像をセットする
    //[usePhoto setTitle:@"UsePhoto" forState:UIControlStateNormal];
    [usePhoto addTarget:self action:@selector(usePhoto:) forControlEvents:UIControlEventTouchDown];
   // [belowV addSubview:usePhoto];
    [self.view addSubview:usePhoto];
    
    UIButton *retake = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//0211    retake.frame = CGRectMake(10, 510, 120, 34);
    
    retake.frame = CGRectMake(10, 510 * self.view.bounds.size.height/568, 120, 34);//0211(iphone5Sを基準にして同比率で拡大)
    UIImage *img_retake = [UIImage imageNamed:@"retake.png"];  // ボタンにする画像を生成する
    [retake setBackgroundImage:img_retake forState:UIControlStateNormal];  // 画像をセットする
    //[retake setTitle:@"Retake" forState:UIControlStateNormal];
    [retake addTarget:self action:@selector(retake:) forControlEvents:UIControlEventTouchDown];
   // [belowV addSubview:retake];
    [self.view addSubview:retake];

    
    present_imageView = [[UIImageView alloc] init];
//0211    present_imageView.frame = CGRectMake(0, 60, 320, 420);
    present_imageView.frame = CGRectMake(0, 60 * self.view.bounds.size.height/568, 320 * self.view.bounds.size.width/320, 420 * self.view.bounds.size.height/568);//0211(iphone5Sを基準にして同比率で拡大)
    
}


- (void)viewWillAppear:(BOOL)animated {
    
      present_imageView.image = _ivc_image;
      [self.view addSubview:present_imageView];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
