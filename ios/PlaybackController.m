//
//  PlaybackController.m
//  banubaBridge
//
//  Created by Mayank Verma on 26/09/23.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTRootView.h>
#import <React/RCTUtils.h>
#import <React/RCTConvert.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(PlaybackController, NSObject)

RCT_EXTERN_METHOD(sendUIViewToReact: (RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

@end

