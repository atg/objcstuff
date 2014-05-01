#import <dispatch/dispatch.h>

// Run a block synchronously on a queue and return the result
static id dispatchtools_through(dispatch_queue_t q, id(^f)(void)) {
    __block id result = nil;
    dispatch_sync(q, ^{
        result = f();
    });
    return result;
}

// This is useful mainly for simplifying code flow. It's not a general tool for deadlock mitigation.
static void dispatchtools_sync_or_invoke(dispatch_queue_t q, dispatch_block_t b) {
    if (dispatch_get_current_queue() == q)
        b();
    else
        dispatch_sync(q, b);
}

static void dispathtools_isAsync(dispatch_queue_t q, BOOL isAsync, dispatch_block_t b) {
    if (isAsync)
        dispatch_async(q, b);
    else
        dispatch_sync(q, b);
}
