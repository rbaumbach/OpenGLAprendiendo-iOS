#import <UIKit/UIKit.h>

// This is a wrapper class around the C++ Triangle class so that we can use Swift view controllers

@interface TriangleWrapper : NSObject

- (void)setupTriangle;
- (void)teardownTriangle;
- (void)render;

@end
