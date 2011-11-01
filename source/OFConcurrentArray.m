#import "OFConcurrentArray.h"
#import "dispatchtools.h"

@implementation OFConcurrentArray

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    storage = [[NSMutableArray alloc] init];
    
    return self;
}
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([storage respondsToSelector:[anInvocation selector]]) {
        BOOL isVoid = strcmp([anInvocation methodReturnType], @encode(void)) == 0;
        dispathtools_isAsync(self.queue, isVoid, ^{
            [anInvocation invokeWithTarget:storage];
        });
    }
    else {
        [super forwardInvocation:anInvocation];
    }
}
- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [super respondsToSelector:aSelector] || [storage respondsToSelector:aSelector];
}
- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    return [super methodSignatureForSelector:selector] ?: [storage methodSignatureForSelector:selector];
}
- (NSArray*)storage {
    return dispatchtools_through(self.queue, ^ id (void) {
		return [storage copy];
	});
}
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len {
    [NSException raise:@"Invalid Method" format:@"fast enumeration is not yet supported on OFConcurrentArrays"];
    return 0;
}
/*
- (NSUInteger)count {
    __block c = 0;
    dispatch_sync(self.queue, ^{
		c = [self count];
	});
	return c;
}
- (id)copyWithZone:(NSZone*)zone {
	dispatchtools_through(self.queue, ^ id (void) {
		return [storage copyWithZone:zone];
	});
}
- (void)addObject:(id)x {
    dispatch_async(self.queue, ^{
        [storage addObject:x];
    });
}
- (void)removeAllObjects {
	dispatch_async(self.queue, ^{
		[storage removeAllObjects];
    });
}
- (void)doAsync:(void (^)(NSMutableArray*))f {
    dispatch_async(self.queue, ^{
        f(storage);
    });
}
- (void)doSync:(void (^)(NSMutableArray*))f {
    dispatch_sync(self.queue, ^{
        f(storage);
	});
}
- (NSMutableArray*)unsafeStorage {
    return storage;
}
- (void)each:(void (^)(id))f {
    dispatch_sync(self.queue, ^{
        for (id x in storage) {
            f(x);
        }
    });
}
*/

@end

