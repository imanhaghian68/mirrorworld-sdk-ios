//
//  MirrorBrideg.m
//  MirrorWorldSDK
//
//  Created by ZMG on 2022/11/3.
//

#import "MirrorBrideg.h"




@implementation MirrorBrideg


extern "C"
{
    extern void IOSInitSDK(int environment,char *apikey){
        MWEnvironment env = MWEnvironmentMainNet;
        if (environment == 0){env = MWEnvironmentStagingDevNet; }
        if (environment == 1){env = MWEnvironmentStagingMainNet; }
        if (environment == 3){ env = MWEnvironmentDevNet; }
        NSLog(@"ios-environment:%ld",(long)env);
        NSString *key = [NSString stringWithFormat:@"%s",apikey];
        [[MirrorWorldSDK share] initSDKWithEnv:env apiKey:key];
    }
}

extern "C"
{
    typedef void (*IOSLoginCallback) (const char *object);
    extern void IOSStartLogin(IOSLoginCallback callback){
        NSLog(@"iOS_MWSDK_LOG: - IOSStartLogin");
        [[MirrorWorldSDK share] StartLoginOnSuccess:^(NSDictionary<NSString *,id> * userinfo) {
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userinfo options:NSJSONWritingPrettyPrinted error:nil];
            NSString *user = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            const char *cString = [user UTF8String];
           
            callback(cString);
        } onFail:^{
            
        }];
    }
}


extern "C"
{
    typedef void (*iOSWalletLogOutCallback)(const char *object);
    extern void IOSOpenWallet(iOSWalletLogOutCallback callback){
        NSLog(@"iOS_MWSDK_LOG: - IOSOpenWallet");
        [[MirrorWorldSDK share] OpenWalletOnLogout:^{
            callback("wallet is logout.");
        }];
    }

}

extern "C"
{
    extern void IOSOpenMarketPlace(){
        [[MirrorWorldSDK share] openMarketPlacePage];
        NSLog(@"iOS_MWSDK_LOG: - IOSOpenMarketPlace");
    }
}

@end