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
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    folder = [defaults dictionaryForKey:@"folder"];
    
    [self.documentListTableView reloadData];
    
    //ToolBarを表示する
    [self.navigationController setToolbarHidden:NO animated:NO];//1113
    
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
