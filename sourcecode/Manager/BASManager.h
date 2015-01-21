//
//  BASManager.h
//  RestaurantControlSystem
//
//  Created by Sergey on 26.05.14.
//  Copyright (c) 2014 BestApp Studio. All rights reserved.
//
#import "SRWebSocket.h"
#import <Foundation/Foundation.h>

typedef enum{
    LOCAL,
    FACEBOOK,
    VK,
    FORGOT,
    CREATE
}TypeLogin;

@class BASManager;

@protocol ManagerDelegate <NSObject>

-(void)autorizationUser:(BASManager*)obj withResult:(BOOL)state;
- (void)icommingMessage:(BASManager*)manager withObject:(NSDictionary*)obj;

@end

@interface BASManager : NSObject


@property (nonatomic,assign) id<ManagerDelegate> delegate;
@property (nonatomic,retain)SRWebSocket *webSocket;
//@property (nonatomic, strong) DLLocationTracker *locationTracker;


+ (BASManager *)sharedInstance;

- (void)showAlertViewWithMess:(NSString *)mess;
- (void)getData:(NSDictionary*)dict success:(void (^) (NSDictionary* responseObject))success failure:(void (^) (NSString *error))failure;
- (NSDictionary*)formatRequest:(NSString*)command withParam:(id)param;

- (void)initSocket;
- (void)resetWebSocket;
- (void)LogIn;
- (void)LogOut;
-(void)closeSocket;
@end
