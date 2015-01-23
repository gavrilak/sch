//
//  BASManager.m
//  RestaurantControlSystem
//
//  Created by Sergey on 26.05.14.
//  Copyright (c) 2014 BestApp Studio. All rights reserved.
//

#import "BASManager.h"

#import "BASChatViewController.h"


@interface BASManager(){
    void (^_success) (NSDictionary* responseObject);
    void (^_failure) (NSString *error);
    
    BOOL isConnect;
    BOOL isClose;
}


@property (nonatomic,strong) NSString* curCommand;
@property (nonatomic,strong) NSDictionary* curDict;

@end

@implementation BASManager



+ (BASManager *)sharedInstance {
    
    static dispatch_once_t once;
    static BASManager *sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [BASManager new];
        [sharedInstance initialization];
    });
    
    
    return sharedInstance;
}
- (void)initialization{
    isClose = NO;
}
- (void)initSocket{
    //ws://195.138.68.2:8887
    //ws://192.168.1.101:8887/
   // self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://192.168.1.101:8887/"]]];
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://chat.bestapp-studio.com:8887/"]]];
    _webSocket.delegate = self;
   
    
    [_webSocket open];
}
- (NSDictionary*)formatRequest:(NSString*)command withParam:(NSDictionary*)param{
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          command,@"command",
                          param,@"param",
                          nil];
    self.curCommand = command;
    self.curDict = [NSDictionary dictionaryWithDictionary:param];
    return dict;
}
- (void)resetWebSocket{
    TheApp;
    if(_webSocket.readyState == SR_CLOSED){
      //  [app showIndecator:YES withView:app.window];
        [self initSocket];
        if(app.userInfo != nil){
            isClose = YES;
            
        }
    }
}
- (void)getData:(NSDictionary*)dict success:(void (^) (NSDictionary* responseObject))success failure:(void (^) (NSString *error))failure{
    
    TheApp;
    _success = success;
    _failure = failure;
    
    if(_webSocket.readyState == SR_CLOSED){
         [app showIndecator:YES withView:app.window];
        [self initSocket];
        if(app.userInfo != nil){
            isClose = YES;
            return;
        }
    }
    
    
    NSMutableData* mutData = [NSMutableData dataWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:nil]];
    
    [_webSocket send:mutData];
    
}
-(void)closeSocket{
    [_webSocket close];
}
- (void)LogIn{
    
    TheApp;
  
    NSDateFormatter *objDateFormatter = [[NSDateFormatter alloc] init];
    [objDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timezone = [objDateFormatter stringFromDate:[NSDate date]];
    
    switch (app.loginType) {
        case LOCAL:{

            NSDictionary* param = @{
                                    @"login" : app.login,
                                    @"pass"  : app.pass,
                                    @"timezone" : timezone
                                    };
            
            [self getData:[[BASManager sharedInstance] formatRequest:@"AUTH" withParam:param] success:^(NSDictionary* responseObject) {
                if([responseObject isKindOfClass:[NSDictionary class]]){
                   // NSLog(@"%@",responseObject);
                    NSArray* userInfo = (NSArray*)[responseObject objectForKey:@"param"];
                    
                    NSDictionary* dict = (NSDictionary*)[userInfo objectAtIndex:0];
                    app.userInfo = [NSDictionary dictionaryWithDictionary:dict];
     
                    if(dict.allKeys.count == 1){
                        [self showAlertViewWithMess:@"Неверный логин или пароль!"];
                       
                        return;
                    }

                    #if TARGET_IPHONE_SIMULATOR
                    
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults removeObjectForKey:@"login"];
                    [userDefaults removeObjectForKey:@"password"];
                    [userDefaults synchronize];
                    
                    [userDefaults setObject:app.login forKey:@"login"];
                    [userDefaults setObject:app.pass  forKey:@"password"];
                    [userDefaults synchronize];
                    
                    if([app.login isEqualToString:@"natural@gmail.com"] || [app.login isEqualToString:@"Natural@gmail.com"]){
                        app.isSupport = NO;
                    } else {
                        app.isSupport = YES;
                    }
                    TheApp;
                    app.navigationController = nil;
                    app.navigationController = [[UINavigationController alloc]initWithRootViewController:app.mainController];
                    [app.window setRootViewController:app.navigationController];
                    
                    #else // TARGET_IPHONE_SIMULATOR
                    
                    NSDictionary* param = @{
                                            @"push_token" :app.pushToken,
                                            };
                    [self getData:[[BASManager sharedInstance] formatRequest:@"SETPUSHTOKEN" withParam:param] success:^(NSDictionary* responseObject) {
                       // NSLog(@"%@",responseObject);
                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                        [userDefaults removeObjectForKey:@"login"];
                        [userDefaults removeObjectForKey:@"password"];
                        [userDefaults synchronize];
                        
                        [userDefaults setObject:app.login forKey:@"login"];
                        [userDefaults setObject:app.pass  forKey:@"password"];
                        [userDefaults synchronize];
                        
                        if([app.login isEqualToString:@"natural@gmail.com"] || [app.login isEqualToString:@"Natural@gmail.com"]){
                            app.isSupport = NO;
                        } else {
                            app.isSupport = YES;
                        }
                        TheApp;
                        app.navigationController = nil;
                        app.navigationController = [[UINavigationController alloc]initWithRootViewController:app.mainController];
                        [app.window setRootViewController:app.navigationController];
                        
                    }failure:^(NSString *error) {
                        NSLog(@"%@",error);
                    }];
                    
                    #endif
                   
                   
                    
                }
            }failure:^(NSString *error) {
                NSLog(@"%@",error);
            }];
        }
            break;
        case FACEBOOK:{
            [FBSession openActiveSessionWithReadPermissions:@[@"public_profile", @"user_friends", @"email",@"user_photos",@"read_friendlists"]
                                               allowLoginUI:YES
                                          completionHandler:
             ^(FBSession *session, FBSessionState state, NSError *error) {
                 [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                     if (!error) {

                         __block NSString* ID = (NSString*)[((NSDictionary*)result) objectForKey:@"id"];
                         [FBRequestConnection startWithGraphPath:@"oauth/access_token?client_id=1590394857855137&client_secret=f43935e6e7401aeb05b7fbcb885a69ac&grant_type=client_credentials"
                                               completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                                   if (!error) {
                                                       
                                                       //NSLog(@"user events: %@", result);
                                                       NSDictionary* dict = [NSDictionary dictionaryWithDictionary:result];
                                                       NSString* tokenStr = (NSString*)[dict objectForKey:@"FACEBOOK_NON_JSON_RESULT"];
                                                       tokenStr = [tokenStr substringFromIndex:13];
                                                       NSDictionary* param = @{
                                                                               @"id" :ID,
                                                                               @"access_token" : tokenStr,
                                                                               @"timezone" : timezone
                                                                               };
                                                       [self getData:[[BASManager sharedInstance] formatRequest:@"REGISTER" withParam:param] success:^(NSDictionary* responseObject) {
                                                           if([responseObject isKindOfClass:[NSDictionary class]]){
                                                               NSLog(@"%@",responseObject);
                                                               NSArray* userInfo = (NSArray*)[responseObject objectForKey:@"param"];
                                                               NSDictionary* dict = (NSDictionary*)[userInfo objectAtIndex:0];
                                                              
                                                               if(dict.allKeys.count == 1){
                                                                   [self showAlertViewWithMess:@"Ошибка авторизации!"];
                                                                   return ;
                                                               } else{
                                                                   app.userInfo = (NSDictionary*)[userInfo objectAtIndex:0];
                                                                   NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                                                   [userDefaults removeObjectForKey:@""];
                                                                    [userDefaults removeObjectForKey:@""];
                                                                    [userDefaults removeObjectForKey:@""];
                                                                   [userDefaults synchronize];
                                                                   [userDefaults setObject:(NSString*)[app.userInfo objectForKey:@"login"] forKey:@"login"];
                                                                   [userDefaults setObject:(NSString*)[app.userInfo objectForKey:@"password"] forKey:@"password"];
                                                                   [userDefaults setObject:app.userInfo forKey:@"userInfo"];
                                                                   [userDefaults setObject:[NSNumber numberWithInt:app.loginType] forKey:@"loginType"];
                                                                   [userDefaults synchronize];

                                                                   TheApp;
   
                                                                   [app.navigationController pushViewController:app.chatController animated:YES];
                                                               }
                                                               
                                                           }
                                                       }failure:^(NSString *error) {
                                                           NSLog(@"%@",error);
                                                       }];
                                                   }
                                               }];
                     }
                 }];
                 
             }];
        }

            break;
        
            
        default:
            break;
    }

}
- (void)LogOut{
   
}



#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    
    NSLog(@"Websocket Connected");
    TheApp;

    if(isClose){
        NSDictionary* param = @{
                                @"login" :app.login,
                                @"pass" : app.pass
                                };
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"AUTH",@"command",
                 param,@"param",
                 nil];
        NSMutableData* mutData = [NSMutableData dataWithData:[NSJSONSerialization dataWithJSONObject:param options:0 error:nil]];
        [_webSocket send:mutData];
        sleep(3);
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 _curCommand,@"command",
                 _curDict,@"param",
                 nil];
        mutData = [NSMutableData dataWithData:[NSJSONSerialization dataWithJSONObject:param options:0 error:nil]];
        [_webSocket send:mutData];
        [app showIndecator:NO withView:app.window];
        isClose = NO;
    }
    isConnect = YES;
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error;
{
    TheApp;
    NSLog(@":( Websocket Failed With Error %@", error);
    isConnect = NO;
    if (error.code == 60)  // timeout
        [self showAlertViewWithMess:@"Отсутствует связь с сервером! Повторите соединение через несколько минут!"];
    
    if (error.code == 51) //no internet
        [self showAlertViewWithMess:@"Отсутствует интернет соединение! Повторите соединение позже!"];
    
    if( _failure!= nil)
        _failure(error.localizedDescription);
    
    [app showIndecator:NO withView:app.window];
  //[[BASManager sharedInstance]LogIn];
    
}


- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    //NSLog(@"pong");
    [webSocket sendPing:nil];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message;
{
  //  NSLog(@"Received \"%@\"", message);
    
    
    NSData* responceData = [message dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:responceData options:kNilOptions error:nil];
    
    NSDictionary* dict = (NSDictionary*)json;
    
    NSNumber* coming = (NSNumber*)[dict objectForKey:@"coming"];
    if([coming integerValue] == 1){
        _success(dict);
    } else {
        if([_delegate respondsToSelector:@selector(icommingMessage:withObject:)]){
            [_delegate icommingMessage:self withObject:dict];
        }
    }
    
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
{
    NSLog(@"WebSocket closed %u, %@",code,reason);
    isConnect = NO;
    if(code == 1010){
        [self showAlertViewWithMess:@"Был осуществлен вход с другого устройства! Перезапустите приложение!"];
    }
    else if (code != 1063 ){
        [self showAlertViewWithMess:@"Отсутствует связь с сервером! Перезапустите приложение!"];
    }
    
    if(_failure!=nil)
        _failure(reason);
    _webSocket = nil;
}

- (void)showAlertViewWithMess:(NSString *)mess
{
    TheApp;
    if(!app.isShowMessage){
        app.isShowMessage = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Сообщение" message:mess delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.cancelButtonIndex == buttonIndex){
        TheApp;
        app.isShowMessage = NO;
        //if(!isConnect)
         //  exit(0);
    }
}
-(NSString *)stringByStrippingHTML:(NSString*)str
{
    NSRange r;
    while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location!= NSNotFound)
    {
        str = [str stringByReplacingCharactersInRange:r withString:@""];
    }
    return str;
}
@end
