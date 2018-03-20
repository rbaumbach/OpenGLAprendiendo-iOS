#import "TriangleWrapper.h"
#import <OpenGLAprendiendo/Triangle.hpp>

@implementation TriangleWrapper {
    Triangle *_triangle;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _triangle = new Triangle(false);
    }
    return self;
}

#pragma mark - Public Methods

- (void)setupTriangle {
    _triangle->setup();
}

- (void)teardownTriangle {
    _triangle->teardown();
}

- (void)render {
    _triangle->render();
}

-(void)dealloc
{
    delete _triangle;
}

@end
