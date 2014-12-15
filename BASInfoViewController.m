//
//  BASInfoViewController.m
//  SupportChat
//
//  Created by Sergey on 17.11.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASInfoViewController.h"

@interface BASInfoViewController ()
@property (nonatomic, strong) UILabel* nameView;
@property (nonatomic, strong) UILabel* emailView;
@property (nonatomic, strong) UILabel* ageView;
@property (nonatomic, strong) UILabel* locationView;
@property (nonatomic, strong) UILabel* pursView;
@property (nonatomic, strong) UILabel* dayView;
@end

@implementation BASInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage* image = [UIImage imageNamed:@"bg_info.png"];
    if(IS_IPHONE_6)
        image = [UIImage imageNamed:@"bg_info_6.png"];
    UIImageView* bgView = [[UIImageView alloc]initWithImage:image];
    [bgView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, image.size.height)];
    [self.view addSubview:bgView];
    
    self.nameView = [[UILabel alloc]init];
    [_nameView setBackgroundColor:[UIColor clearColor]];
    [_nameView setTextAlignment:NSTextAlignmentLeft];
    [_nameView setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22.f]];
    [_nameView setTextColor:[UIColor blackColor]];
    
    [self.view addSubview:_nameView];
    
    self.emailView = [[UILabel alloc]init];
    [_emailView setBackgroundColor:[UIColor clearColor]];
    [_emailView setTextAlignment:NSTextAlignmentLeft];
    [_emailView setFont:[UIFont fontWithName:@"Helvetica-Light" size:18.f]];
    [_emailView setTextColor:[UIColor colorWithRed:77.f/255.f green:77.f/255.f blue:77.f/255.f alpha:1.0]];
    
    [self.view addSubview:_emailView];
    
    self.ageView = [[UILabel alloc]init];
    [_ageView setBackgroundColor:[UIColor clearColor]];
    [_ageView setTextAlignment:NSTextAlignmentLeft];
    [_ageView setFont:[UIFont fontWithName:@"Helvetica-Light" size:18.f]];
    [_ageView setTextColor:[UIColor colorWithRed:77.f/255.f green:77.f/255.f blue:77.f/255.f alpha:1.0]];
    
    [self.view addSubview:_ageView];
    
    self.locationView = [[UILabel alloc]init];
    [_locationView setBackgroundColor:[UIColor clearColor]];
    [_locationView setTextAlignment:NSTextAlignmentLeft];
    [_locationView setFont:[UIFont fontWithName:@"Helvetica-Light" size:18.f]];
    [_locationView setTextColor:[UIColor colorWithRed:77.f/255.f green:77.f/255.f blue:77.f/255.f alpha:1.0]];
    
    [self.view addSubview:_locationView];

    self.pursView = [[UILabel alloc]init];
    [_pursView setBackgroundColor:[UIColor clearColor]];
    [_pursView setTextAlignment:NSTextAlignmentLeft];
    [_pursView setFont:[UIFont fontWithName:@"Helvetica-Light" size:18.f]];
    [_pursView setTextColor:[UIColor colorWithRed:77.f/255.f green:77.f/255.f blue:77.f/255.f alpha:1.0]];
    
    [self.view addSubview:_pursView];
    
    self.dayView = [[UILabel alloc]init];
    [_dayView setBackgroundColor:[UIColor clearColor]];
    [_dayView setTextAlignment:NSTextAlignmentLeft];
    [_dayView setFont:[UIFont fontWithName:@"Helvetica-Light" size:18.f]];
    [_dayView setTextColor:[UIColor colorWithRed:77.f/255.f green:77.f/255.f blue:77.f/255.f alpha:1.0]];
    
    [self.view addSubview:_dayView];
    
    CGFloat posX = 120.f;
    CGFloat posY = 20.f;
    CGFloat width = 190.f;
    if(IS_IPHONE_6){
        posX = 140.f;
        posY = 40.f;
        width = 220.f;
    } else if(IS_IPHONE_6_PLUS){
        posX = 160.f;
        posY = 50.f;
        width = 240.f;
    }

    
    [_nameView setFrame:CGRectMake(posX, posY, width, 25)];
    [_emailView setFrame:CGRectMake(posX, _nameView.frame.origin.y + _nameView.frame.size.height + 5.f, width, 20)];
    [_ageView setFrame:CGRectMake(posX, _emailView.frame.origin.y + _emailView.frame.size.height + 5.f, width, 20)];
    [_locationView setFrame:CGRectMake(posX, _ageView.frame.origin.y + _ageView.frame.size.height + 5.f, width, 20)];
    

    posY = _locationView.frame.origin.y + _locationView.frame.size.height;
    width = 190.f;
    if(IS_IPHONE_6){
        posX += 25.f;
        posY += 31.f;
        width = 195.f;
    } else if(IS_IPHONE_6_PLUS){
        posX += 25.f;
        posY += 42.f;
        width = 215.f;
    } else {
        posX += 25.f;
        posY += 25.f;
        width = 165.f;
    }

    [_pursView setFrame:CGRectMake(posX , posY, width, 20)];
    [_dayView setFrame:CGRectMake(posX , posY + 27.f, width, 20)];
    if(IS_IPHONE_5)
        [_dayView setFrame:CGRectMake(posX , posY + 22.f, width, 20)];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    TheApp;
    [super viewWillAppear:animated];
    
    [self removeTitleImage];
    [self customTitleImage:app.isSupport];
    
    [self setupNavBtn:INFOTYPE];
    
    [self getData];

}
- (void)getData{
    TheApp;
    NSNumber* id_user = (NSNumber*)[_contentData objectForKey:@"id_user"];
    NSDictionary* param = @{@"id_user" :id_user,
                                   };
    [[BASManager sharedInstance] getData:[[BASManager sharedInstance] formatRequest:@"GETUSER" withParam:param] success:^(NSDictionary* responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]){
            NSLog(@"%@",responseObject);
            NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
            NSDictionary* dict = (NSDictionary*)[param objectAtIndex:0];
            
            [_nameView setText:[NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"name_user"],[dict objectForKey:@"surname_user"]]];
            if([dict objectForKey:@"login"] != nil && ![[dict objectForKey:@"login"] isEqualToString:@""]){
                [_emailView setText:[NSString stringWithFormat:@"%@",[dict objectForKey:@"login"]]];
            }
            NSNumber* age = (NSNumber*)[dict objectForKey:@"age"];
            if([age integerValue] != -1)
                [_ageView setText:[NSString stringWithFormat:@"%d лет",[age intValue]]];
            if([dict objectForKey:@"country"]!= nil){
                if(![[dict objectForKey:@"country"] isEqualToString:@""] && ![[dict objectForKey:@"city"] isEqualToString:@""]){
                    [_locationView setText:[NSString stringWithFormat:@"%@, %@",[dict objectForKey:@"country"],[dict objectForKey:@"city"]]];
                } else if([[dict objectForKey:@"country"] isEqualToString:@""] && ![[dict objectForKey:@"city"] isEqualToString:@""]){
                    [_locationView setText:[NSString stringWithFormat:@"%@",[dict objectForKey:@"city"]]];
                }else if(![[dict objectForKey:@"country"] isEqualToString:@""] && [[dict objectForKey:@"city"] isEqualToString:@""]){
                    [_locationView setText:[NSString stringWithFormat:@"%@",[dict objectForKey:@"country"]]];
                }
            }
            
            if([dict objectForKey:@"purchesDate"] != nil && ![[dict objectForKey:@"purchesDate"] isEqualToString:@""]){
                [_pursView setText:[NSString stringWithFormat:@"%@",[dict objectForKey:@"purchesDate"]]];
            }
            NSNumber* expire_date = (NSNumber*)[dict objectForKey:@"expire_date"];
            if([expire_date integerValue] != -1)
                [_dayView setText:[NSString stringWithFormat:@"%d дней",[expire_date intValue]]];
        }
    }failure:^(NSString *error) {
        NSLog(@"%@",error);
    }];
}


@end
