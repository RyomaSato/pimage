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
   
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *number = [NSString stringWithFormat:@"%d", app.i];//1113
    [second_dictionary setObject:_ivc_fileName forKey:number];
    
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

    UIView *belowV = [[UIView alloc] init];
    belowV.frame = CGRectMake(0, 528, 320, 40);
    belowV.backgroundColor = [UIColor grayColor];
    [self.view addSubview:belowV];
    
    
    UIButton *usePhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    usePhoto.frame = CGRectMake(200, 0, 100, 40);
    [usePhoto setTitle:@"UsePhoto" forState:UIControlStateNormal];
    [usePhoto addTarget:self action:@selector(usePhoto:) forControlEvents:UIControlEventTouchDown];
    [belowV addSubview:usePhoto];
    
    UIButton *retake = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    retake.frame = CGRectMake(20, 0, 100, 40);
    [retake setTitle:@"Retake" forState:UIControlStateNormal];
    [retake addTarget:self action:@selector(retake:) forControlEvents:UIControlEventTouchDown];
    [belowV addSubview:retake];
    
    
    present_imageView = [[UIImageView alloc] init];
    present_imageView.frame = CGRectMake(0, 60, 320, 420);

    
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
