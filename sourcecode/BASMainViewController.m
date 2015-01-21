//
//  ViewController.m
//  tellme
//
//  Created by Sergey on 09.10.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASMainViewController.h"
#import "BASChatViewController.h"
#import "BASMainTableViewCell.h"


@interface BASMainViewController ()
@property (nonatomic, strong) NSArray *contentData;
@property (nonatomic,strong) UITextField* textView;
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) NSTimer* updateTimer;

@end

@implementation BASMainViewController

- (void)viewDidLoad {
    TheApp;
    [super viewDidLoad];
 
 
    UIImage* image = [UIImage imageNamed:@"search_bg"];
    if(IS_IPHONE_6)
        image = [UIImage imageNamed:@"search_bg_6"];
    UIImageView* searchView = [[UIImageView alloc]initWithImage:image];
    [searchView setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [self.view addSubview:searchView];
    
    self.textView = [[UITextField alloc]init];
    [_textView setBackgroundColor:[UIColor clearColor]];
    _textView.borderStyle = UITextBorderStyleNone;
    _textView.font = [UIFont fontWithName:@"Helvetica-Light" size:15.f];
    _textView.placeholder = @"Поиск";
    _textView.autocorrectionType = UITextAutocorrectionTypeNo;
    _textView.keyboardType = UIKeyboardTypeDefault;
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textView.delegate = (id) self;
    if ([_textView respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        NSDictionary *textAttributes =
        @{ NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Light" size:15.f] };
        NSAttributedString *attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:@"" attributes:@{
                                                                    NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Light" size:15.f],
                                                                    }];
        
        [_textView setAttributedPlaceholder:attributedPlaceholder];
    }
    _textView.textColor = [UIColor colorWithRed:34.f/255.f green:141.f/255.f blue:221.f/255.f alpha:1.0];
    _textView.keyboardType = UIKeyboardTypeEmailAddress;
    [_textView setFrame:CGRectMake(35.f, searchView.frame.origin.y + 8.f, searchView.frame.size.width - 55.f, 22.f)];
    if(IS_IPHONE_6)
       [_textView setFrame:CGRectMake(40.f, searchView.frame.origin.y + 9.f, searchView.frame.size.width - 60.f, 25.f)];
    else if(IS_IPHONE_6_PLUS)
        [_textView setFrame:CGRectMake(45.f, searchView.frame.origin.y + 11.f, searchView.frame.size.width - 65.f, 27.f)];
    [self.view addSubview:_textView];

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, searchView.frame.size.height, self.view.bounds.size.width, self.view
                                                                   .bounds.size.height - searchView.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setShowsHorizontalScrollIndicator:NO];
    [_tableView setShowsVerticalScrollIndicator:NO];

    [self.view addSubview:_tableView];
    
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    TheApp;
    [super viewWillAppear:animated];
    
    [self removeTitleImage];
    [self customTitleImage:app.isSupport];
   
    [self setupNavBtn:BASETYPE];
    
    [self getData];
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                        target:self
                                                      selector:@selector(timerMethod)
                                                      userInfo:nil
                                                       repeats:YES];
    

}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}
- (void)getData{

    
    [[BASManager sharedInstance] getData:[[BASManager sharedInstance] formatRequest:@"GETUSERS" withParam:nil] success:^(NSDictionary* responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]){
          //  NSLog(@"%@",responseObject);
            if ([[responseObject objectForKey:@"command"] isEqualToString:@"GETUSERS"]){
                self.contentData = [NSArray arrayWithArray:(NSArray*)[responseObject objectForKey:@"param"]];
            
                if(_contentData.count > 0){
               /* if(_updateTimer != nil){
                    [_updateTimer invalidate];
                    _updateTimer = nil;
                }*/
                [_tableView reloadData];
                }
            }
           
            
        }
    }failure:^(NSString *error) {
        NSLog(@"%@",error);
    }];
}

- (void)timerMethod{
    [self getData];
}
#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contentData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MainCell";
    
    NSDictionary* dict = (NSDictionary*)[_contentData objectAtIndex:[indexPath row]];
    
    BASMainTableViewCell *cell = [[BASMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withContent:dict];
   
  
    cell.index = [indexPath row];
    NSDictionary* obj = (NSDictionary*)[dict objectForKey:@"message"];
    NSNumber* is_readed = (NSNumber*)[obj objectForKey:@"is_readed"];
    cell.isRead = (BOOL)[is_readed integerValue];
    
    
    return cell;
}
#pragma mark -
#pragma mark Table delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TheApp;
    
        app.chatController.contentData = (NSDictionary*)[_contentData objectAtIndex:indexPath.row];
        [app.navigationController pushViewController:app.chatController animated:YES];
    
        if(_updateTimer != nil){
            [_updateTimer invalidate];
            _updateTimer = nil;
        }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIImage* image = [UIImage imageNamed:@"maincell_bg"];

    return image.size.height;
}

#pragma mark -
#pragma mark UITextField delegate methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
        [textField becomeFirstResponder];
    };
    return  YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    [_tableView setScrollsToTop:YES];

    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    [self findElement:textField.text];
    return  YES;
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}
- (void) findElement:(NSString*)source{
    
    
    for(int row= 0; row < _contentData.count; row++){
        NSDictionary* obj = (NSDictionary*)[_contentData objectAtIndex:row];
        NSString* str = (NSString*)[obj objectForKey:@"surname_user"];
        if(str.length >= source.length){
            str = [str substringToIndex:source.length];
        }
        
        if ([str rangeOfString:source options:NSCaseInsensitiveSearch].location != NSNotFound) {
            {
                NSIndexPath* path = [NSIndexPath indexPathForRow:row inSection:0];
                [_tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
                return;
            }
            
        }
    }
   
    
    
}

@end
