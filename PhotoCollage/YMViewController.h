//
//  YMViewController.h
//  PhotoCollage
//
//  Created by Юлия on 26.07.14.
//  Copyright (c) 2014 YuliaMishina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMPhotoCollectionViewController.h"

@interface YMViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *nickField;
@property(strong, nonatomic) NSMutableArray* resultArrayUrl; // в массиве будут храниться 9 url фото пользователя
- (IBAction)loadingImages:(id)sender;

@end
