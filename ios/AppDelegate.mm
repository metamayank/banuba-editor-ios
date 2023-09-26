#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.moduleName = @"banubaBridge";
  // You can add your custom initial props in the dictionary below.
  // They will be passed down to the ViewController used by React Native.
  
  // Add your licenseToken here
   NSString *licenseToken = @"TMdbt1gDGcXFRD4STgk6qDRKfl6KoEI4M7W1GH3HmBnIrkvZ5UFkfyXBArfdDPJ+ruILLhDjOrIbQji4RQLoFqZ6zIvTZOOVAcdrM/qGgzdNiv1jLHq12mexlUOOm7mxDBeuccYFsN5AggiYDzhEQAD42AxMTvFOvMP+3tmO8h9yOzUbFjK4AlOFL0jWE703NrxoOfEs6tHcfo7q3XvOMVZ6cFD8E7rsWUKBmXDS90jsSKo6i42uapUBtoxZp2Pp2Hs/r+Id2/7WwqUx4N3+g75l5B1UwBsQv73urcNXlx4AeW+3p5opSq9L4TGg0+ZrRBvzffK5uUkZyaDTNmyca7Bxn4Xq9RAcNUtdijPckDB9Z1kGxCTsnEtYif1xEk0tEfAfowi5yzbo7N2XajwXILQu8/PoWpTnRxZ4o59cfcl41AUOhwmc0o7Tek5pHZ/RK0LO4rdBK9vtONV+2gcoxYn3skld5smlyGtEI+M88Eq55ldrV3XreiUyyuUMtVMXCHYJAYd371r/WqrZ3zrEJuHFXR9pLUVBPpdJ";
   
   // Include licenseToken in the initialProps dictionary
   self.initialProps = @{
     @"licenseToken": licenseToken
   };
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

@end
