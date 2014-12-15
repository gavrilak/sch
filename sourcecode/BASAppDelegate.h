//
//  BASAppDelegate.h
//  OfigennoParser
//
//  Created by Sergey on 07.08.14.


#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "BASManager.h"



@class BASMainViewController;
@class BASChatViewController;
@class BASInputViewController;

typedef enum SocialType {
    FACEBOOKTYPE,
    VKTYPE,
    LOCALTYPE
}SocialType;

typedef enum messageType {
    NUTRIT,
    SUPPORT,
}MessageType;


static CGFloat hight;
static NSString *restorefeatureId = @"restoreCompletedTransactions";
static NSString *feature1Id = @"com.bestappstudio.Chat_1";
static NSString *feature2Id = @"com.bestappstudio.Chat_2";
static NSString *feature3Id = @"com.bestappstudio.Chat_3";

@interface BASAppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BASMainViewController* mainController;
@property (nonatomic, strong) UINavigationController* navigationController;
@property (nonatomic, strong) BASChatViewController* chatController;
@property (nonatomic, strong) BASInputViewController* inputController;
@property (nonatomic, assign) BOOL isShowMessage;
@property (nonatomic, assign) BOOL isShowContent;
@property (strong, nonatomic) NSArray* contentUsers;
@property (strong, nonatomic) NSString* customTitle;
@property (strong, nonatomic) NSString* cstTitle;
@property (nonatomic, retain) Reachability* internetReachable;
@property (nonatomic, assign) BOOL internetActive;
@property (nonatomic, assign) BOOL isWWAN;
@property (nonatomic, assign) BOOL isVideo;
@property (nonatomic, assign) BOOL isLoad;
@property (nonatomic, assign) BOOL isClobalPage;
@property (nonatomic, assign) BOOL isInit;
@property (nonatomic, assign) NSInteger countPage;
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) NSInteger maxIndex;
@property (nonatomic, strong) NSString* message;
@property (nonatomic, assign) TypeLogin loginType;
@property (nonatomic, strong) NSNumber* user_id;
@property (nonatomic, strong) NSDictionary* userInfo;
@property (nonatomic, strong) NSString* login;
@property (nonatomic, strong) NSString* pass;
@property (nonatomic, assign) MessageType messageType;
@property (nonatomic, assign) BOOL isPurchaise;
@property (nonatomic, assign) BOOL isSupport;
@property (nonatomic, strong) NSString* pushToken;
@property (nonatomic, assign) BOOL isValidData;

- (void) noInternetConnection;
- (BOOL)testInternetConnection;
- (BOOL) is4InchScreen;
- (void)showIndecator:(BOOL)state withView:(UIView*)view;
@end
