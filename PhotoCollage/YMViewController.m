//
//  YMViewController.m
//  PhotoCollage
//
//  Created by Юлия on 26.07.14.
//  Copyright (c) 2014 YuliaMishina. All rights reserved.
//

#import "YMViewController.h"

@interface YMViewController ()

@end

@implementation YMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadingImages:(id)sender {
    NSString* nickName = self.nickField.text;
    [self.resultArrayUrl removeAllObjects];
    
    //Отрезаем пробелы вначале и в конце строки
    nickName = [nickName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //Проверяем длинну получившейся строки
    if (nickName.length < 1) {
        UIAlertView* alert;
        //Вывод предупреждения - формируем окно с сообщением
        alert = [[UIAlertView alloc] initWithTitle:@"Ошибка!"
                                           message:@"Поле Ник пустое"
                                          delegate: nil
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles: nil];
        //Отображаем окно на экране
        [alert show];
    } else {
        
        NSString* resultString; //здесь будет храниться id пользователя
        NSURL* urlPhoto; //здесь будет храниться url фото
        self.resultArrayUrl = [[NSMutableArray alloc] init];

        //Получение id пользователя на основе его имени
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/users/search?q=%@&access_token=31879712.f59def8.0c6367ae284546c3aaa060e790fd3bb1", nickName]];
        NSData *data = [[NSData alloc]initWithContentsOfURL:url ];
        
        id object = [NSJSONSerialization
                     JSONObjectWithData:data
                     options:0
                     error:nil];
        
        
        if([object isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *resultsJson = object;
            id arrayJson = [resultsJson objectForKey:@"data"];
            for (int i = 0; i < [arrayJson count]; i++) {
                NSDictionary* dictionaryJson = [arrayJson objectAtIndex:i];
                NSString* stringJson = [dictionaryJson objectForKey:@"username"];
                if ([stringJson isEqualToString: self.nickField.text] == YES)
                {
                    resultString = [dictionaryJson objectForKey:@"id"];
                }
            }
            
        }

        //Проверяем нашли ли id
        if (resultString == nil) {
            UIAlertView* alert;
            //Вывод предупреждения - формируем окно с сообщением
            alert = [[UIAlertView alloc] initWithTitle:@"Ошибка!"
                                               message:@"Пользователь не найден"
                                              delegate: nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles: nil];
            //Отображаем окно на экране
            [alert show];
        } else {
        
            //Получение фото пользователя на основе его id
            NSURL *urlId = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/users/%@/media/recent/?access_token=31879712.f59def8.0c6367ae284546c3aaa060e790fd3bb1",resultString]];
                                            
            NSData *dataId = [[NSData alloc]initWithContentsOfURL:urlId];
            id objectId = [NSJSONSerialization
                         JSONObjectWithData:dataId
                         options:0
                         error:nil];
            
            if([objectId isKindOfClass:[NSDictionary class]])
            {
                NSDictionary *resultsJsonId = objectId;
                id arrayJsonId = [resultsJsonId objectForKey:@"data"];
                int n = [arrayJsonId count] < 9 ? [arrayJsonId count] : 9;
                for (int i = 0; i < n; i++) {
                    NSDictionary* dictionaryJsonId = [arrayJsonId objectAtIndex:i];
                    NSDictionary* dictionaryHowElementArray = [dictionaryJsonId objectForKey:@"images"];
                    NSDictionary* dictionaryStandartResolution = [dictionaryHowElementArray objectForKey:@"standard_resolution"];
                    urlPhoto = [dictionaryStandartResolution objectForKey:@"url"];
                    [self.resultArrayUrl addObject:urlPhoto];
                }
            }
        }
    }
}
    
    
// Вызывается при срабатывании связи в Storyboard (сразу перед тем как происходит переход)
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Проверяем какая связь срабатывает
    if ([segue.identifier isEqualToString:@"loadImages"]) {
        
        //Получаем конечный View Controller
        YMPhotoCollectionViewController* pcv = segue.destinationViewController;
        
        //Передаем в следующий View Controller  массив из выбранных изображений
        pcv.urlArray = self.resultArrayUrl;
    }
}

//Проверка возможности перехода на следующий View
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"loadImages"]) {
        if ([self.resultArrayUrl count] != 0) {
            // Разрешить переход
            return YES;
        }
        // Запретить переход
        return NO;
    }
    // Разрешить переходы с другим идентификатором
    return YES;
}


@end
