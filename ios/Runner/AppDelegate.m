#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import <ObjectiveDropboxOfficial/ObjectiveDropboxOfficial.h>

@import Firebase;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//     if (@available(iOS 10.0, *)) {
//       [UNUserNotificationCenter currentNotificationCenter].delegate = (id<UNUserNotificationCenterDelegate>) self;
//     }
    [FIRApp configure];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  dispatch_async(dispatch_get_main_queue(), ^{
  [application registerForRemoteNotifications];
    });
  
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
  DBOAuthCompletion completion = ^(DBOAuthResult *authResult) {
    if (authResult != nil) {
      if ([authResult isSuccess]) {
        NSLog(@"\n\nSuccess! User is logged into Dropbox.\n\n");
      } else if ([authResult isCancel]) {
        NSLog(@"\n\nAuthorization flow was manually canceled by user!\n\n");
      } else if ([authResult isError]) {
        NSLog(@"\n\nError: %@\n\n", authResult);
      }
    }
  };
  BOOL canHandle = [DBClientsManager handleRedirectURL:url completion:completion];
  return canHandle;
}

@end
