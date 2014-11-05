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

    NSDictionary *documentData;//1104
}

/////////////////1104////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated  {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    documentData =[defaults dictionaryForKey:@"documentData"];
    
    [self.documentListTableView reloadData];
    
}
/////////////////////////////////////////////////////////////////////////////////


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _documentListTableView.delegate = self;
    _documentListTableView.dataSource = self;
    
    //toolBarの作成
    [self.navigationController setToolbarHidden:NO animated:NO];
    self.navigationController.toolbar.tintColor = [UIColor grayColor];
    
    [self setButton];
    
}



-(void)edit{
    NSLog(@"editボタンが押されました");
}


-(void)camera{
    
    NSLog(@"cameraボタンが押されました");
    [self showUIImagePicker];
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


- (void)showUIImagePicker
{
    // カメラが使用可能かどうか判定する
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    
    // UIImagePickerControllerのインスタンスを生成
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    // デリゲートを設定
    imagePickerController.delegate = self;
    
    // 画像の取得先をカメラに設定
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // 画像取得後に編集するかどうか（デフォルトはNO）
    imagePickerController.allowsEditing = NO;
    
    // 撮影画面をモーダルビューとして表示する
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
}


//画像が選択された時に呼ばれるデリゲートメソッド
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;{//1105

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];////////////1104
    
    NSLog(@"画像選択");
    
    // 渡されてきた画像をフォトアルバムに保存
    //UIImageWriteToSavedPhotosAlbum(image, self, @selector(targetImage:didFinishSavingWithError:contextInfo:), NULL);
 
//////////////////////////////////////////////////////here///////////////////////////////////////////////////////
  
    //撮影した画像を取得
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];

    
       // JPEGデータとしてNSDataを作成
    NSData *data = UIImageJPEGRepresentation(image,0.8f);
    // PNGデータとしてNSDataを作成
    //NSData *data = UIImagePNGRepresentation(image);
    
//////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    NSDate *now = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMdd_HHmmss"];
    NSString *strNow = [df stringFromDate:now];
    
    NSDateFormatter *dfkey = [[NSDateFormatter alloc] init];
    [dfkey setDateFormat:@"yyyy/MM/dd_HH:mm:ss"];
    NSString *strNowKey = [dfkey stringFromDate:now];
    
    NSString *FileName = [NSString stringWithFormat:@"%@.png",strNow];
    // Documentsディレクトリに保存
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",path);
    
    [data writeToFile:[path stringByAppendingPathComponent:FileName] atomically:YES];
    
    NSMutableDictionary *ret_dictionary = [[NSMutableDictionary alloc] initWithDictionary:documentData];
    
    //現在時刻をキーに指定し、Historyデータに保存
    
    [ret_dictionary setObject:FileName forKey:strNowKey];
    
    documentData = ret_dictionary;
    
    [defaults setObject:documentData forKey:@"documentData"];
    [defaults synchronize];
    
    // モーダルビューを閉じる
    [self dismissViewControllerAnimated:YES completion:nil];
}




//TableViewの行数決定
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return documentData.count;
}

//TableViewの行に表示するデータの作成
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //行に配列の文字列を表示
    NSArray *keys = [documentData allKeys];
    NSString *strKey = [keys objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",strKey];
   
       return cell;
}


// 画像の選択がキャンセルされた時に呼ばれるデリゲートメソッド
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    NSLog(@"キャンセルが押されました");
    
    // モーダルビューを閉じる
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


/*/////////////////////////////////////////1104(DetailViewControllerへ画面遷移)////////////////////////////////////
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    DetailViewController  *dvc = [segue destinationViewController];
    
    NSInteger selectindex = self.documentListTableView.indexPathForSelectedRow.row;
    
    NSArray *keys = [documentData allKeys];
    NSString *strKey = [keys objectAtIndex:selectindex];
    NSString *imgname = [documentData objectForKey:[keys objectAtIndex:selectindex]];
    
    dvc.documentKey = strKey;
    dvc.documentImageName = imgname;
    
    
}
/////////////////////////////////////////////////////////////////////////////////////////*/


//DetailViewControllerへの画面遷移
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    dvc.select_num = indexPath.row;
    [[self navigationController]pushViewController:dvc animated:YES];
 
////////////////////////1105/////////////////////////////////////////////////////////////////
    NSInteger selectindex = self.documentListTableView.indexPathForSelectedRow.row;
    
    NSArray *keys = [documentData allKeys];
    NSString *strKey = [keys objectAtIndex:selectindex];
    NSString *imgname = [documentData objectForKey:[keys objectAtIndex:selectindex]];
    
    dvc.documentKey = strKey;
    dvc.documentImageName = imgname;
///////////////////////////////////////////////////////////////////////////////////////////
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
