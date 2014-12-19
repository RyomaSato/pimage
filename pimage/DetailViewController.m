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
 
   // IBOutlet UIScrollView *scrollView;//1201
    NSUInteger kNumImages;//総page数
   //1202 UIImageView *imageView;//1116
    UIImageView *pinImageView;//1117
    NSInteger k;//1119
    NSInteger j;//1119
    UIView *uv;//1202
    NSInteger pinSum;//1127(多分いらない1201)
    UIView *_backView;//1201
    BOOL _commentFlag;//1201
    BOOL _dragFlag;//1201
    UITextView *commentView;
    NSInteger spe_num;//1207
    
    UIView *_toolview;//1207
    
}



const CGFloat kScrollObjHeight = 460.0;//1pageの高さ
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

//1205
//                NSDictionary *temp_fourth_dictionary = [[NSMutableDictionary alloc] initWithDictionary:pinData];//pinDataいらないかも
//                NSMutableDictionary *fourth_dictionary = temp_fourth_dictionary.mutableCopy;

                
                //1205
                NSDictionary *temp_fourth_dictionary = [third_dictionary objectForKey:@"pinList"];
                NSMutableDictionary *fourth_dictionary = temp_fourth_dictionary.mutableCopy;

                
                
                
                
                
                //if文で4th&5thDictionaryの初期設定をする(それぞれのDictionaryがnillのとき)1206
                if(!fourth_dictionary){
                    
                    NSDictionary *temp_init_fourth_dictionary = [[NSMutableDictionary alloc] init];
                    NSMutableDictionary *init_fourth_dictionary = temp_init_fourth_dictionary.mutableCopy;
                    
                    fourth_dictionary = init_fourth_dictionary;
                    
                }else{
                    
                }

                
                
   
//1204
//                NSDictionary *temp_fifth_dictionary = [[NSMutableDictionary alloc] init];
//                NSMutableDictionary *fifth_dictionary = temp_fifth_dictionary.mutableCopy;

                
                
                
//                UIImageView *Pin_imgview = (UIImageView*)[imageView viewWithTag:i];

                
                UIImageView *Image_imgview = (UIImageView*)[uv viewWithTag:l];
//                UIImageView *Image_imgview = (UIImageView*)[scrollView viewWithTag:l];//1201

                UIImageView *Pin_imgview = (UIImageView*)[Image_imgview viewWithTag:i];

                NSLog(@"選択されたピンのtagナンバー%ld",Pin_imgview.tag);
                
                    if (Pin_imgview.tag == i) {
                
                        NSString *PinNum = [NSString stringWithFormat:@"%ld", i];
                        
                        float x = Pin_imgview.frame.origin.x;
                        NSNumber *position_x = [[NSNumber alloc]initWithFloat:x];
                        float y = Pin_imgview.frame.origin.y;
                        NSNumber *position_y = [[NSNumber alloc]initWithFloat:y];
                
                        NSDictionary *temp_fifth_dictionary = [fourth_dictionary objectForKey:PinNum];
                        NSMutableDictionary *fifth_dictionary = temp_fifth_dictionary.mutableCopy;
       //                 NSString *comment = [fifth_dictionary objectForKey:@"comment"];

                       
                     
                        
                        
                        
                        
                        
                        //if文で4th&5thDictionaryの初期設定をする(それぞれのDictionaryがnillのとき)1206
                        if(!fifth_dictionary){
                            
                            NSDictionary *temp_init_fifth_dictionary = [[NSMutableDictionary alloc] init];
                            NSMutableDictionary *init_fifth_dictionary = temp_init_fifth_dictionary.mutableCopy;
                            
                            fifth_dictionary = init_fifth_dictionary;
                            
                        }else{
                            
                        }
                        
                        
                        
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
                        
                        
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm1201(あとで)
                        //ピンtagの最大No.を格納(1201)
                        if (i==j) {
                            
                            NSInteger tag_max = i;
                            [first_dictionary setObject:[NSNumber numberWithInteger:tag_max] forKey:@"tag_max"];
                            
                        }
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

                        
                        [zero_dictionary setObject:first_dictionary forKey:_documentDataKey];
                        
                        [defaults setObject:zero_dictionary forKey:@"folder"];
                        [defaults synchronize];
                
                        
                    }else{
                    }
            
            }
            
            
//1205
//        //////////////////////////////////////////////////////pinDataの初期化
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            NSDictionary *pinData = [defaults dictionaryForKey:@"pinData"];
//            NSMutableDictionary *init_pinData = [[NSMutableDictionary alloc] initWithDictionary:pinData];
//            
//            [init_pinData removeAllObjects];
//            
//            pinData = init_pinData;
//            
//            [defaults setObject:pinData forKey:@"pinData"];
//            [defaults synchronize];
//        ///////////////////////////////////////////////////////////////////////////////////////////////////////
        
        
        
        }
        

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    }
    
    [super viewWillDisappear:animated];
}






- (void)viewWillAppear:(BOOL)animated  {


/////////////////////////////////////////////////////////////////////////////////1127
//    NSInteger i;
//    for (i = 1; i <= kNumImages; i++) {
//    NSString *number = [NSString stringWithFormat:@"%ld", i];
//    NSDictionary *imageDictionary = [_documentImageList objectForKey:number];//1126
//    NSDictionary *pin = [imageDictionary objectForKey:@"pinList"];//1126
//    pinSum = pinSum + pin.count;
//    }
//    NSLog(@"pinSum=%ld",pinSum);

    
    
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm1201(あとで)
    //ピンtagの最大No.使った方が賢い
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *zero_dictionary = [defaults dictionaryForKey:@"folder"];
    NSDictionary *first_dictionary = [zero_dictionary objectForKey:_documentDataKey];
    NSNumber *nun_tag_max = [first_dictionary objectForKey:@"tag_max"];
    NSInteger int_tag_max = nun_tag_max.integerValue;
    
    
    NSLog(@"pintag_max=%ld",int_tag_max);
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    
    
    
    NSUInteger i;
    for (i = 1; i <= kNumImages; i++)
    {
        NSString *number = [NSString stringWithFormat:@"%ld", i];
        NSDictionary *imageDictionary = [_documentImageList objectForKey:number];//1126
        
        
        UIImageView *Image_imgview = (UIImageView*)[uv viewWithTag:i];
        //UIImageView *Image_imgview = (UIImageView*)[scrollView viewWithTag:i];//1201

        
        NSDictionary *pin = [imageDictionary objectForKey:@"pinList"];//1126

        NSUInteger m;//1127
//        for (m = kNumImages+1; m <= pin.count+kNumImages; m++) {

//1207        for (m = kNumImages+1; m <= pinSum+kNumImages; m++) {
        for (m = kNumImages+1; m <= int_tag_max+kNumImages; m++) {
            NSString *no_pin = [NSString stringWithFormat:@"%ld", m];
            NSDictionary *pin_detail = [pin objectForKey:no_pin];
      
            if (pin_detail) {
         
                NSNumber *position_x = [pin_detail objectForKey:@"position_x"];
                NSNumber *position_y = [pin_detail objectForKey:@"position_y"];
    
                CGFloat x = position_x.floatValue;
                CGFloat y = position_y.floatValue;
    
                /* ビューを作成 */
                CGRect rect = CGRectMake(x, y, 24, 36);
                UIImageView *will_pinImageView = [[UIImageView alloc]initWithFrame:rect];
                //myView.backgroundColor = [UIColor blueColor];
                will_pinImageView.image = [UIImage imageNamed:@"pin_blue.png"];
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
    j = int_tag_max;
    
    if(j == 0){
        j = kNumImages;
    }else{
    }
    
    ///////////////////////////////////////////////////////////tag_maxを使った方がいい!!!!!!!!!!!!!!!!!!!!!!!!
//    for (int i; i<=kNumImages; i++) {
//    
//    NSString *number = [NSString stringWithFormat:@"%d", i];
//    NSDictionary *imageDictionary = [_documentImageList objectForKey:number];//1126
//    NSDictionary *pin = [imageDictionary objectForKey:@"pinList"];//1126
//   
//    j = j + pin.count;
//
//    }
    
    NSLog(@"ピンのtag初期値%ld",j);
    //toolbarを隠す
    [self.navigationController setToolbarHidden:YES animated:NO];
    

}






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
    //コメントビューを作成
    [self createView];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,10,90,25)];
    label.text = [NSString stringWithFormat:@"pimage"];
    label.font = [UIFont fontWithName:@"Arial" size:20];
    label.textColor = [UIColor whiteColor];
    // label.backgroundColor = [UIColor yellowColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    
    // テキストビュー(後で1201)
    CGRect rect = CGRectMake(0, 0, 320, 122);
    commentView = [[UITextView alloc] initWithFrame:rect];
    commentView.editable = YES;
//    commentView.text = @"あいうえお\nかきくけこ";
    [_backView addSubview:commentView];

    
    //総ページ数の取得
    kNumImages = _documentImageList.count;
    NSLog(@"総ページ数%ld",kNumImages);
    

//    //kの初期値設定1119
//    k = 1;
//    //jの初期値設定(ページと数字がかぶらないように設定)1119
//    j = kNumImages;
    
   
    
    //UIView_uvの生成1119
    uv = [[UIView alloc] initWithFrame:CGRectMake(0,64,kScrollObjWidth*kNumImages,kScrollObjHeight)];//(navigationBarが上から64)
    uv.backgroundColor = [UIColor colorWithRed:0.122 green:0.122 blue:0.122 alpha:1.0];
    [self.view addSubview:uv];
    //[scrollView addSubview:uv];
    
    
    //UIView_toolviewの生成1207
    _toolview = [[UIView alloc] initWithFrame:CGRectMake(0, 524, self.view.bounds.size.width, 44)];
//    _toolview.backgroundColor = [UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0];
    [self.view addSubview:_toolview];
    
    
    
//    //ゴミ箱領域の設定1207
//    UILabel *trash = [[UILabel alloc] init];
//    trash.frame = CGRectMake(220, 10, 100, 30);
//    trash.backgroundColor = [UIColor grayColor];
////    label.textColor = [UIColor blueColor];
////    label.font = [UIFont fontWithName:@"AppleGothic" size:12];
//    trash.text = @"___trasharea";
//    [_toolview addSubview:trash];
    
    
    //ゴミ箱領域の設定1214
    UIImage *img_trash = [UIImage imageNamed:@"trash_area.png"];
    UIImageView *iv_trash = [[UIImageView alloc] initWithImage:img_trash];
    iv_trash.frame = CGRectMake(210, 5, 100, 34);
    [_toolview addSubview:iv_trash];


    
    
    [self setButton];

    

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

        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];//1202
        //imageView = [[UIImageView alloc] initWithImage:image];//1116(試し)
     
        //タッチの検出を有効にする
        imageView.userInteractionEnabled = YES;
        
        CGRect rect = imageView.frame;
        rect.size.height = kScrollObjHeight-34;//1216
        rect.size.width = kScrollObjWidth;
        imageView.frame = rect;
        imageView.tag = i;
        
        [uv addSubview:imageView];//1119
      //  [scrollView addSubview:imageView];//1201
        
    }

    [self layoutScrollImages];

    //toolbarを隠す
    [self.navigationController setToolbarHidden:YES animated:NO];
    
}



//ボタン生成//1119
-(void)setButton{
    
////    //ナビゲーションボタン作成1116
//    UIBarButtonItem *nvgRightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
//    self.navigationItem.rightBarButtonItem = nvgRightBarButton;
    
    
    //ナビゲーションボタン作成1214
    UIButton *uibtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibtn.frame = CGRectMake(0, 0, 36, 36);
    UIImage *img_add_pin = [UIImage imageNamed:@"add_pin.png"];  // ボタンにする画像を生成する
    [uibtn setBackgroundImage:img_add_pin forState:UIControlStateNormal];  // 画像をセットする
    [uibtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *nvgRightBarButton =[[UIBarButtonItem alloc] initWithCustomView:uibtn];
    self.navigationItem.rightBarButtonItem = nvgRightBarButton;
    
    
    
    //ツールバーボタンの作成
//    //スペーサーの作成
//    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    
//    UIBarButtonItem *toolLeftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(back)];
//    
//    UIBarButtonItem *toolRightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(forward)];
//    
//    NSArray *items = [NSArray arrayWithObjects:spacer, toolLeftBarButton, spacer, spacer, spacer, toolRightBarButton, spacer, nil];
//    self.toolbarItems = items;
    
    
    UIButton *toolLeftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    toolLeftButton.frame = CGRectMake(34, 5, 36, 36);
    UIImage *img_back = [UIImage imageNamed:@"back.png"];  // ボタンにする画像を生成する
    [toolLeftButton setBackgroundImage:img_back forState:UIControlStateNormal];  // 画像をセットする
    //[toolLeftButton setTitle:@"back" forState:UIControlStateNormal];
    // ボタンがタッチダウンされた時にメソッドを呼び出す
    [toolLeftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
    [_toolview addSubview:toolLeftButton];
    
    UIButton *toolRightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    toolRightButton.frame = CGRectMake(125, 5, 36, 36);
    UIImage *img_forward = [UIImage imageNamed:@"forward.png"];  // ボタンにする画像を生成する
    [toolRightButton setBackgroundImage:img_forward forState:UIControlStateNormal];  // 画像をセットする
    //[toolRightButton setTitle:@"forward" forState:UIControlStateNormal];
    // ボタンがタッチダウンされた時にメソッドを呼び出す
    [toolRightButton addTarget:self action:@selector(forward) forControlEvents:UIControlEventTouchDown];
    [_toolview addSubview:toolRightButton];
    
}



- (void)layoutScrollImages
{
    UIImageView *view = nil;

    NSArray *subviews = [uv subviews];
//   NSArray *subviews = [scrollView subviews];//1201

    CGFloat curXLoc = 0;
    for (view in subviews)
    {
        if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
        {
            CGRect frame = view.frame;
            frame.origin = CGPointMake(curXLoc, 17);//1216
            view.frame = frame;
            
            curXLoc += (kScrollObjWidth);
        }
    }
    
    //スクロールの総範囲
//    [scrollView setContentSize:CGSizeMake((kNumImages * kScrollObjWidth), kScrollObjHeight)];
//    [scrollView setContentSize:CGSizeMake(kNumImages, kScrollObjHeight+64)];//1201

    
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
        //scrollView.transform = CGAffineTransformMakeTranslation(-(k-2)*kScrollObjWidth, 0);//1201
  
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
        //scrollView.transform = CGAffineTransformMakeTranslation(-k*kScrollObjWidth, 0);//1201

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
    CGRect rect = CGRectMake(160+j, 100+j, 24, 36);
    pinImageView = [[UIImageView alloc]initWithFrame:rect];
    //myView.backgroundColor = [UIColor blueColor];
    pinImageView.image = [UIImage imageNamed:@"pin_blue.png"];
    pinImageView.userInteractionEnabled = YES;
    pinImageView.tag = j;//1119
    [imgview addSubview:pinImageView];

}



// ユーザがドラッグしたときに呼び出されるメソッド//1119
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    //1119現在のページを取得
    UIImageView *imgview = (UIImageView*)[uv viewWithTag:k];
//    UIImageView *imgview = (UIImageView*)[scrollView viewWithTag:k];//1201
 
    //ユーザがドラッグした座標を取得
    CGPoint point = [((UITouch*)[touches anyObject]) locationInView:imgview];
    NSLog(@"ドラッグ x:%f, y:%f", point.x, point.y);
    
    if([touch view] == imgview){
        
        //imgview.transform = CGAffineTransformMakeTranslation(0 , point.y - imgview.center.y);//これに拘束条件を入れる
    
    }else{
        
        UIImageView* touch_imgview = (UIImageView*)[touch view];
        
        UIImageView* spe_imgview = (UIImageView*)[imgview viewWithTag:touch_imgview.tag];
        
        spe_imgview.transform = CGAffineTransformMakeTranslation(point.x - spe_imgview.center.x , point.y - spe_imgview.center.y);
    
        _dragFlag = YES;
    
    }
    
}




// ユーザがタッチが終了したときに呼び出されるメソッド//1201
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    //現在のページを取得
    UIImageView *imgview = (UIImageView*)[uv viewWithTag:k];
//    UIImageView *imgview = (UIImageView*)[scrollView viewWithTag:k];//1201
 
    
    
//    
//    //uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu1201
//    //ScrollViewの生成と設定
//    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,kScrollObjWidth*kNumImages,kScrollObjHeight)];
//    // 横スクロールのインジケータを非表示にする
//    scrollView.showsHorizontalScrollIndicator = NO;
//    //ページングを有効にする
//    scrollView.pagingEnabled = NO;
//    //タッチの検出を有効にする
//    scrollView.userInteractionEnabled = NO;
//    scrollView.bounces = NO;
//    
//    //    [uv addSubview:scrollView];
//    [self.view addSubview:scrollView];
//    //uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu
//    [scrollView addSubview:uv];

    
    //キーボード削除
    [commentView resignFirstResponder];
    
    
    if([touch view] == imgview || [touch view] == _toolview || [touch view] == uv){
    
    }else{
        
        UIImageView* touch_imgview = (UIImageView*)[touch view];
        UIImageView* spe_imgview = (UIImageView*)[imgview viewWithTag:touch_imgview.tag];
        
        NSLog(@"%ld",spe_imgview.tag);
        
//iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii__1201
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        
       
        
        if (_dragFlag) {
            
           
            
            
            
            //1207pinの移動可能範囲指定(ゴミ箱にドラッグ&ドロップ)
            CGPoint point = [((UITouch*)[touches anyObject]) locationInView:self.view];
            
            if (point.y < 84){
                NSLog(@"%ld",spe_imgview.tag);
                spe_imgview.transform = CGAffineTransformMakeTranslation(point.x - spe_imgview.center.x , 15 - spe_imgview.center.y);
                
            }else if (point.y > 507){
             
                if ((point.y > 524) && (point.x > self.view.bounds.size.width - 110) && (self.view.bounds.size.width > point.x)) {
                    
                    [spe_imgview removeFromSuperview];
                 
                    
                    //pinのデータ削除
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    NSDictionary *zero_dictionary = [defaults dictionaryForKey:@"folder"];
                    NSMutableDictionary *edit_zero_dictionary = zero_dictionary.mutableCopy;

                    NSDictionary *first_dictionary = [edit_zero_dictionary objectForKey:_documentDataKey];
                    NSMutableDictionary *edit_first_dictionary = first_dictionary.mutableCopy;

                    NSDictionary *second_dictionary = [edit_first_dictionary objectForKey:@"imageList"];
                    NSMutableDictionary *edit_second_dictionary = second_dictionary.mutableCopy;
  
                    NSString *number = [NSString stringWithFormat:@"%ld", k];
                    NSDictionary *third_dictionary = [edit_second_dictionary objectForKey:number];
                    NSMutableDictionary *edit_third_dictionary = third_dictionary.mutableCopy;
                    
                    NSDictionary *fourth_dictionary = [edit_third_dictionary objectForKey:@"pinList"];
                    NSMutableDictionary *edit_fourth_dictionary = fourth_dictionary.mutableCopy;
                    NSString *PinNum = [NSString stringWithFormat:@"%ld",spe_imgview.tag];
                    
                    [edit_fourth_dictionary removeObjectForKey:PinNum];
                    
                    [edit_third_dictionary setObject:edit_fourth_dictionary forKey:@"pinList"];
                    [edit_second_dictionary setObject:edit_third_dictionary forKey:number];
                    
                    [edit_first_dictionary setObject:edit_second_dictionary forKey:@"imageList"];
                    
                    [edit_zero_dictionary setObject:edit_first_dictionary forKey:_documentDataKey];
                    
                    [defaults setObject:edit_zero_dictionary forKey:@"folder"];
                    [defaults synchronize];
                    
                    return;
                
                }
                spe_imgview.transform = CGAffineTransformMakeTranslation(point.x - spe_imgview.center.x , 410 -spe_imgview.center.y);
            
            }else{
            }
            
            
          
            
            
            
        }else{
        
            if (!_commentFlag) {
                
                //ピンの選択
                spe_imgview.image = [UIImage imageNamed:@"pin_red.png"];//1207
            
                imgview.frame = CGRectMake(kScrollObjWidth*(imgview.tag-1), 78, kScrollObjWidth, kScrollObjHeight-34);
                _backView.frame = CGRectMake(0, 20, self.view.bounds.size.width, 122);
               
                //1207
                _toolview.frame = CGRectMake(0, 564, self.view.bounds.size.width, 44);

                [self.view bringSubviewToFront:_backView];
                
                
                
                //Navigation_&_ToolBar非表示
                [self.navigationController setNavigationBarHidden:YES animated:YES];//1203
                [self.navigationController setToolbarHidden:YES animated:YES];//1203

            
                //scrollView.userInteractionEnabled = YES;//1201
                _commentFlag = YES;
                
                
                
                
                
                //コメント表示
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSDictionary *zero_dictionary = [defaults dictionaryForKey:@"folder"];
                NSDictionary *first_dictionary = [zero_dictionary objectForKey:_documentDataKey];
                NSDictionary *second_dictionary = [first_dictionary objectForKey:@"imageList"];
                NSString *number = [NSString stringWithFormat:@"%ld", k];
                NSDictionary *third_dictionary = [second_dictionary objectForKey:number];
                NSDictionary *fourth_dictionary = [third_dictionary objectForKey:@"pinList"];
                NSString *PinNum = [NSString stringWithFormat:@"%ld",spe_imgview.tag];
                NSDictionary *fifth_dictionary = [fourth_dictionary objectForKey:PinNum];
                NSString *comment = [fifth_dictionary objectForKey:@"comment"];
                
                commentView.text = comment;

                spe_num = spe_imgview.tag;
            
            }else if (spe_imgview.tag == spe_num){//1207
                
                //ピンの選択解除
                spe_imgview.image = [UIImage imageNamed:@"pin_blue.png"];//1207
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.3];
                
                //    UIImageView *imgview = (UIImageView*)[scrollView viewWithTag:k];//1201
                UIImageView *imgview = (UIImageView*)[uv viewWithTag:k];//1201
                
                imgview.frame = CGRectMake(kScrollObjWidth*(imgview.tag-1), 17, kScrollObjWidth, kScrollObjHeight-34);
                _backView.frame = CGRectMake(0, -144, self.view.bounds.size.width, 122);
                
                //1207
                _toolview.frame = CGRectMake(0, 524, self.view.bounds.size.width, 44);
                [self.view bringSubviewToFront:_toolview];
                
                //Navigation_&_ToolBar非表示
                [self.navigationController setNavigationBarHidden:NO animated:YES];//1203
            //    [self.navigationController setToolbarHidden:NO animated:YES];//1203
                
                _commentFlag = NO;
                
                
                
                
                //コメント保存
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    
                 //   NSDictionary *pinData = [defaults dictionaryForKey:@"pinData"];
                    
                    NSDictionary *temp_zero_dictionary = [defaults dictionaryForKey:@"folder"];
                    NSMutableDictionary *zero_dictionary = temp_zero_dictionary.mutableCopy;
                    
                    NSDictionary *temp_first_dictionary = [temp_zero_dictionary objectForKey:_documentDataKey];
                    NSMutableDictionary *first_dictionary = temp_first_dictionary.mutableCopy;
                    
                    NSDictionary *temp_second_dictionary = [first_dictionary objectForKey:@"imageList"];
                    NSMutableDictionary *second_dictionary = temp_second_dictionary.mutableCopy;
                    
                    NSString *number = [NSString stringWithFormat:@"%ld", k];
                    NSDictionary *temp_third_dictionary = [second_dictionary objectForKey:number];
                    NSMutableDictionary *third_dictionary = temp_third_dictionary.mutableCopy;
                
                    NSDictionary *temp_fourth_dictionary = [third_dictionary objectForKey:@"pinList"];
                    NSMutableDictionary *fourth_dictionary = temp_fourth_dictionary.mutableCopy;
                
                    NSString *PinNum = [NSString stringWithFormat:@"%ld",spe_imgview.tag];
                    NSDictionary *temp_fifth_dictionary = [fourth_dictionary objectForKey:PinNum];
                    NSMutableDictionary *fifth_dictionary = temp_fifth_dictionary.mutableCopy;
                
                
                
                    //if文で4th&5thDictionaryの初期設定をする(それぞれのDictionaryがnillのとき)
                    if(!fourth_dictionary){
                    
                        NSDictionary *temp_init_fourth_dictionary = [[NSMutableDictionary alloc] init];
                        NSMutableDictionary *init_fourth_dictionary = temp_init_fourth_dictionary.mutableCopy;

                        fourth_dictionary = init_fourth_dictionary;
                        
                    }else{
                    }
                
                
                    if(!fifth_dictionary){
                        NSDictionary *temp_init_fifth_dictionary = [[NSMutableDictionary alloc] init];
                        NSMutableDictionary *init_fifth_dictionary = temp_init_fifth_dictionary.mutableCopy;

                        fifth_dictionary = init_fifth_dictionary;

                    }else{
                    }
                
                
                    NSString *comment = commentView.text;
                
                    [fifth_dictionary setObject:comment forKey:@"comment"];
                
                    [fourth_dictionary setObject:fifth_dictionary forKey:PinNum];
                        
                    //pinData = fourth_dictionary;
                        
                    [defaults setObject:fourth_dictionary forKey:@"pinData"];
                        
                    [third_dictionary setObject:fourth_dictionary forKey:@"pinList"];//ここで止まる(fourthdictionaryが使える形で存在しないfifthも同様)＿backを押したときも同じ理由かも
                
                    [second_dictionary setObject:third_dictionary forKey:number];
                        
                    [first_dictionary setObject:second_dictionary forKey:@"imageList"];
                
                    [zero_dictionary setObject:first_dictionary forKey:_documentDataKey];
                        
                    [defaults setObject:zero_dictionary forKey:@"folder"];
                    [defaults synchronize];
    
            }
            
        [UIView commitAnimations];
//iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
        
        }
    }
    
    _dragFlag = NO;

}




///////////////////////////1201(試し)
-(void)createView{
    
//    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 250)];
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 88)];
    _backView.backgroundColor = [UIColor colorWithRed:0.192157 green:0.760784 blue:0.952941 alpha:1.0];
    
    [self.view addSubview:_backView];
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




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
