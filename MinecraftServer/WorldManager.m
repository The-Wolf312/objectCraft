//
//  WorldManager.m
//  MinecraftServer
//
//  Created by Victor Brekenfeld on 26.01.14.
//  Copyright (c) 2014 Victor Brekenfeld. All rights reserved.
//

#import "log.h"
#import "WorldManager.h"
#import "ConfigManager.h"
#import "World.h"
#import "WorldGenerator.h"

@implementation WorldManager

static WorldManager *sharedInstance;

+ (WorldManager *)defaultManager {
    if (!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    @try {
        dimensions = [[OFMutableDictionary alloc] init];
        
        OFDictionary *configuration = [ConfigManager defaultManager].dimensions;
        OFArray *keys = [configuration allKeys];
        for (int i = 0; i < [keys count]; i++) {
            World *world = [[World alloc] initWithGenerator:[configuration objectForKey:[keys objectAtIndex:i]] forDimension:(int8_t)[[keys objectAtIndex:i] int8Value]];
            [dimensions setObject:world forKey:[keys objectAtIndex:i]];
        }
        
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_queue_create(NULL, NULL));
        if (timer)
        {
            dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 50ull * NSEC_PER_MSEC, 25ull * NSEC_PER_MSEC);
            dispatch_source_set_event_handler(timer, ^{
                for (World *world in [dimensions allObjects]) {
                    [world tick];
                }
            });
            dispatch_resume(timer);
        }
        
    } @catch (id e) {
        [self release];
        @throw e;
    }
    return self;
}

- (void)shutdown {
    
    dispatch_source_cancel(timer);
    for (World *world in [dimensions allObjects]) {
        [world saveWorld];
    }
}

- (World *)worldForDimension:(int8_t)dimension {
    return [dimensions objectForKey:[OFNumber numberWithInt8:dimension]];
}

- (void)dealloc {
    if (timer)
        dispatch_release(timer);
    OFArray *keys = [dimensions allKeys];
    for (int i = 0; i < [dimensions count]; i++) {
        [[dimensions objectForKey:[keys objectAtIndex:i]] shutdown];
    }
    [dimensions release];
    [super dealloc];
}

@end
