#import "OFMonitor.h"

@implementation OFMonitor
@synthesize queue;

- (id)init {
    self = [super init];
    if (!self) { return nil; }
    
    queue = dispatch_queue_create("OFMonitor", NULL);
    
    return self;
}

- (void)finalize {
    dispatch_release(queue);
    [super finalize];
}
@end

