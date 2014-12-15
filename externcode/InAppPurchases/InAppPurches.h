//
//  InAppPurches.h
//  AvatarCreate
//
//  Created by Sergey on 03.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol InAppPurchesDelegate;

@interface InAppPurches : NSObject

@property (strong, nonatomic) NSString *productID;
@property (assign, nonatomic) id<InAppPurchesDelegate> delegate;

@end


@protocol InAppPurchesDelegate <NSObject>

@optional
-(void)unlockFeature;
-(void)restoreFeature;

@end