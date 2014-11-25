//
//  ViewController.m
//  pimage
//
//  Created by 佐藤凌馬 on 2014/10/30.
//  Copyright (c) 2014年 RyomaSato. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    
   // NSInteger i;//1113(try)

    NSDictionary *documentData;
    NSDictionary *folder;//1113(try)
    UITableViewCell *documentcell;//1107/ユーザデフォルト更新
    NSIndexPath *longtapIndex;//1108/ユーザデフォルト更新
    
}



- (void)viewWillAppear:(BOOL)animated  {
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    documentData =[defaults dictionaryForKey:@"documentData"];
//    
//    [self.documentListTableView reloadData];

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    folder = [defaults dictionaryForKey:@"folder"];
    
    [self.documentListTableView reloadData];
    
    //ToolBarを表示する
    [self.navigationController setToolbarHidden:NO animated:NO];//1113
    
    
    
    
//    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    if (app.cameraViewFlag) {
////    if (_cameraViewFlag) {
//        [self openCamera];
    
        //[self performSelector:@selector(openCamera) withObject:nil afterDelay:0.01];//1125
    //}
    
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _documentListTableView.delegate = self;
    _documentListTableView.dataSource = self;
    
    //toolBarの作成
    [self.navigationController setToolbarHidden:NO animated:NO];
    self.navigationController.toolbar.tintColor = [UIColor grayColor];
    
    [self setButton];
    
    
 
    //ロングタップのジェスチャー生成
    UILongPressGestureRecognizer* longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self.documentListTableView addGestureRecognizer:longPressGesture];
    
    longPressGesture.minimumPressDuration = 0.8;//ロングプレス認識のための時間(s)

    
    
//    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    app.cameraViewFlag = NO;
////    _cameraViewFlag = NO;
//    
//    _takePictureFlag = NO;
    
    
}



-(void)edit{
    NSLog(@"editボタンが押されました");
   
    
}


-(void)camera{
    NSLog(@"cameraボタンが押されました");
    
    //ビュワーを開く
    if(!cameraViewController){
        
        cameraViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CameraViewController"];
        
    }
    
    //モーダルとして表示
    [self presentViewController:cameraViewController animated:NO completion:nil];

    
//    //[self showUIImagePicker];
//    [self performSelector:@selector(openCamera) withObject:nil afterDelay:0.01];//1124

}


-(void)trash{
    NSLog(@"trashボタンが押されました");
}


-(void)setButton{
    
    UIBarButtonItem *nvgRightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit)];
    self.navigationItem.rightBarButtonItem = nvgRightBarButton;
    
    //スペーサーの作成
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *toolLeftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(camera)];
    
    UIBarButtonItem *toolRightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(trash)];
    
    NSArray *items = [NSArray arrayWithObjects:spacer, toolLeftBarButton, spacer, spacer, spacer, toolRightBarButton, spacer, nil];
    self.toolbarItems = items;
    
}


//- (void)showUIImagePicker
//{
//    
//    // カメラが使用可能かどうか判定する
//    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        return;
//    }
//    
//    // UIImagePickerControllerのインスタンスを生成
//    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//    
//    // デリゲートを設定
//    imagePickerController.delegate = self;
//    
//    // 画像の取得先をカメラに設定
//    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//    
//    // 画像取得後に編集するかどうか（デフォルトはNO）
//    imagePickerController.allowsEditing = NO;
//    
//    // 撮影画面をモーダルビューとして表示する
//    [self presentViewController:imagePickerController animated:YES completion:nil];
//    
//}






////1124
//-(void)openCamera{
//    
//    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    app.cameraViewFlag = YES;
////    _cameraViewFlag = YES;
//    
//    imagePickerController = [[UIImagePickerController alloc]init];
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
//        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//        imagePickerController.delegate = self;
//        imagePickerController.showsCameraControls = NO;
//        imagePickerController.view.frame = CGRectMake(0, 40, 320, 528);
//        
//        [[self.view superview] addSubview:imagePickerController.view];
//       
//        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        btn.frame = CGRectMake(110, 460, 100, 30);
//        [btn setTitle:@"takepicture" forState:UIControlStateNormal];
//        
//        [btn addTarget:self action:@selector(takePicture:) forControlEvents:UIControlEventTouchDown];
//        [imagePickerController.view addSubview:btn];
//        
//        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        btn2.frame = CGRectMake(0, 460, 100, 30);
//        [btn2 setTitle:@"Cancel" forState:UIControlStateNormal];
//        
//        [btn2 addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchDown];
//        [imagePickerController.view addSubview:btn2];
//        
//        
//        //navigationbarを隠す
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        //toolbarを隠す
//        [self.navigationController setToolbarHidden:YES animated:NO];
//        
//    }
//}
//
//
//
////1124
//-(void)takePicture:(id)sender{
//    //撮影
//    [imagePickerController takePicture];
//}
//
//
//
////画像が選択された時に呼ばれるデリゲートメソッド
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;{
//    
//    NSLog(@"画像選択");
//    
//    //1125 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//   
//    // 渡されてきた画像をフォトアルバムに保存
//    //UIImageWriteToSavedPhotosAlbum(image, self, @selector(targetImage:didFinishSavingWithError:contextInfo:), NULL);
//
//    //撮影した画像を取得
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    
//    // JPEGデータとしてNSDataを作成
//    NSData *data = UIImageJPEGRepresentation(image,0.8f);
//    // PNGデータとしてNSDataを作成
//    //NSData *data = UIImagePNGRepresentation(image);
//    
//
//    NSDate *now = [NSDate date];
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"yyyyMMdd_HHmmss"];
//    NSString *strNow = [df stringFromDate:now];
//
////    NSDateFormatter *dfkey = [[NSDateFormatter alloc] init];
////    [dfkey setDateFormat:@"yyyy/MM/dd_HH:mm:ss"];
////    NSString *strNowKey = [dfkey stringFromDate:now];
////
////    NSString *fileName = [NSString stringWithFormat:@"%@.jpg",strNow];
//
//    
//    NSString *fileName = [NSString stringWithFormat:@"img%@.jpg", strNow];
//    
//    // Documentsディレクトリに保存
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSLog(@"%@",path);
//    
//    NSString *imageSavePath = [path stringByAppendingPathComponent:fileName];//1124
//    //[data writeToFile:[path stringByAppendingPathComponent:fileName] atomically:YES];
//    
//
//    
//    
////    NSMutableDictionary *first_dictionary = [[NSMutableDictionary alloc] initWithDictionary:documentData];
////    NSMutableDictionary *second_dictionary = [[NSMutableDictionary alloc] init];//1111
//    
////    [second_dictionary setObject:fileName forKey:@"fileName"];//1111
////    [second_dictionary setObject:strNowKey forKey:@"displayName"];//1111
////    
////    [first_dictionary setObject:second_dictionary forKey:strNowKey];//1111
////    
////    documentData = first_dictionary;
////    
////    [defaults setObject:documentData forKey:@"documentData"];
////    [defaults synchronize];
//
//
///////////////////////////1113ok
//    i = i + 1;
//
//    
////////1125
////    NSDictionary *temp_second_dictionary = [[NSMutableDictionary alloc] initWithDictionary:documentData];
////    NSMutableDictionary *second_dictionary = temp_second_dictionary.mutableCopy;
////    NSString *number = [NSString stringWithFormat:@"%ld", i];//1113
////    [second_dictionary setObject:fileName forKey:number];
////    
////    documentData = second_dictionary;
////    
////    [defaults setObject:documentData forKey:@"documentData"];
////    [defaults synchronize];
//    
//
//    _takePictureFlag = YES;
//
//
//    
//    
//    
//    
////1124
////    // モーダルビューを閉じる
////    [self dismissViewControllerAnimated:NO completion:nil];
//
//    
//    
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////1124
//    //撮影画面を隠す
//    imagePickerController.view.hidden = YES;
//    //ビュワーを開く
//    if(!imageViewController){
//        
//        imageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageViewController"];
//        
//    }
//    
//    //ここでiのnumberを受け渡す
//    imageViewController.num = i;
//    imageViewController.ivc_imageSavePath = imageSavePath;
//    imageViewController.ivc_data = data;
//    imageViewController.ivc_image = image;
//    imageViewController.ivc_fileName = fileName;
//    
//    
//    //モーダルとして表示
//    [self presentViewController:imageViewController animated:NO completion:nil];
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//    
//    
//////////////////インターバルを設定(応急処置)mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm1114
////    //セレクタをセット
////    SEL sel = @selector(targetImage:didFinishSavingWithError:contextInfo:);
////    // シグネチャをセット
////    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:sel];
////    // インボケーションをセット
////    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
////    // オブジェクトをセット
////    [invocation setTarget:self];
////    // セレクタをセット
////    [invocation setSelector:sel];
////    [NSTimer scheduledTimerWithTimeInterval:0.3f invocation:invocation repeats:NO];
//    
//
//}
//
//
//////// 画像の保存完了時に呼ばれるメソッド1114
////- (void)targetImage:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)context
////{
////    if (error) {
////        // 保存失敗時の処理
////    } else {
////        // 保存成功時の処理
////        
////        // カメラが使用可能かどうか判定する
////        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
////            return;
////        }
////        
////        // UIImagePickerControllerのインスタンスを生成
////        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
////        
////        // デリゲートを設定
////          imagePickerController.delegate = self;
////        
////        // 画像の取得先をカメラに設定
////        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
////        
////        // 画像取得後に編集するかどうか（デフォルトはNO）
////        imagePickerController.allowsEditing = NO;
////        
////        // 撮影画面をモーダルビューとして表示する
////        [self presentViewController:imagePickerController animated:NO completion:nil];
////
////    }
////}
//
//
//
//
//// 画像の選択がキャンセルされた時に呼ばれるデリゲートメソッド
////- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
////{
//-(void)cancel:(id)sender{//1124
//    
//    NSLog(@"キャンセルが押されました");
//
//        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        app.cameraViewFlag = NO;
////    _cameraViewFlag = NO;
//    
//    if (_takePictureFlag) {
//        
///////////////////////////////////////1113///////////////////////////////////
//        i = 0;
//    
//        NSDate *now = [NSDate date];
//        NSDateFormatter *dfkey = [[NSDateFormatter alloc] init];
//        [dfkey setDateFormat:@"yyyy/MM/dd_HH:mm:ss"];
//        NSString *strNowKey = [dfkey stringFromDate:now];
//
//    
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//        documentData = [defaults dictionaryForKey:@"documentData"];
//        folder = [defaults dictionaryForKey:@"folder"];
//    
//        NSMutableDictionary *first_dictionary = [[NSMutableDictionary alloc] initWithDictionary:folder];
//        NSMutableDictionary *second_dictionary = [[NSMutableDictionary alloc] init];
//        
//        NSArray *keys = [documentData allKeys];
//
//        NSMutableDictionary *imageList = [[NSMutableDictionary alloc] init];
///////////////////////////////////////////////////////////////試し
//        for (int k = 1; k <= keys.count; k++)
//        {
//            NSString *number = [NSString stringWithFormat:@"%d", k];//113
//            NSString *fileName = [documentData objectForKey:number];////////////////////////////////試し
//
//            [imageList setObject:fileName forKey:number];
//        
//        }
//    
//        [second_dictionary setObject:strNowKey forKey:@"displayName"];//1111
//    
//        //[second_dictionary setObject:keys forKey:strNowKey];
//    
//        //[second_dictionary setObject:keys forKey:@"imageList"];
//        [second_dictionary setObject:imageList forKey:@"imageList"];//1113(try)
//    
//        [first_dictionary setObject:second_dictionary forKey:strNowKey];
//
//        folder = first_dictionary;
//    
//        [defaults setObject:folder forKey:@"folder"];
//        [defaults synchronize];
//    
/////////////////////////////////////documentDataの初期化//////////////////////////////////////
//        NSMutableDictionary *init_documentData = [[NSMutableDictionary alloc] initWithDictionary:documentData];
//
//        [init_documentData removeAllObjects];
//    
//        documentData = init_documentData;
//    
// //////////////////////////////////////////////////////////////////////////////////
//        _takePictureFlag = NO;
//        
//        // モーダルビューを閉じる
//        [self dismissViewControllerAnimated:YES completion:nil];///?
//        
//        }else{
//        
//        // モーダルビューを閉じる
//        [self dismissViewControllerAnimated:YES completion:nil];///?
//    
//    }
//}




//TableViewの行数決定
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return documentData.count;
    return folder.count;//1113
}

//TableViewの行に表示するデータの作成
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
//    //行に配列の文字列を表示
//    NSArray *keys = [documentData allKeys];
//    NSDictionary *second_dictionary = [documentData objectForKey:[keys objectAtIndex:indexPath.row]];//1111
//    NSString *displayName = [second_dictionary objectForKey:@"displayName"];//1111

//行に配列の文字列を表示//////////////////////////////////1113
    NSArray *keys = [folder allKeys];
    NSDictionary *second_dictionary = [folder objectForKey:[keys objectAtIndex:indexPath.row]];//1111
    NSString *displayName = [second_dictionary objectForKey:@"displayName"];//1111

//////////////////////////////////////////////////////////////////////////////////////
    cell.textLabel.text = [NSString stringWithFormat:@"%@",displayName];
   
    return cell;
}


//横スワイプで削除ボタンを表示
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        
//        documentData = [defaults dictionaryForKey:@"documentData"];
//        
//        NSMutableDictionary *first_dictionary = [[NSMutableDictionary alloc] initWithDictionary:documentData];
//        
//        
//        
//        NSInteger selectindex = self.documentListTableView.indexPathForSelectedRow.row;
//        NSArray *keys = [documentData allKeys];
//        NSString *strKey = [keys objectAtIndex:selectindex];
//        NSString *imgname = [documentData objectForKey:[keys objectAtIndex:selectindex]];
//        
//        [first_dictionary removeObjectForKey:strKey];
//        
//        documentData = first_dictionary;
//        
//        [defaults setObject:documentData forKey:@"documentData"];
//        [defaults synchronize];
//
//        
//        
//        
//        //画像ファイルを削除
//        // ファイルマネージャを作成
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        
//        // 削除したいファイルのパスを作成
//        NSString *fileName = imgname;
//        // Documentsディレクトリに保存
//        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        
//        NSString *FullPath = [NSString stringWithFormat:@"%@/%@",path,fileName];
//        
//        
//        NSError *error;
//        
//        // ファイルを移動
//        BOOL result = [fileManager removeItemAtPath:FullPath error:&error];
//        
//        if (result) {
//            NSLog(@"ファイルを削除に成功：%@", FullPath);
//        } else {
//            NSLog(@"ファイルの削除に失敗：%@", error.description);
//        }
//        
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        

        
        
/////////////////////////////////////////////////1113///////////////////////////////////////////

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        folder = [defaults dictionaryForKey:@"folder"];
        
        NSMutableDictionary *first_dictionary = [[NSMutableDictionary alloc] initWithDictionary:folder];
        
   //     NSInteger selectindex = self.documentListTableView.indexPathForSelectedRow.row;///////////うまく行ってない1114
        NSInteger selectindex = indexPath.row;//
        NSArray *keys = [folder allKeys];
        NSString *strKey = [keys objectAtIndex:selectindex];//1113
        
        
//        NSDictionary *temp_second_dictionary = [first_dictionary objectForKey:[keys objectAtIndex:selectindex]];
//        NSMutableDictionary *second_dictionary = temp_second_dictionary.mutableCopy;
//        
//        NSDictionary *temp_imageList = [second_dictionary objectForKey:@"imageList"];
//        NSMutableDictionary *imageList = temp_imageList.mutableCopy;

        
        [first_dictionary removeObjectForKey:strKey];//1113
        
        folder = first_dictionary;
    
        [defaults setObject:folder forKey:@"folder"];
        [defaults synchronize];
        
        
//        for (int k = 1; k <= imageList.count; k++)//試し1113
//        {
//            NSString *number = [NSString stringWithFormat:@"%d", k];//113
//            NSString *imgname = [imageList objectForKey:number];
//            
////            [first_dictionary removeObjectForKey:second_dictionary];
////
////            [second_dictionary removeObjectForKey:number];
////
////            documentData = first_dictionary;
////        
////            [defaults setObject:documentData forKey:@"documentData"];
////            [defaults synchronize];
//        
////        for (int k = 1; k <= imageList.count; k++)
////        {
// 
//        
////            NSString *number = [NSString stringWithFormat:@"%d", k];//113
////            NSString *imgname = [imageList objectForKey:number];
//       
//        
//            //画像ファイルを削除
//            // ファイルマネージャを作成
//            NSFileManager *fileManager = [NSFileManager defaultManager];
//        
//            // 削除したいファイルのパスを作成
//            NSString *fileName = imgname;
//            // Documentsディレクトリに保存
//            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        
//            NSString *FullPath = [NSString stringWithFormat:@"%@/%@",path,fileName];
//        
//        
//            NSError *error;
//        
//            // ファイルを移動
//            BOOL result = [fileManager removeItemAtPath:FullPath error:&error];
//       
//            if (result) {
//                NSLog(@"ファイルを削除に成功：%@", FullPath);
//            } else {
//                NSLog(@"ファイルの削除に失敗：%@", error.description);
//            }
//         
//        }
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
///////////////////////////////////////////////////////////////////////////////////////////////////////
        
    
    }
}


//DetailViewControllerへの画面遷移
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    dvc.select_num = indexPath.row;
    [[self navigationController]pushViewController:dvc animated:YES];
 
    NSInteger selectindex = self.documentListTableView.indexPathForSelectedRow.row;
    
//    NSArray *keys = [documentData allKeys];
//    NSDictionary *second_dictionary = [documentData objectForKey:[keys objectAtIndex:selectindex]];//1111
//    NSString *fileName = [second_dictionary objectForKey:@"fileName"];//1111
//    
//    dvc.documentKey = [keys objectAtIndex:selectindex];
//    dvc.documentImageName = fileName;
   
    
//////////////////////////////////////////////////1113
    NSArray *keys = [folder allKeys];
    NSDictionary *second_dictionary = [folder objectForKey:[keys objectAtIndex:selectindex]];
    NSDictionary *imageList = [second_dictionary objectForKey:@"imageList"];

    dvc.documentImageList = imageList;
    
////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
}



//cellが長押しされたときに呼ばれる
- (void) handleLongPressGesture:(UILongPressGestureRecognizer *)gestureRecognizer{
    
    if([gestureRecognizer state] == UIGestureRecognizerStateBegan){
        NSLog(@"longtapbegan");
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"名称変更"
                                                          message:nil
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"OK", nil];
        
        [message setAlertViewStyle:UIAlertViewStylePlainTextInput];//１行で実装
        [message show];
        
        // UILongPressGestureRecognizerからlocationInView:を使ってタップした場所のCGPointを取得する
        CGPoint longPressPoint = [gestureRecognizer locationInView:self.documentListTableView];
        // 取得したCGPointを利用して、indexPathForRowAtPoint:でタップした場所のNSIndexPathを取得する
        longtapIndex = [self.documentListTableView indexPathForRowAtPoint:longPressPoint];
        // NSIndexPathを利用して、cellForRowAtIndexPath:で該当でUITableViewCellを取得する
        documentcell = [self.documentListTableView cellForRowAtIndexPath:longtapIndex];///ユーザデフォルト更新

    }else if([gestureRecognizer state] == UIGestureRecognizerStateEnded){
         NSLog(@"longtapended");
        
        
    }
}



//アラートのボタンを押したときに呼ばれる
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
 
    if (buttonIndex == 1) {
        
        NSLog(@"text=%@",[[alertView textFieldAtIndex:0] text]);
      
//        //ユーザデフォルトの更新
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];//取得
//        
//        documentData = [defaults dictionaryForKey:@"documentData"];
//
//        NSMutableDictionary *first_dictionary = [[NSMutableDictionary alloc] initWithDictionary:documentData];
//        
//        NSArray *keys = [documentData allKeys];
//        NSDictionary *temp_second_dictionary = [first_dictionary objectForKey:[keys objectAtIndex:longtapIndex.row]];//1112
//        NSMutableDictionary *second_dictionary = temp_second_dictionary.mutableCopy;//temp_second_dictionaryをmutableとしてコピー
//        NSString *displayName = [second_dictionary objectForKey:@"displayName"];//1110
//        
//        displayName = [[alertView textFieldAtIndex:0] text];
//        
//        [second_dictionary setObject:displayName forKey:@"displayName"];
//        [first_dictionary setObject:second_dictionary forKey:[keys objectAtIndex:longtapIndex.row]];
// 
//        documentData =first_dictionary;
//
//        [defaults setObject:documentData forKey:@"documentData"];
//        [defaults synchronize];
//        
//        documentcell.textLabel.text = [[alertView textFieldAtIndex:0] text];
       
        
        //ユーザデフォルトの更新
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];//取得
        
        folder = [defaults dictionaryForKey:@"folder"];
        
        NSMutableDictionary *first_dictionary = [[NSMutableDictionary alloc] initWithDictionary:folder];
        
        NSArray *keys = [folder allKeys];
        NSDictionary *temp_second_dictionary = [first_dictionary objectForKey:[keys objectAtIndex:longtapIndex.row]];//1112
        NSMutableDictionary *second_dictionary = temp_second_dictionary.mutableCopy;//temp_second_dictionaryをmutableとしてコピー
        NSString *displayName = [second_dictionary objectForKey:@"displayName"];//1110
        
        displayName = [[alertView textFieldAtIndex:0] text];
        
        [second_dictionary setObject:displayName forKey:@"displayName"];
        [first_dictionary setObject:second_dictionary forKey:[keys objectAtIndex:longtapIndex.row]];
        
        folder =first_dictionary;
        
        [defaults setObject:folder forKey:@"folder"];
        [defaults synchronize];
        
        documentcell.textLabel.text = [[alertView textFieldAtIndex:0] text];
        
        
    }else if(buttonIndex == 0){
    
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
