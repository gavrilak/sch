//
//  BASInputViewController.m
//  ChatDieta
//
//  Created by Sergey on 12.11.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASInputViewController.h"

@interface BASInputViewController ()
@property (nonatomic, strong) UITextField* loginView;
@property (nonatomic, strong) UITextField* passView;
@end

@implementation BASInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat posY = 0.f;
    if(!Is4Inch && IS_IPHONE_5)
        posY = -30.f;
    UIImage* image = [UIImage imageNamed:@"in_bg.png"];
    if(IS_IPHONE_6)
        image = [UIImage imageNamed:@"in_bg_6.png"];
    UIImageView* bgView = [[UIImageView alloc]initWithImage:image];
    [bgView setFrame:CGRectMake(0, posY, self.view.bounds.size.width, image.size.height)];
   
    [self.view addSubview:bgView];
    
    self.loginView = [[UITextField alloc]init];
    [_loginView setBackgroundColor:[UIColor clearColor]];
    _loginView.borderStyle = UITextBorderStyleNone;
    _loginView.font = [UIFont fontWithName:@"Helvetica-Light" size:15.f];
    _loginView.placeholder = @"enter text";
    _loginView.autocorrectionType = UITextAutocorrectionTypeNo;
    _loginView.keyboardType = UIKeyboardTypeDefault;
    _loginView.returnKeyType = UIReturnKeyDone;
    _loginView.clearButtonMode = UITextFieldViewModeWhileEditing;
    _loginView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _loginView.delegate = (id) self;
    if ([_loginView respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        NSDictionary *textAttributes =
        @{ NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Light" size:15.f] };
        NSAttributedString *attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:@"" attributes:@{
                                                                    NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Light" size:15.f],
                                                                    }];
        
        [_loginView setAttributedPlaceholder:attributedPlaceholder];
    }
    _loginView.textColor = [UIColor colorWithRed:34.f/255.f green:141.f/255.f blue:221.f/255.f alpha:1.0];
    _loginView.keyboardType = UIKeyboardTypeEmailAddress;
    [self.view addSubview:_loginView];
    
    self.passView = [[UITextField alloc]init];
    [_passView setBackgroundColor:[UIColor clearColor]];
    _passView.borderStyle = UITextBorderStyleNone;
    _passView.font = [UIFont fontWithName:@"Helvetica-Light" size:15.f];
    _passView.placeholder = @"enter text";
    _passView.autocorrectionType = UITextAutocorrectionTypeNo;
    _passView.keyboardType = UIKeyboardTypeDefault;
    _passView.returnKeyType = UIReturnKeyDone;
    _passView.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _passView.delegate = (id) self;
    if ([_passView respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        NSDictionary *textAttributes =
        @{ NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Light" size:15.f] };
        NSAttributedString *attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:@"" attributes:@{
                                                                    NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Light" size:15.f],
                                                                    }];
        
        [_passView setAttributedPlaceholder:attributedPlaceholder];
    }
    _passView.textColor = [UIColor colorWithRed:34.f/255.f green:141.f/255.f blue:221.f/255.f alpha:1.0];
    _passView.keyboardType = UIKeyboardTypeDefault;
    _passView.secureTextEntry = YES;
    [self.view addSubview:_passView];
    
    _loginView.frame = CGRectMake(58.f,117.f + posY, 204.f, 30.f);
    _passView.frame = CGRectMake(58.f,180.f + posY, 204.f, 30.f);
    if(IS_IPHONE_6){
        _loginView.frame = CGRectMake(70.f,136.f, 235.f, 35.f);
        _passView.frame = CGRectMake(70.f,211.f, 235.f, 35.f);
    } else if(IS_IPHONE_6_PLUS){
        _loginView.frame = CGRectMake(75.f,151.f, 265.f, 37.f);
        _passView.frame = CGRectMake(75.f,233.f, 265.f, 37.f);
    }
    image = [UIImage imageNamed:@"button_sign_in.png"];
    if(!IS_IPHONE_5)
        image = [UIImage imageNamed:@"button_sign_in@3x.png"];
    posY = _passView.frame.origin.y + _passView.frame.size.height + 30.f;
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setFrame:CGRectMake(self.view.bounds.size.width / 2 - image.size.width / 2, posY, image.size.width, image.size.height)];
    [button addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setupNavBtn:MENUTYPE];
    [self removeTitleImage];
    [self customTitle:@"Вход"];

    [_loginView setText:@""];
    [_passView setText:@""];
 
}
- (void)viewWillDisappear:(BOOL)animated{
    

    [super viewWillDisappear:animated];
    
}
- (void)clicked{
    TheApp;
    app.loginType = LOCAL;
    [_loginView resignFirstResponder];
    [_passView resignFirstResponder];
    
    if([_loginView.text isEqualToString:@""] || [_passView.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Сообщение" message:@"Все поля обязательны для заполнения!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];
        return;
    }
    
    NSArray* arr = [_loginView.text componentsSeparatedByString:@"@"];
    if(arr.count == 1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Сообщение" message:@"Некорректный адрес электронной почты!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];
        return;
    }
    
    
    app.login = _loginView.text;
    app.pass = _passView.text;
    [[BASManager sharedInstance]LogIn];

   /* app.navigationController = nil;
    app.navigationController = [[UINavigationController alloc]initWithRootViewController:app.mainController];
    [app.window setRootViewController:app.navigationController];*/
}
#pragma mark -
#pragma mark BASManager delegate methods
-(void)autorizationUser:(BASManager*)obj withResult:(BOOL)state{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Сообщение" message:@"Данный пользователь не существует. Зарегистрируйтесь пожалуйста!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alert show];
}
#pragma mark -
#pragma mark UITextField delegate methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    return YES;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
  
    return YES;
}

@end
