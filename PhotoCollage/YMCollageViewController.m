//
//  YMCollageViewController.m
//  PhotoCollage
//
//  Created by Юлия on 26.07.14.
//  Copyright (c) 2014 YuliaMishina. All rights reserved.
//

#import "YMCollageViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface YMCollageViewController ()

@end

@implementation YMCollageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//Метод получения центральной части изображения
-(UIImage*)centralImage: (UIImage*) image
{
    CGRect cropRect = CGRectMake(image.size.width/4, 0, image.size.width/2, image.size.width);
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);
    UIImage *result = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return result;
}

//Метод уменьшения размера изображения в два раза
-(UIImage*)resizeImage:(UIImage*) image
{
    UIImage* resultImage;
    CGSize size = CGSizeMake(image.size.width/2, image.size.height/2);
    //Создаем область памяти для результирующего изображения
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    //Очищаем память
    UIGraphicsEndImageContext();
    return resultImage;
}

//Коллаж из 2 изображений
-(UIImage*)createCollage2: (NSMutableArray*) array
{
    // Получаем центральные части 2-х изображений
    UIImage* firstImage = [self centralImage: [array objectAtIndex:0]];
    UIImage* secondImage = [self centralImage: [array objectAtIndex:1]];
    
    UIImage* resultImage;
    
    //Рассчитываем высоту и ширину результирующего изображения
    CGFloat width = firstImage.size.width + secondImage.size.width;
    CGFloat height = firstImage.size.height;
    //Создаем объект, в котором содержится размер изображения
    CGSize size = CGSizeMake(width, height);
    //Создаем область памяти для результирующего изображения
    UIGraphicsBeginImageContext(size);
    //Отрисовываем первое и второе изображения
    [firstImage drawInRect:CGRectMake(0, 0, width/2, width)];
    [secondImage drawInRect:CGRectMake(width/2, 0, width/2, width)];
    //Сохраняем содержимое памяти в результирующем изображении
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    //Очищаем память
    UIGraphicsEndImageContext();
    return resultImage;
}


//Коллаж из 3 изображений
-(UIImage*)createCollage3: (NSMutableArray*) array
{
    // Получаем центральную часть 3-го изображения
    UIImage* thirdImage = [self centralImage: [array objectAtIndex:2]];
    //Получаем уменьшенные 1 и 2 изображения
    UIImage* firstImage = [self resizeImage: [array objectAtIndex:0]];
    UIImage* secondImage = [self resizeImage: [array objectAtIndex:1]];
    
    UIImage* resultImage;
    
    //Рассчитываем высоту и ширину результирующего изображения
    CGFloat width = firstImage.size.width + thirdImage.size.width;
    CGFloat height = firstImage.size.height + secondImage.size.height;
    //Создаем объект, в котором содержится размер изображения
    CGSize size = CGSizeMake(width, height);
    //Создаем область памяти для результирующего изображения
    UIGraphicsBeginImageContext(size);
    //Отрисовываем первое, второе и третье изображения
    [firstImage drawInRect:CGRectMake(0, 0, width/2, height/2)];
    [secondImage drawInRect:CGRectMake(0, height/2, width/2, height/2)];
    [thirdImage drawInRect:CGRectMake(width/2, 0, width/2, height)];

    //Сохраняем содержимое памяти в результирующем изображении
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    //Очищаем память
    UIGraphicsEndImageContext();
    return resultImage;
}

//Коллаж из 4 изображений
-(UIImage*)createCollage4: (NSMutableArray*) array
{
    
    //Получаем уменьшенные 1, 2, 3 и 4 изображения
    UIImage* firstImage = [self resizeImage: [array objectAtIndex:0]];
    UIImage* secondImage = [self resizeImage: [array objectAtIndex:1]];
    UIImage* thirdImage = [self resizeImage: [array objectAtIndex:2]];
    UIImage* fourthImage = [self resizeImage: [array objectAtIndex:3]];

    UIImage* resultImage;
    
    //Рассчитываем высоту и ширину результирующего изображения
    CGFloat width = firstImage.size.width + thirdImage.size.width;
    CGFloat height = firstImage.size.height + secondImage.size.height;
    
    //Создаем объект, в котором содержится размер изображения
    CGSize size = CGSizeMake(width, height);
    
    //Создаем область памяти для результирующего изображения
    UIGraphicsBeginImageContext(size);
    
    //Отрисовываем первое, второе и третье изображения
    [firstImage drawInRect:CGRectMake(0, 0, width/2, height/2)];
    [secondImage drawInRect:CGRectMake(0, height/2, width/2, height/2)];
    [thirdImage drawInRect:CGRectMake(width/2, 0, width/2, height/2)];
    [fourthImage drawInRect:CGRectMake(width/2, height/2, width/2, height/2)];

    
    //Сохраняем содержимое памяти в результирующем изображении
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    //Очищаем память
    UIGraphicsEndImageContext();
    return resultImage;
}

//Общий метод создания коллажа
-(UIImage*)createCollage: (NSMutableArray*) array
{
    UIImage* imageCollage;
    NSUInteger arrayCount = [array count];
    switch (arrayCount)
    {
        case 1:
            imageCollage = [array objectAtIndex:0];
            break;
        case 2:
            imageCollage = [self createCollage2: array];
            break;
        case 3:
            imageCollage = [self createCollage3: array];
            break;
        case 4:
            imageCollage = [self createCollage4: array];
            break;
    }
    return imageCollage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageCollage.image = [self createCollage: self.array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendToEmail:(id)sender {
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        [picker setSubject:@"SUBJECT OF THE MAIL!"];
        NSData *myData = UIImageJPEGRepresentation(self.imageCollage.image, 0.9);
        [picker addAttachmentData:myData mimeType:@"image/jpg" fileName:@"collage.jpg"];
        
        // Fill out the email body text
        NSString *emailBody = @"BODY OF THE MAIL";
        [picker setMessageBody:emailBody isHTML:NO];
        [self presentViewController:picker animated:YES completion:nil];
        
    }
    
}
@end
