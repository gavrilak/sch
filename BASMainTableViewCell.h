//
//  BASMainTableViewCell.h
//  SupportChat
//
//  Created by Sergey Bekker on 16.11.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BASMainTableViewCell : UITableViewCell

@property (nonatomic,assign) BOOL isRead;
@property (nonatomic,assign) NSInteger index;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withContent:(NSDictionary*) content;
@end
