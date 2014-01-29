//
//  UDPClientConnect.h
//  Minecraft Server
//
//  Created by Victor Brekenfeld on 09.01.14.
//  Copyright (c) 2014 Victor Brekenfeld. All rights reserved.
//

#import "UDPPacket.h"

@interface UDPClientConnect : UDPPacket

@property int64_t clientId;
@property int64_t sessionId;
@property int8_t unknown;

@end
