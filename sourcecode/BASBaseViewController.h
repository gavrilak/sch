//
//  BASBaseViewController.h
//  OfigennoParser
//
//  Created by Sergey on 07.08.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BASETYPE,
    MENUTYPE,
    BACKTYPE,
    INFOTYPE
} NavBarType;

@interface BASBaseViewController : UIViewController

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIImageView *titleView;

- (void)setupNavBtn:(NavBarType)type;
- (void)customTitle:(NSString*)title;
- (void)customTitleImage:(BOOL)state;
- (void)removeTitleImage;
@end
