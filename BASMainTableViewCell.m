//
//  BASMainTableViewCell.m
//  SupportChat
//
//  Created by Sergey Bekker on 16.11.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASMainTableViewCell.h"

@interface BASMainTableViewCell()

@property (nonatomic,strong) NSDictionary* contentData;
@property (nonatomic,strong) UIImageView* stateView;
@property (nonatomic,strong) UIImageView* photoView;
@property (nonatomic,strong) UILabel* titleView;
@property (nonatomic,strong) UILabel* messageView;
@property (nonatomic,strong) UILabel* dateView;

@end

@implementation BASMainTableViewCell

- (void)setIsRead:(BOOL)isRead{
    _isRead = isRead;
    UIImage* image = [UIImage imageNamed:@"maincell_bg"];
 
    if(!_isRead){
        image = [UIImage imageNamed:@"maincell_bg_sel"];

    }
    
    self.backgroundColor = [UIColor colorWithPatternImage:image];
    
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withContent:(NSDictionary*) content{
    
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        self.accessoryType   = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor clearColor];
       
   
        if(content != nil){
            
            UIImage* image = nil;

            self.contentData = [NSDictionary dictionaryWithDictionary:content];
            
            NSNumber* is_online = (NSNumber*)[_contentData objectForKey:@"is_online"];

            image = [UIImage imageNamed:@"elips_offline"];
            if((BOOL)[is_online integerValue]){
                image = [UIImage imageNamed:@"elips_online"];
                
            }
            self.stateView = [[UIImageView alloc]initWithImage:image];
            [self.contentView addSubview:_stateView];
        
            image = [UIImage imageNamed:@"frame_camera_ empty"];
            self.photoView = [[UIImageView alloc]initWithImage:image];
            [self.contentView addSubview:_photoView];
        
            self.titleView = [[UILabel alloc]init];
            [_titleView setBackgroundColor:[UIColor clearColor]];
            _titleView.textColor = [UIColor blackColor];
            _titleView.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.f];
            [_titleView setTextAlignment:NSTextAlignmentLeft];
            [self.contentView addSubview:_titleView];
        
            self.messageView = [[UILabel alloc]init];
            [_messageView setBackgroundColor:[UIColor clearColor]];
            _messageView.textColor = [UIColor grayColor];
            _messageView.font = [UIFont fontWithName:@"Helvetica-Light" size:12.f];
            [_messageView setTextAlignment:NSTextAlignmentLeft];
            _messageView.numberOfLines = 5;
            [self.contentView addSubview:_messageView];
        
            self.dateView = [[UILabel alloc]init];
            [_dateView setBackgroundColor:[UIColor clearColor]];
            _dateView.textColor = [UIColor grayColor];
            _dateView.font = [UIFont fontWithName:@"Helvetica-Light" size:10.f];
            [_dateView setTextAlignment:NSTextAlignmentCenter];
            _dateView.numberOfLines = 2;
            [self.contentView addSubview:_dateView];
        
        
            [_titleView setText:[NSString stringWithFormat:@"%@ %@",[_contentData objectForKey:@"name_user"],[_contentData objectForKey:@"surname_user"]]];
             NSDictionary* dict = (NSDictionary*)[_contentData objectForKey:@"message"];
            [_messageView setText:[NSString stringWithFormat:@"%@",[dict objectForKey:@"message"]]];
            
            NSString* timeStr = (NSString*)[dict objectForKey:@"date_message"];
            NSArray* arr = [timeStr componentsSeparatedByString:@"-"];
            timeStr = (NSString*)[arr objectAtIndex:2];
            _dateView.text = [NSString stringWithFormat:@"%@.%@.%@ %@",[timeStr substringToIndex:2],[arr objectAtIndex:1],[arr objectAtIndex:0],[timeStr substringFromIndex:3]];

            
        }
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    CGRect frame = self.contentView.frame;
    if(_contentData != nil){
        UIImage* image = [UIImage imageNamed:@"elips_online"];
        [_stateView setFrame:CGRectMake(5.f, 5.f, image.size.width, image.size.height)];
        
        image = [UIImage imageNamed:@"frame_camera_ empty"];
        [_photoView setFrame:CGRectMake(_stateView.frame.origin.x +_stateView.frame.size.width, frame.size.height / 8 , 3 * frame.size.height / 4, 3 * frame.size.height / 4)];
        [_titleView setFrame:CGRectMake(_photoView.frame.origin.x +_photoView.frame.size.width + 10.f, 5.f , frame.size.width - 160.f, 20.f)];
        [_messageView setFrame:CGRectMake(_photoView.frame.origin.x +_photoView.frame.size.width + 10.f, _titleView.frame.origin.y +_titleView.frame.size.height  - 2.f, frame.size.width - 150.f, 40.f)];
        [_dateView setFrame:CGRectMake(_messageView.frame.origin.x +_messageView.frame.size.width, 0, 65.f, frame.size.height)];
        
        if(IS_IPHONE_6_PLUS){
            [_titleView setFrame:CGRectMake(_photoView.frame.origin.x +_photoView.frame.size.width + 10.f, 10.f , frame.size.width - 160.f, 20.f)];
            [_messageView setFrame:CGRectMake(_photoView.frame.origin.x +_photoView.frame.size.width + 10.f, _titleView.frame.origin.y +_titleView.frame.size.height  - 2.f, frame.size.width - 165.f, 46.f)];
            [_dateView setFrame:CGRectMake(_messageView.frame.origin.x +_messageView.frame.size.width, 0, 65.f, frame.size.height)];
        }
    }
    
}

@end
