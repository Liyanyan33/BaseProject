//
//  BaseCollectionCell.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/20.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "BaseCollectionCell.h"

@implementation BaseCollectionCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath*)indexPath{
    BaseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
}

- (void)configCellWithModel:(id)model indexPath:(NSIndexPath *)indexPath{
    
}

- (void)configCellWithViewModel:(id)viewModel indexPath:(NSIndexPath *)indexPath{
    
}

+ (CGFloat)calCellHeightWithModel:(id)modelData{
    CGFloat cellHeight = 0;
    return cellHeight;
}
@end
