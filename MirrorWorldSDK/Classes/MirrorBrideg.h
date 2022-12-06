//
//  MirrorBrideg.h
//  MirrorWorldSDK
//
//  Created by ZMG on 2022/11/3.
//

#import <Foundation/Foundation.h>


@interface MirrorBrideg : NSObject


extern "C"
{
    extern void IOSInitSDK(int environment,char *apikey);
}

extern "C"
{
    typedef void (*IOSLoginCallback) (const char *object);
    extern void IOSStartLogin(IOSLoginCallback callback);
}

extern "C"
{
    typedef void (*iOSWalletLogOutCallback)(const char *object);
    typedef void (*iOSWalletLoginTokenCallback)(const char *object);

    extern void IOSOpenWallet(iOSWalletLogOutCallback callback,iOSWalletLoginTokenCallback walletLoginCallback);
}

extern "C"
{
    extern void IOSOpenMarketPlace();
}



@end

