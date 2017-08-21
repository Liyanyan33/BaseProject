//
//  BaseCollectionAdapter.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/21.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "BaseCollectionAdapter.h"

@implementation BaseCollectionAdapter
- (instancetype)initWithCellBlock:(BaseTableCellSelectedBlock)cellBock{
    self = [super init];
    if (self) {
        self.cellSelectedBlock = cellBock;
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.sourceData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection_cell" forIndexPath:indexPath];
    return cell;
}

@end
