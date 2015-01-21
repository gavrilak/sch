//
//  BASBaseViewController.m
//  OfigennoParser
//
//  Created by Sergey on 07.08.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASBaseViewController.h"


@interface BASBaseViewController ()

@end

@implementation BASBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"bg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}

# pragma  mark -  Private methods
- (void)setupNavBtn:(NavBarType)type
{

    UIButton *btn = nil;
    UIImage *btnImg  = nil;
    UIBarButtonItem *barBtnItem = nil;
    UIBarButtonItem *btn1 = nil;
    
    [self.navigationItem setHidesBackButton:YES animated:NO];
    
    
    switch (type) {
        case BASETYPE:
            
            btnImg = [UIImage imageNamed:@"output.png"];
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0.f, 0.f, btnImg.size.width, btnImg.size.height);
            [btn setImage:btnImg forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnMenuPressed) forControlEvents:UIControlEventTouchUpInside];
            
            barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
            self.navigationItem.leftBarButtonItem = barBtnItem;
            
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btnImg = [UIImage imageNamed:@"compose.png"];
            btn.frame = CGRectMake(0.f, 0.f, btnImg.size.width, btnImg.size.height);
            [btn setImage:btnImg forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnInfoPressed) forControlEvents:UIControlEventTouchUpInside];
            
            barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
           // self.navigationItem.rightBarButtonItem = barBtnItem;
            
            break;
        case MENUTYPE:
            [self.navigationItem setHidesBackButton:YES animated:NO];
            btnImg = [UIImage imageNamed:@"button_back.png"];
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0.f, 0.f, btnImg.size.width, btnImg.size.height);
            [btn setImage:btnImg forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnMenuPressed) forControlEvents:UIControlEventTouchUpInside];
            
            barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
            //self.navigationItem.leftBarButtonItem = barBtnItem;
            break;
        case BACKTYPE:
            btnImg = [UIImage imageNamed:@"button_back.png"];
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0.f, 0.f, btnImg.size.width, btnImg.size.height);
            [btn setImage:btnImg forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnBackPressed) forControlEvents:UIControlEventTouchUpInside];
            
            barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
            self.navigationItem.leftBarButtonItem = barBtnItem;


            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btnImg = [UIImage imageNamed:@"compose.png"];
            btn.frame = CGRectMake(0.f, 0.f, btnImg.size.width, btnImg.size.height);
            [btn setImage:btnImg forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnInfoPressed) forControlEvents:UIControlEventTouchUpInside];
            
            barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
            self.navigationItem.rightBarButtonItem = barBtnItem;
            
            break;
        case INFOTYPE:
            btnImg = [UIImage imageNamed:@"button_back.png"];
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0.f, 0.f, btnImg.size.width, btnImg.size.height);
            [btn setImage:btnImg forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnBackPressed) forControlEvents:UIControlEventTouchUpInside];
            
            barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
            self.navigationItem.leftBarButtonItem = barBtnItem;
            
            break;
        default:
            break;
    }

    
    
}
- (void)removeTitleImage{
    TheApp;
    for (UIView *view in app.navigationController.navigationBar.subviews) {
        if (view.tag == 23) {
            [view removeFromSuperview];
        }
    }
}
- (void)customTitleImage:(BOOL)state{
    TheApp;

    [_titleView removeFromSuperview];
    _titleView = nil;
    
    UIImage * image = [UIImage imageNamed:@"icon_nut_s.png"];
    CGRect frame = app.navigationController.navigationBar.frame;
    _titleView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width / 2 - image.size.width / 2, frame.size.height / 2 - image.size.height /2, image.size.width, image.size.height)];
    _titleView.tag = 23;
    
    [_titleView setImage:[UIImage imageNamed:@"icon_nut_s.png"]];
    if(state){
        [_titleView setImage:[UIImage imageNamed:@"icon_t_s_s.png"]];
    }
    [app.navigationController.navigationBar addSubview:_titleView];

    
   
}
- (void)customTitle:(NSString*)title{
    TheApp;
    [_titleLabel removeFromSuperview];
    _titleLabel = nil;
    
  
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.f, app.navigationController.navigationBar.frame.size.width, app.navigationController.navigationBar.frame.size.height)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:24.0];
    _titleLabel.shadowColor = [UIColor blackColor];
    _titleLabel.shadowOffset = CGSizeMake(0, 1);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    //_titleLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1.0];
    _titleLabel.textColor = [UIColor whiteColor];
    [app.navigationController.navigationBar addSubview:_titleLabel];
    
    _titleLabel.text = title;
    
}
- (void)btnMenuPressed{
    TheApp;

    [[BASManager sharedInstance] getData:[[BASManager sharedInstance] formatRequest:@"LOGOUT" withParam:nil] success:^(NSDictionary* responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]){
            //NSLog(@"%@",responseObject);
 
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults removeObjectForKey:@"login"];
            [userDefaults removeObjectForKey:@"password"];
            [userDefaults synchronize];
            app.navigationController = nil;
            app.navigationController = [[UINavigationController alloc]initWithRootViewController:app.inputController];
            [app.window setRootViewController:app.navigationController];
            
        }
    }failure:^(NSString *error) {
        NSLog(@"%@",error);
    }];

    

}
- (void)btnBackPressed{
    TheApp;
    [app.navigationController popViewControllerAnimated:YES];
}
- (void)btnInfoPressed{
    
}

@end
