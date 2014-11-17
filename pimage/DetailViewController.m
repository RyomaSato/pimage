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
    NSUInteger kNumImages;    //総page数
    UIImageView *imageView;//1116試し
    UIImageView *pinImageView;//1117
    
}

const CGFloat kScrollObjHeight = 568.0;//1pageの高さ
const CGFloat kScrollObjWidth  = 320.0;//1pageの幅



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    
    //ボタン生成1116途中
    UIBarButtonItem *nvgRightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = nvgRightBarButton;
    
    
    
    
    
    
    
    
    
    
    
    

    
    
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

//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView = [[UIImageView alloc] initWithImage:image];//1116(試し)
     
        //タッチの検出を有効にする
        imageView.userInteractionEnabled = YES;
        
        CGRect rect = imageView.frame;
        rect.size.height = kScrollObjHeight;
        rect.size.width = kScrollObjWidth;
        imageView.frame = rect;
        imageView.tag = i;
        
        [scrollView addSubview:imageView];
        
        
    }
    
    [self layoutScrollImages];

    //toolbarを隠す
    [self.navigationController setToolbarHidden:YES animated:NO];
}


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



//1116途中
-(void)add{
    NSLog(@"addボタンが押されました");
   
    /* ビューを作成 */
    CGRect rect = CGRectMake(160, 100, 20, 30);
    pinImageView = [[UIImageView alloc]initWithFrame:rect];
    //myView.backgroundColor = [UIColor blueColor];
    pinImageView.image = [UIImage imageNamed:@"pin.png"];
    pinImageView.userInteractionEnabled = YES;
    [imageView addSubview:pinImageView];
    
    /* ドラッグ */
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(view_Dragged:)];
    // ビューにジェスチャーを追加
    [imageView addGestureRecognizer:pan];
    
    
}


-(void)view_Dragged:(UIPanGestureRecognizer *)sender{
    
    // ユーザがドラッグした座標を取得
    CGPoint point = [sender translationInView:imageView];
    
    CGPoint movedPoint = CGPointMake(pinImageView.center.x + point.x ,pinImageView.center.y + point.y);
    
    pinImageView.center = movedPoint;
    
    [sender setTranslation:CGPointZero inView:imageView];
    
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
