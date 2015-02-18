//
//  CameraViewController.m
//  pimage
//
//  Created by 佐藤凌馬 on 2014/11/25.
//  Copyright (c) 2014年 RyomaSato. All rights reserved.
//

#import "CameraViewController.h"
#import "AppDelegate.h"


@interface CameraViewController ()

@end

@implementation CameraViewController{
  //  NSInteger i;//1113(try)
    
    //NSDictionary *documentData;
    NSDictionary *folder;//1113(try)
    UITableViewCell *documentcell;//1107/ユーザデフォルト更新
    NSIndexPath *longtapIndex;//1108/ユーザデフォルト更新
}


- (void)viewWillAppear:(BOOL)animated  {
//    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    if (app.cameraViewFlag) {
    if(imagePickerController)imagePickerController.view.hidden = NO;
    
 
//    
//    if (_cameraViewFlag) {
//
//        //[self openCamera];
//        [self performSelector:@selector(openCamera) withObject:nil afterDelay:0.01];//1125
//    }

}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self performSelector:@selector(openCamera) withObject:nil afterDelay:0.01];
   
    //self.viewのcolor変更
    self.view.backgroundColor = [UIColor colorWithRed:0.122 green:0.122 blue:0.122 alpha:1.0];
     _cameraViewFlag = NO;
    _takePictureFlag = NO;
    
    
}


//1124
-(void)openCamera{
    
//    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    app.cameraViewFlag = YES;
        _cameraViewFlag = YES;
    
    imagePickerController = [[UIImagePickerController alloc]init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.delegate = self;
        imagePickerController.showsCameraControls = NO;
//0211        imagePickerController.view.frame = CGRectMake(0, 64, 320, 426);//(カメラ画面サイズ426)
 
imagePickerController.view.frame = CGRectMake(0, 64 * self.view.bounds.size.height/568, 320 * self.view.bounds.size.height/320, 426 * self.view.bounds.size.height/568);//0211
        //       [[self.view superview] addSubview:imagePickerController.view];
        [self.view addSubview:imagePickerController.view];
 
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//0211        btn.frame = CGRectMake(124, 490, 72, 75);
        
        btn.frame = CGRectMake(self.view.bounds.size.width/2 - 36, 490 * self.view.bounds.size.height/568, 72, 75);//0211
        UIImage *take_photo = [UIImage imageNamed:@"take_photo.png"];  // ボタンにする画像を生成する
        [btn setBackgroundImage:take_photo forState:UIControlStateNormal];  // 画像をセットする
       // [btn setTitle:@"takepicture" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(takePicture:) forControlEvents:UIControlEventTouchDown];
       // [imagePickerController.view addSubview:btn];
        [self.view addSubview:btn];
      
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//0211        btn2.frame = CGRectMake(220, 25, 90, 30);
        
        btn2.frame = CGRectMake(self.view.bounds.size.width - 100, 25 * self.view.bounds.size.height/568, 90, 30);//0211
        UIImage *save = [UIImage imageNamed:@"save.png"];  // ボタンにする画像を生成する
        [btn2 setBackgroundImage:save forState:UIControlStateNormal];  // 画像をセットする
        //[btn2 setTitle:@"Cancel" forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:btn2];
      //  [imagePickerController.view addSubview:btn2];
        
//        //navigationbarを隠す
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        //toolbarを隠す
//        [self.navigationController setToolbarHidden:YES animated:NO];
        
    }
}



//1124
-(void)takePicture:(id)sender{
    //撮影
    [imagePickerController takePicture];
}




//画像が選択された時に呼ばれるデリゲートメソッド
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;{
    
    NSLog(@"画像選択");
    
    //1125 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 渡されてきた画像をフォトアルバムに保存
    //UIImageWriteToSavedPhotosAlbum(image, self, @selector(targetImage:didFinishSavingWithError:contextInfo:), NULL);
    
    //撮影した画像を取得
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // JPEGデータとしてNSDataを作成
    NSData *data = UIImageJPEGRepresentation(image,0.8f);
    // PNGデータとしてNSDataを作成
    //NSData *data = UIImagePNGRepresentation(image);
    
    
    NSDate *now = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMdd_HHmmss"];
    NSString *strNow = [df stringFromDate:now];
    
    //    NSDateFormatter *dfkey = [[NSDateFormatter alloc] init];
    //    [dfkey setDateFormat:@"yyyy/MM/dd_HH:mm:ss"];
    //    NSString *strNowKey = [dfkey stringFromDate:now];
    //
    //    NSString *fileName = [NSString stringWithFormat:@"%@.jpg",strNow];
    
    
    NSString *fileName = [NSString stringWithFormat:@"img%@.jpg", strNow];
    
    // Documentsディレクトリに保存
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",path);
    
    NSString *imageSavePath = [path stringByAppendingPathComponent:fileName];//1124
    //[data writeToFile:[path stringByAppendingPathComponent:fileName] atomically:YES];
    
    
    
    
    //    NSMutableDictionary *first_dictionary = [[NSMutableDictionary alloc] initWithDictionary:documentData];
    //    NSMutableDictionary *second_dictionary = [[NSMutableDictionary alloc] init];//1111
    
    //    [second_dictionary setObject:fileName forKey:@"fileName"];//1111
    //    [second_dictionary setObject:strNowKey forKey:@"displayName"];//1111
    //
    //    [first_dictionary setObject:second_dictionary forKey:strNowKey];//1111
    //
    //    documentData = first_dictionary;
    //
    //    [defaults setObject:documentData forKey:@"documentData"];
    //    [defaults synchronize];
    
    
    /////////////////////////1113ok
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.i = app.i + 1;
    
    
    //////1125
    //    NSDictionary *temp_second_dictionary = [[NSMutableDictionary alloc] initWithDictionary:documentData];
    //    NSMutableDictionary *second_dictionary = temp_second_dictionary.mutableCopy;
    //    NSString *number = [NSString stringWithFormat:@"%ld", i];//1113
    //    [second_dictionary setObject:fileName forKey:number];
    //
    //    documentData = second_dictionary;
    //
    //    [defaults setObject:documentData forKey:@"documentData"];
    //    [defaults synchronize];
    
    
    _takePictureFlag = YES;
    
    
    //1124
    //    // モーダルビューを閉じる
    //    [self dismissViewControllerAnimated:NO completion:nil];
    
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////1124
    //撮影画面を隠す
    imagePickerController.view.hidden = YES;
    //ビュワーを開く
    if(!imageViewController){
        
        imageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageViewController"];
        
    }
    
    //ここでiのnumberを受け渡す
   // imageViewController.num = i;
    imageViewController.ivc_imageSavePath = imageSavePath;
    imageViewController.ivc_data = data;
    imageViewController.ivc_image = image;
    imageViewController.ivc_fileName = fileName;
    
    
    //モーダルとして表示
    [self presentViewController:imageViewController animated:NO completion:nil];
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
}


-(void)cancel:(id)sender{//1124
    
    NSLog(@"キャンセルが押されました");
    
//    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    app.cameraViewFlag = NO;
    _cameraViewFlag = NO;
    
    if (_takePictureFlag) {
        
        /////////////////////////////////////1113///////////////////////////////////
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        app.i = 0;
        
        NSDate *now = [NSDate date];
        NSDateFormatter *dfkey = [[NSDateFormatter alloc] init];
        [dfkey setDateFormat:@"yyyy/MM/dd_HH:mm:ss"];
        NSString *strNowKey = [dfkey stringFromDate:now];
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *documentData = [defaults dictionaryForKey:@"documentData"];//1126
    
        folder = [defaults dictionaryForKey:@"folder"];
        
        NSMutableDictionary *first_dictionary = [[NSMutableDictionary alloc] initWithDictionary:folder];
        NSMutableDictionary *second_dictionary = [[NSMutableDictionary alloc] init];
        
        NSArray *keys = [documentData allKeys];

        NSMutableDictionary *imageList = [[NSMutableDictionary alloc] init];
        /////////////////////////////////////////////////////////////試し
        for (int k = 1; k <= keys.count; k++)
        {
            NSString *number = [NSString stringWithFormat:@"%d", k];//113
            NSString *fileName = [documentData objectForKey:number];////////////////////////////////試し
            
            [imageList setObject:fileName forKey:number];
            
        }
        
        [second_dictionary setObject:strNowKey forKey:@"displayName"];//1111
        
        //[second_dictionary setObject:keys forKey:strNowKey];
        
        //[second_dictionary setObject:keys forKey:@"imageList"];
        [second_dictionary setObject:imageList forKey:@"imageList"];//1113(try)
        
        [first_dictionary setObject:second_dictionary forKey:strNowKey];
        
        folder = first_dictionary;
        
        [defaults setObject:folder forKey:@"folder"];
        [defaults synchronize];
        
        ///////////////////////////////////documentDataの初期化//////////////////////////////////////
        NSMutableDictionary *init_documentData = [[NSMutableDictionary alloc] initWithDictionary:documentData];
//        NSMutableDictionary *init_documentData = [[NSMutableDictionary alloc] initWithDictionary:imageData];//1127
  
        [init_documentData removeAllObjects];
        
        documentData = init_documentData;
//        imageData = init_documentData;//1127

        [defaults setObject:documentData forKey:@"documentData"];
//        [defaults setObject:imageData forKey:@"imageData"];//1127
        [defaults synchronize];
        //////////////////////////////////////////////////////////////////////////////////
        _takePictureFlag = NO;
        
        // モーダルビューを閉じる
        [self dismissViewControllerAnimated:YES completion:nil];///?
   
    }else{
        
        // モーダルビューを閉じる
        [self dismissViewControllerAnimated:YES completion:nil];///?
        
    }
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
