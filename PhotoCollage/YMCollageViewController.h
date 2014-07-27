//
//  YMCollageViewController.h
//  PhotoCollage
//
//  Created by Юлия on 26.07.14.
//  Copyright (c) 2014 YuliaMishina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMCollageViewController : UIViewController
@property (strong, nonatomic) NSMutableArray* array;
@property (strong, nonatomic) IBOutlet UIImageView *imageCollage;
- (IBAction)sendToEmail:(id)sender;

@end
