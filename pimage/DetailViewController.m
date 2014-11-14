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
 
    IBOutlet UIScrollView *scrollView;//1113
    NSUInteger kNumImages;    //(※3)総page数
}

const CGFloat kScrollObjHeight = 568.0;//(※1)1pageの高さ
const CGFloat kScrollObjWidth  = 320.0;//(※2)1pageの幅



- (void)viewDidLoad {
    [super viewDidLoad];
    
    kNumImages = _documentImageList.count;
    
    
    //ScrollViewの生成と設定
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    // 横スクロールのインジケータを非表示にする
    scrollView.showsHorizontalScrollIndicator = NO;
    //ページングを有効にする
    scrollView.pagingEnabled = YES;
    //タッチの検出を有効にする
    scrollView.userInteractionEnabled = YES;
    
    
    [self.view addSubview:scrollView];

    
    NSUInteger i;
    
    for (i = 1; i <= kNumImages; i++)
    {
        
        NSString *number = [NSString stringWithFormat:@"%ld", i];
        NSString *imageName = [_documentImageList objectForKey:number];
        
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *FullPath = [NSString stringWithFormat:@"%@/%@",path,imageName];

        NSData *data = [NSData dataWithContentsOfFile:FullPath];

        UIImage *image = [[UIImage alloc] initWithData:data];

//        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        CGRect rect = imageView.frame;
        rect.size.height = kScrollObjHeight;
        rect.size.width = kScrollObjWidth;
        imageView.frame = rect;
        imageView.tag = i;
        
        [scrollView addSubview:imageView];
        
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(160, 40, 10, 20)];
//        label.text = [NSString stringWithFormat:@"%ld", i];
//        label.font = [UIFont fontWithName:@"Arial" size:20];
//        // label.backgroundColor = [UIColor yellowColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        [imageView addSubview:label];
        
    }
    
    [self layoutScrollImages];

    //toolbarを隠す
    [self.navigationController setToolbarHidden:YES animated:NO];
//    
//    // Do any additional setup after loading the view.    
//    NSString *fileName = self.documentImageName;
//    // Documentsディレクトリに保存
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *FullPath = [NSString stringWithFormat:@"%@/%@",path,fileName];
//    //データの読み込み
//    NSData *data = [NSData dataWithContentsOfFile:FullPath];
//    //画像の作成
//    UIImage *image = [[UIImage alloc] initWithData:data];
//    
//    self.dtlImageView.image = image;
    
    
    
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






- (void)layoutScrollImages
{
    UIImageView *view = nil;
    NSArray *subviews = [scrollView subviews];
    
    CGFloat curXLoc = 0;
    for (view in subviews)
    {
        if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
        {
            CGRect frame = view.frame;
            frame.origin = CGPointMake(curXLoc, 0);
            view.frame = frame;
            
            curXLoc += (kScrollObjWidth);
        }
    }
    
    //スクロールの総範囲
    [scrollView setContentSize:CGSizeMake((kNumImages * kScrollObjWidth), kScrollObjHeight)];
    
    
}


//////////////////////////////////////////////////////////////////////////////////








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
