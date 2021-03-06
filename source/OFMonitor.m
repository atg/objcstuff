#import "OFMonitor.h"

@implementation OFMonitor
@synthesize queue;

- (id)init {
    self = [super init];
    if (!self) { return nil; }
    
    queue = dispatch_queue_create("OFMonitor", NULL);
    
    return self;
}

- (void)dealloc {
    dispatch_release(queue);
}
@end

