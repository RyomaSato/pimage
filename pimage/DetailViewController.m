//
//  DetailViewController.m
//  pimage
//
//  Created by 佐藤凌馬 on 2014/11/01.
//  Copyright (c) 2014年 RyomaSato. All rights reserved.
//

#import "DetailViewController.h"
#import "ViewController.h"//1104

@interface DetailViewController ()

@end

@implementation DetailViewController{

   //NSDictionary *historyData;//1104(削除の時に使用)document
    
}


///////////////////////////1104//////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/////////////////////////////////////////////////////////////////



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
       
/////////////////////////////////////1104/////////////////////////////////////////////
    NSString *FileName = self.documentImageName;
    
    // Documentsディレクトリに保存
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *FullPath = [NSString stringWithFormat:@"%@/%@",path,FileName];

    //データの読み込み
    NSData *data = [NSData dataWithContentsOfFile:FullPath];
    //画像の作成
    UIImage *image = [[UIImage alloc] initWithData:data];
    
    self.dtlImageView.image = image;
///////////////////////////////////////////////////////////////////////////////////////
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
