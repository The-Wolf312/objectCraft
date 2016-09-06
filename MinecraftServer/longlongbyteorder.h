//
//  longlongbyteorder.h
//  Minecraft Server
//
//  Created by Victor Brekenfeld on 14.01.14.
//  Copyright (c) 2014 Victor Brekenfeld. All rights reserved.
//

#import <stdint.h>
int64_t zk_htonll(int64_t v);
int64_t zk_ntohll(int64_t vv);
//zk_ added in order to allow build to succeed
