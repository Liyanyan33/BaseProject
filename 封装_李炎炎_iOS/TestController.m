//
//  TestController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/23.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "TestController.h"
#import "UITextImageView.h"
#import "MYView.h"
#import "OnLineController.h"
#import "LYActionSheetUtils.h"
#import "TZImagePickerController.h"
#import "LYDate.h"

@interface TestController ()<TZImagePickerControllerDelegate>
@property(nonatomic,strong)MYView *mView;

@end

@implementation TestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextImageView *tv = [[UITextImageView alloc]initWithFrame:CGRectMake(0, 64, 150, 150)];
    [tv setTitle:@"妊娠囊是" image:nil];
    [self.view addSubview:tv];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(150, 64, 200, 35)];
    label1.text = @"收电费卡看的开发你看方";
    label1.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:label1];
    
    MYView *view1 = [[MYView alloc]initWithFrame:CGRectMake(150, 35+64, 200, 40)];
    view1.backgroundColor = [UIColor brownColor];
    [self.view addSubview:view1];
    self.mView = view1;
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    btn.backgroundColor = randomColor;
    btn.tag = 100;
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 40, 30)];
    btn1.backgroundColor = randomColor;
    btn1.tag = 200;
    [btn1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    [LYDate containWithTime:@"2016-11-04"];
    
    [LYDate getTimeWithStr:@"Nov 1, 2016 6:06:42 PM "];
    
    NSLog(@"%@",[LYDate getTimeWithStr:@"Nov 1, 2016 6:06:42 PM "]);
    
}

- (void)click:(UIButton*)sender{

    if (sender.tag == 100) {
        OnLineController *ovc = [[OnLineController alloc]init];
        [self.navigationController pushViewController:ovc animated:YES];
    }else{
    
         [LYActionSheetUtils showSheetInVC:self title:@"选择" message:@"message" actionArray:@[@"相册",@"照相"] certain:^(NSInteger index) {
             if (index == 0) {
                 [self takeAlbum];
             }else{
             
             }
        }];
    }
}

#pragma mark 相册
- (void)takeAlbum{

    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    imagePickerVc.allowPickingVideo = NO;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *) photos sourceAssets:(NSArray *)assets{
    NSLog(@"%@", photos);
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *) photos sourceAssets:(NSArray *)assets infos:(NSArray<NSDictionary *> *)infos{
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    NSLog(@"%@",[touches anyObject]);
    UITouch *touch = [touches anyObject];
    CGPoint point1 =  [touch locationInView:self.mView];
    CGPoint point2 = [touch previousLocationInView:self.mView];
    
    NSLog(@"%@--%@",NSStringFromCGPoint(point1),NSStringFromCGPoint(point2));
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    NSLog(@"%@",[touches anyObject]);
    
//    UITouch *touch = [touches anyObject];
//    CGPoint point1 =  [touch locationInView:self.mView];
//    CGPoint point2 = [touch previousLocationInView:self.mView];
//    
//    NSLog(@"%@--%@",NSStringFromCGPoint(point1),NSStringFromCGPoint(point2));
    
}


@end
