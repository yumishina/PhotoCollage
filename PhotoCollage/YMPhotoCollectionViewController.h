//
//  YMPhotoCollectionViewController.h
//  PhotoCollage
//
//  Created by Юлия on 26.07.14.
//  Copyright (c) 2014 YuliaMishina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMCollageViewController.h"

@interface YMPhotoCollectionViewController : UICollectionViewController 

@property (strong, nonatomic) NSArray* urlArray;
@property (strong, nonatomic) NSMutableArray* imageArray; // массив для сохранения, выбранных пользователем изображений

@end
