//
//  InfoViewController.m
//  pimage
//
//  Created by 佐藤凌馬 on 2014/12/18.
//  Copyright (c) 2014年 RyomaSato. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController{
    UIScrollView *scrollView;
    UIPageControl *pageControl;
   }
const CGFloat info_kScrollObjHeight = 568.0;//(※1)1pageの高さ
const CGFloat info_kScrollObjWidth  = 320.0;//(※2)1pageの幅
const NSUInteger info_kNumImages    = 6;    //(※3)総page数


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
            frame.origin = CGPointMake(curXLoc + 18, 64);
            view.frame = frame;
            
            curXLoc += (info_kScrollObjWidth);
        }
    }
    
    //スクロールの総範囲
    [scrollView setContentSize:CGSizeMake((info_kNumImages * info_kScrollObjWidth), info_kScrollObjHeight)];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setToolbarHidden:YES animated:NO];

    //ScrollViewの生成と設定
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    // 横スクロールのインジケータを非表示にする
    scrollView.showsHorizontalScrollIndicator = NO;
    //ページングを有効にする
    scrollView.pagingEnabled = YES;
    //タッチの検出を有効にする
    scrollView.userInteractionEnabled = YES;
    
    
    [self.view addSubview:scrollView];
    
     
//    //PageControlの生成と設定
//    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 450, 320, 30)];
//    pageControl.numberOfPages = kNumImages;
//    // 現在のページを0に初期化する。
//   // pageControl.currentPage = 0;
//    
//    //背景色の設定
//    pageControl.backgroundColor = [UIColor blackColor];
//    
//    // ページコントロールをタップされたときに呼ばれるメソッドを設定
//    //タッチの検出を有効にする
//    pageControl.userInteractionEnabled = YES;
//    [pageControl addTarget:self action:@selector(pageControl_Tapped:)forControlEvents:UIControlEventValueChanged];
//        
//    [self.view addSubview:pageControl];
   
    //self.viewのcolor変更
    self.view.backgroundColor = [UIColor colorWithRed:0.122 green:0.122 blue:0.122 alpha:1.0];

    
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,10,90,25)];
        label.text = [NSString stringWithFormat:@"tutorial"];
        label.font = [UIFont fontWithName:@"Arial" size:20];
        label.textColor = [UIColor whiteColor];
        // label.backgroundColor = [UIColor yellowColor];
        label.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = label;

    

    NSUInteger i;
    
    for (i = 1; i <= info_kNumImages; i++)
    {
        NSString *imageName = [NSString stringWithFormat:@"tutorial%ld.png", i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        CGRect rect = imageView.frame;
        rect.size.height = 504;//kScrollObjHeight;
        rect.size.width = 284;//kScrollObjWidth;
        imageView.frame = rect;
        imageView.tag = i;
        
        [scrollView addSubview:imageView];
        
        
   
        
        
        
//        //ボタン生成
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
//        btn.frame = CGRectMake(80, 80, 50, 30);
//        
//        [imageView addSubview:btn];

//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        btn.frame = CGRectMake(280, 20, 50, 30);
//        [btn setTitle:@"close" forState:UIControlStateNormal];
//        UIImage *img = [UIImage imageNamed:@"info_back.png"];  // ボタンにする画像を生成する
//        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(300, 20, 20, 20)];  // ボタンのサイズを指定する
//        [btn setBackgroundImage:img forState:UIControlStateNormal];  // 画像をセットする
////        // ボタンが押された時にメソッドを呼び出す
//        btn.userInteractionEnabled = YES;
//        [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//        [imageView addSubview:btn];
        
        
    }
    
    [self layoutScrollImages];
    
}



//- (void)pageControl_Tapped:(id)sender
//{
//    CGRect frame = scrollView.frame;
//    frame.origin.x = frame.size.width * pageControl.currentPage;
//    [scrollView scrollRectToVisible:frame animated:YES];
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
