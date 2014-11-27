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
    NSInteger pinSum;//1127
    
}

const CGFloat kScrollObjHeight = 524.0;//1pageの高さ
const CGFloat kScrollObjWidth  = 320.0;//1pageの幅



////戻るボタンの認識
- (void)viewWillDisappear:(BOOL)animated
{
    if (![self.navigationController.viewControllers containsObject:self]) {
        //戻るを押された
        NSLog(@"back");
        
//////////////////////////////////////////////////////////////////////////////////////////////1126(途中)
        for (int l = 1; l <= kNumImages; l++) {
            NSUInteger i;
            for (i = kNumImages + 1; i <= j; i++) {
            
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
             
//                NSDictionary *documentData = [defaults dictionaryForKey:@"documentData"];
//                NSDictionary *imageData = [defaults dictionaryForKey:@"imageData"];
                NSDictionary *pinData = [defaults dictionaryForKey:@"pinData"];
               
                NSDictionary *temp_zero_dictionary = [defaults dictionaryForKey:@"folder"];
                NSMutableDictionary *zero_dictionary = temp_zero_dictionary.mutableCopy;
                
                NSDictionary *temp_first_dictionary = [temp_zero_dictionary objectForKey:_documentDataKey];
                NSMutableDictionary *first_dictionary = temp_first_dictionary.mutableCopy;

                NSDictionary *temp_second_dictionary = [first_dictionary objectForKey:@"imageList"];
                NSMutableDictionary *second_dictionary = temp_second_dictionary.mutableCopy;

                NSString *number = [NSString stringWithFormat:@"%d", l];
                NSDictionary *temp_third_dictionary = [second_dictionary objectForKey:number];
                NSMutableDictionary *third_dictionary = temp_third_dictionary.mutableCopy;
                
//                NSDictionary *temp_fourth_dictionary = [[NSMutableDictionary alloc] initWithDictionary:pinData];
                NSDictionary *temp_fourth_dictionary = [[NSMutableDictionary alloc] initWithDictionary:pinData];
                NSMutableDictionary *fourth_dictionary = temp_fourth_dictionary.mutableCopy;

                NSDictionary *temp_fifth_dictionary = [[NSMutableDictionary alloc] init];
                NSMutableDictionary *fifth_dictionary = temp_fifth_dictionary.mutableCopy;

//                UIImageView *Pin_imgview = (UIImageView*)[imageView viewWithTag:i];
                UIImageView *Image_imgview = (UIImageView*)[uv viewWithTag:l];
                UIImageView *Pin_imgview = (UIImageView*)[Image_imgview viewWithTag:i];

                NSLog(@"選択されたピンのtagナンバー%ld",Pin_imgview.tag);
                
                    if (Pin_imgview.tag == i) {
                
                        NSString *PinNum = [NSString stringWithFormat:@"%ld", i];
                
                        float x = Pin_imgview.frame.origin.x;
                        NSNumber *position_x = [[NSNumber alloc]initWithFloat:x];
                        float y = Pin_imgview.frame.origin.y;
                        NSNumber *position_y = [[NSNumber alloc]initWithFloat:y];
                
                        [fifth_dictionary setObject:position_x forKey:@"position_x"];
                        [fifth_dictionary setObject:position_y forKey:@"position_y"];
                
                        [fourth_dictionary setObject:fifth_dictionary forKey:PinNum];
                        
                        pinData = fourth_dictionary;
                        
                        [defaults setObject:pinData forKey:@"pinData"];
                        
                        [third_dictionary setObject:fourth_dictionary forKey:@"pinList"];
                        
//                        imageData = third_dictionary;
//                        [defaults setObject:imageData forKey:@"imageData"];
                        
//                        [second_dictionary setObject:third_dictionary forKey:@"image"];
                        [second_dictionary setObject:third_dictionary forKey:number];
                        
                        [first_dictionary setObject:second_dictionary forKey:@"imageList"];
                        
                        [zero_dictionary setObject:first_dictionary forKey:_documentDataKey];
                        
                        [defaults setObject:zero_dictionary forKey:@"folder"];
                        [defaults synchronize];
                
                
                    }else{
                    }
            }
        //////////////////////////////////////////////////////pinDataの初期化
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *pinData = [defaults dictionaryForKey:@"pinData"];
            NSMutableDictionary *init_pinData = [[NSMutableDictionary alloc] initWithDictionary:pinData];
            
            [init_pinData removeAllObjects];
            
            pinData = init_pinData;
            
            [defaults setObject:pinData forKey:@"pinData"];
            [defaults synchronize];
        ///////////////////////////////////////////////////////////////////////////////////////////////////////
        }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    }
    
    [super viewWillDisappear:animated];
}






- (void)viewWillAppear:(BOOL)animated  {


/////////////////////////////////////////////////////////////////////////////////1127
    NSInteger i;
    for (i = 1; i <= kNumImages; i++) {
    NSString *number = [NSString stringWithFormat:@"%ld", i];
    NSDictionary *imageDictionary = [_documentImageList objectForKey:number];//1126
    NSDictionary *pin = [imageDictionary objectForKey:@"pinList"];//1126
    pinSum = pinSum + pin.count;
    }
    
    NSLog(@"pinSum=%ld",pinSum);
    
//    NSUInteger i;
    for (i = 1; i <= kNumImages; i++)
    {
        NSString *number = [NSString stringWithFormat:@"%ld", i];
        NSDictionary *imageDictionary = [_documentImageList objectForKey:number];//1126
        UIImageView *Image_imgview = (UIImageView*)[uv viewWithTag:i];
        NSDictionary *pin = [imageDictionary objectForKey:@"pinList"];//1126

        NSUInteger m;//1127
//        for (m = kNumImages+1; m <= pin.count+kNumImages; m++) {
        for (m = kNumImages+1; m <= pinSum+kNumImages; m++) {
            NSString *no_pin = [NSString stringWithFormat:@"%ld", m];
            NSDictionary *pin_detail = [pin objectForKey:no_pin];
      
        if (pin_detail) {
         
            NSNumber *position_x = [pin_detail objectForKey:@"position_x"];
            NSNumber *position_y = [pin_detail objectForKey:@"position_y"];
    
            CGFloat x = position_x.floatValue;
            CGFloat y = position_y.floatValue;
    
            /* ビューを作成 */
            CGRect rect = CGRectMake(x, y, 20, 30);
            UIImageView *will_pinImageView = [[UIImageView alloc]initWithFrame:rect];
            //myView.backgroundColor = [UIColor blueColor];
            will_pinImageView.image = [UIImage imageNamed:@"pin.png"];
            will_pinImageView.userInteractionEnabled = YES;
            will_pinImageView.tag = m;//1119
            [Image_imgview addSubview:will_pinImageView];
        
        }
        }
    }
///////////////////////////////////////////////////////////////////////////////////////////

    
    //kの初期値設定1119
    k = 1;
    
    //jの初期値設定(ページと数字がかぶらないように設定)1119
    j = kNumImages;
    
    for (int i; i<=kNumImages; i++) {
    
    NSString *number = [NSString stringWithFormat:@"%d", i];
    NSDictionary *imageDictionary = [_documentImageList objectForKey:number];//1126
    NSDictionary *pin = [imageDictionary objectForKey:@"pinList"];//1126
   
    j = j + pin.count;

    }
    
    NSLog(@"ピンのtag初期値%ld",j);
}






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
    //総ページ数の取得
    kNumImages = _documentImageList.count;
    NSLog(@"総ページ数%ld",kNumImages);
    
    // UIViewの生成1119
    uv = [[UIView alloc] initWithFrame:CGRectMake(0,64,kScrollObjWidth*kNumImages,kScrollObjHeight)];//(navigationBarが上から64)
    [self.view addSubview:uv];
    
//    //kの初期値設定1119
//    k = 1;
//    //jの初期値設定(ページと数字がかぶらないように設定)1119
//    j = kNumImages;
    
    
    [self setButton];

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
        NSDictionary *imageDictionary = [_documentImageList objectForKey:number];//1126
//        NSString *imageName = [_documentImageList objectForKey:number];
        NSString *imageName = [imageDictionary objectForKey:@"fileName"];//1126
        
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



//ボタン生成//1119
-(void)setButton{
    
    //ナビゲーションボタン作成1116
    UIBarButtonItem *nvgRightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = nvgRightBarButton;
    
    //ツールバーボタンの作成
    //スペーサーの作成
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *toolLeftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(back)];
    
    UIBarButtonItem *toolRightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(forward)];
    
    NSArray *items = [NSArray arrayWithObjects:spacer, toolLeftBarButton, spacer, spacer, spacer, toolRightBarButton, spacer, nil];
    self.toolbarItems = items;

    
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
            frame.origin = CGPointMake(curXLoc, 0);
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
        // self.view.transform = CGAffineTransformMakeTranslation(-(k-2)*kScrollObjWidth, 0);
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
    NSLog(@"現在のピンのtagナンバー%ld",j);
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
        
        UIImageView* touch_imgview = (UIImageView*)[touch view];
        
        UIImageView* spe_imgview = (UIImageView*)[imgview viewWithTag:touch_imgview.tag];
        
        spe_imgview.transform = CGAffineTransformMakeTranslation(point.x - spe_imgview.center.x , point.y - spe_imgview.center.y);
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
