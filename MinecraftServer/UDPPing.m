//
//  UDPPing.m
//  Minecraft Server
//
//  Created by Victor Brekenfeld on 10.01.14.
//  Copyright (c) 2014 Victor Brekenfeld. All rights reserved.
//

#import "UDPPing.h"
#import <time.h>
#include <sys/time.h>
#import "OFDataArray+IntReader.h"
#import "OFDataArray+IntWriter.h"

@implementation UDPPing

- (instancetype)init {
    self = [super init];
    if (self) {
        struct timeval time;
        gettimeofday(&time, NULL);
        
        float microtime = 0.0f;
        
        microtime = time.tv_sec;
        microtime += time.tv_usec/1000.0f;
        
        self.clientTime = abs(microtime*1000);
    }
    return self;
}

- (instancetype)initWithData:(OFDataArray *)data {
    self = [super init];
    if (self) {
        self.clientTime = [data readLong];
    }
    return self;
}

+ (uint8_t)packetId {
    return 0x00;
}

- (OFDataArray *)packetData {
    OFDataArray *packetData = [[OFDataArray alloc] init];
    
    [packetData appendLong:self.clientTime];
    
    return packetData;
}

@end