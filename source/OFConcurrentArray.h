#import <Foundation/Foundation.h>
#import "OFMonitor.h"

@interface OFConcurrentArray : OFMonitor {
    NSMutableArray* storage;
}
@end