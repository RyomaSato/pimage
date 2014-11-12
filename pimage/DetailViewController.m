//
//  DetailViewController.m
//  pimage
//
//  Created by 佐藤凌馬 on 2014/11/01.
//  Copyright (c) 2014年 RyomaSato. All rights reserved.
//

#import "DetailViewController.h"
#import "ViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController{

   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
    NSString *fileName = self.documentImageName;
    // Documentsディレクトリに保存
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *FullPath = [NSString stringWithFormat:@"%@/%@",path,fileName];
    //データの読み込み
    NSData *data = [NSData dataWithContentsOfFile:FullPath];
    //画像の作成
    UIImage *image = [[UIImage alloc] initWithData:data];
    
    self.dtlImageView.image = image;
    
    
    
////mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm（仮）mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
//    //ロングタップのジェスチャー生成
//    UILongPressGestureRecognizer* longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
//    [self.dtlImageView addGestureRecognizer:longPressGesture];
//    
//    longPressGesture.minimumPressDuration = 0.8;//ロングプレス認識のための時間(s)
////mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

    
}




////mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm（仮）mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
//- (void) handleLongPressGesture:(UILongPressGestureRecognizer *)gestureRecognizer{
//    
//    if([gestureRecognizer state] == UIGestureRecognizerStateBegan){
//        NSLog(@"longtapbegan");
//        
//        // UILongPressGestureRecognizerからlocationInView:を使ってタップした場所のCGPointを取得する
//        CGPoint longPressPoint = [gestureRecognizer locationInView:self.dtlImageView];
//        
//        NSLog(@"touchedPoint x:[%f]", longPressPoint.x);
//        NSLog(@"touchedPoint y:[%f]", longPressPoint.y);
//        
//    }else if([gestureRecognizer state] == UIGestureRecognizerStateEnded){
//        NSLog(@"longtapended");
//        
//        
//    }
//}
////mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm




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
