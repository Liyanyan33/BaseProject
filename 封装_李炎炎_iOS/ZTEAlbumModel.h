//
//  ZTEAlbumModel.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  相册模型

#import <Foundation/Foundation.h>

@interface ZTEAlbumModel : NSObject
/** 相册名称 */
@property(nonatomic,copy)NSString *name;
/** 相册中所包含的 资源(图片 视频文件)的数量 */
@property(nonatomic,assign)NSInteger count;
/** 资源数据本体 */
@property(nonatomic,strong)id result;
/** 相册名称与相册图片数量  的属性字符串*/
@property(nonatomic,copy)NSAttributedString *attStr;
/** 被选中资源的数量 */
@property(nonatomic,assign)NSInteger selectCount;
/** 存储相册中所包含的资源的数组 */
@property(nonatomic,strong)NSArray *assetModeArr;
/** 被选择的资源的数组 */
@property(nonatomic,strong)NSArray *assetSelectedArr;
@end
