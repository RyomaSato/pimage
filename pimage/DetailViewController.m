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
 
   //1119 IBOutlet UIScrollView *scrollView;//1113
    NSUInteger kNumImages;//総page数
    UIImageView *imageView;//1116
    UIImageView *pinImageView;//1117
    NSInteger k;//1119
    NSInteger j;//1119
    UIView *uv;
    
}

const CGFloat kScrollObjHeight = 524.0;//1pageの高さ
const CGFloat kScrollObjWidth  = 320.0;//1pageの幅


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
    //総ページ数の取得
    kNumImages = _documentImageList.count;
    
    // UIViewの生成1119
    uv = [[UIView alloc] initWithFrame:CGRectMake(0,0,kScrollObjWidth*kNumImages,kScrollObjHeight)];
    [self.view addSubview:uv];
    
    //kの初期値設定1119
    k = 1;
    //jの初期値設定(ページと数字がかぶらないように設定)1119
    j = kNumImages;
    
    //ボタン生成1116
    UIBarButtonItem *nvgRightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = nvgRightBarButton;
    
    //ツールバーボタンの作成
    //スペーサーの作成
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *toolLeftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(back)];
    
    UIBarButtonItem *toolRightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(forward)];
    
    NSArray *items = [NSArray arrayWithObjects:spacer, toolLeftBarButton, spacer, spacer, spacer, toolRightBarButton, spacer, nil];
    self.toolbarItems = items;

    
    
    
    
    
    
    
    
    
//1119
//    //ScrollViewの生成と設定
//    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    // 横スクロールのインジケータを非表示にする
//    scrollView.showsHorizontalScrollIndicator = NO;
//    //ページングを有効にする
//    scrollView.pagingEnabled = YES;
//    //タッチの検出を有効にする
//    scrollView.userInteractionEnabled = YES;
//    
//    [self.view addSubview:scrollView];

    
    NSUInteger i;
    
    for (i = 1; i <= kNumImages; i++)
    {
        
        NSString *number = [NSString stringWithFormat:@"%ld", i];
        NSString *imageName = [_documentImageList objectForKey:number];
        
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *FullPath = [NSString stringWithFormat:@"%@/%@",path,imageName];
        
        NSData *data = [NSData dataWithContentsOfFile:FullPath];
        
        UIImage *image = [[UIImage alloc] initWithData:data];

        //UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView = [[UIImageView alloc] initWithImage:image];//1116(試し)
     
        //タッチの検出を有効にする
        imageView.userInteractionEnabled = YES;
        
        CGRect rect = imageView.frame;
        rect.size.height = kScrollObjHeight;
        rect.size.width = kScrollObjWidth;
        imageView.frame = rect;
        imageView.tag = i;
        
        // [scrollView addSubview:imageView];
       // [self.view addSubview:imageView];
        [uv addSubview:imageView];//1119
        
    }
    
    [self layoutScrollImages];

    //toolbarを隠す
   // [self.navigationController setToolbarHidden:YES animated:NO];
    
}


- (void)layoutScrollImages
{
    UIImageView *view = nil;
 //   NSArray *subviews = [scrollView subviews];
 //   NSArray *subviews = [self.view subviews];
    NSArray *subviews = [uv subviews];
    
    CGFloat curXLoc = 0;
    for (view in subviews)
    {
        if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
        {
            CGRect frame = view.frame;
            frame.origin = CGPointMake(curXLoc, 0);//(navigationBarは上から64)
            view.frame = frame;
            
            curXLoc += (kScrollObjWidth);
        }
    }
    
    //スクロールの総範囲
 //   [scrollView setContentSize:CGSizeMake((kNumImages * kScrollObjWidth), kScrollObjHeight)];
    
}



//1119
-(void)back{
    NSLog(@"backボタンが押されました");
    
    if (k >= 2) {
        
        [UIView beginAnimations:nil context:nil];  // 条件指定開始
        [UIView setAnimationDuration:0.1];  // 秒かけてアニメーションを終了させる
        // [UIView setAnimationDelay:3.0];  // 秒後にアニメーションを開始する
        // [UIView setAnimationRepeatCount:5.0];  // アニメーションを5回繰り返す
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];  // アニメーションは一定速度
        //self.view.center = CGPointMake(-3/2*kScrollObjWidth, 1/2*kScrollObjHeight);  // 終了位置を200,400の位置に指定する
//        self.view.transform = CGAffineTransformMakeTranslation(-(k-2)*kScrollObjWidth, 0);
        uv.transform = CGAffineTransformMakeTranslation(-(k-2)*kScrollObjWidth, 0);
        
        [UIView commitAnimations];  // アニメーション開始
        
        k = k - 1;
        
        }else{
        
        k = 1;
    }
}


//1119
-(void)forward{
    NSLog(@"forwardボタンが押されました");
    
    if (k <= kNumImages-1) {
        
        [UIView beginAnimations:nil context:nil];  // 条件指定開始
        [UIView setAnimationDuration:0.1];  // 2秒かけてアニメーションを終了させる
        // [UIView setAnimationDelay:3.0];  // 3秒後にアニメーションを開始する
        // [UIView setAnimationRepeatCount:5.0];  // アニメーションを5回繰り返す
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];  // アニメーションは一定速度
        //self.view.center = CGPointMake(-3/2*kScrollObjWidth, 1/2*kScrollObjHeight);  // 終了位置を200,400の位置に指定する
        //self.view.transform = CGAffineTransformMakeTranslation(-k*kScrollObjWidth, 0);
        uv.transform = CGAffineTransformMakeTranslation(-k*kScrollObjWidth, 0);

        [UIView commitAnimations];  // アニメーション開始

        k++;
 
        }else{
        
        k = kNumImages;
    }

}



//1116
-(void)add{
    NSLog(@"addボタンが押されました");
    
    j++;//1119
    
    //1119現在のページを取得
    UIImageView *imgview = (UIImageView*)[self.view viewWithTag:k];

    /* ビューを作成 */
    CGRect rect = CGRectMake(160+j, 100+j, 20, 30);
    pinImageView = [[UIImageView alloc]initWithFrame:rect];
    //myView.backgroundColor = [UIColor blueColor];
    pinImageView.image = [UIImage imageNamed:@"pin.png"];
    pinImageView.userInteractionEnabled = YES;
    pinImageView.tag = j;//1119
    [imgview addSubview:pinImageView];
    
    
    
//    /* ドラッグ */
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(view_Dragged:)];
//    // ビューにジェスチャーを追加
//    [imgview addGestureRecognizer:pan];
    

}



// ユーザがドラッグしたときに呼び出されるメソッド//1119
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    //1119現在のページを取得
    UIImageView *imgview = (UIImageView*)[uv viewWithTag:k];
    
    //ユーザがドラッグした座標を取得
    CGPoint point = [((UITouch*)[touches anyObject]) locationInView:imgview];
    NSLog(@"ドラッグ x:%f, y:%f", point.x, point.y);

    
    if([touch view] == imgview){
    
    }else{
        
        UIImageView* imgview1 = (UIImageView*)[touch view];
        
        UIImageView* spe_imgview = (UIImageView*)[imgview viewWithTag:imgview1.tag];
        
        spe_imgview.transform = CGAffineTransformMakeTranslation(point.x - spe_imgview.center.x , point.y - spe_imgview.center.y);
    }
}



//-(void)view_Dragged:(UIPanGestureRecognizer *)sender{
//    
//    // ユーザがドラッグした座標を取得
//    CGPoint point = [sender translationInView:imageView];
//    
//    CGPoint movedPoint = CGPointMake(pinImageView.center.x + point.x ,pinImageView.center.y + point.y);
//    
//    pinImageView.center = movedPoint;
//    
//    [sender setTranslation:CGPointZero inView:imageView];
//    
//}


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
