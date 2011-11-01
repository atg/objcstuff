#import <Foundation/Foundation.h>

@interface OFMonitor : NSObject {
    dispatch_queue_t queue;
}
@property (readonly) dispatch_queue_t queue;
@end

