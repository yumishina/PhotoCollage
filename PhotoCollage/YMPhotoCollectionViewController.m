//
//  YMPhotoCollectionViewController.m
//  PhotoCollage
//
//  Created by Юлия on 26.07.14.
//  Copyright (c) 2014 YuliaMishina. All rights reserved.
//

#import "YMPhotoCollectionViewController.h"
#import "YMCell.h"

@interface YMPhotoCollectionViewController ()

@end

@implementation YMPhotoCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//После того, как загрузился View
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageArray = [[NSMutableArray alloc]init];
    
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.urlArray.count;
    
}

//Загружаем в ячейки картинки
-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YMCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath: indexPath];
    NSURL *url = [NSURL URLWithString:[self.urlArray objectAtIndex:[indexPath row]]];
    NSData *data = [[NSData alloc]initWithContentsOfURL:url ];
    UIImage *img = [[UIImage alloc]initWithData:data ];
    cell.myImage.image = img;
    return cell;
}

//Метод, который выделяет ячейки, которые были выбраны пользователем
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YMCell* cell = [collectionView cellForItemAtIndexPath:indexPath]; //получаем  cell по индексу, который был выбран
    if(cell.alpha == 1)
    {
        cell.alpha = 0.4;
        [self.imageArray addObject: cell.myImage.image];
    }
    else
    {
        cell.alpha = 1;
        [self.imageArray removeObject: cell.myImage.image];

    }
}

// Вызывается при срабатывании связи в Storyboard (сразу перед тем как происходит переход)

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Проверяем какая связь срабатывает
    if ([segue.identifier isEqualToString:@"go"]) {
        
        //Получаем конечный View Controller
        YMCollageViewController* cvc = segue.destinationViewController;
        
        //Передаем в следующий View Controller  массив из выбранных изображений
        cvc.array = self.imageArray;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Проверка возможности перехода на следующий View
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"go"]) {
        if ([self.imageArray count] < 1 ||  [self.imageArray count] > 4) {
            // Запретить переход
            return NO;
        }
        // Разрешить переход
        return YES;
    }
    // Разрешить переходы с другим идентификатором
    return YES;
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

@end
