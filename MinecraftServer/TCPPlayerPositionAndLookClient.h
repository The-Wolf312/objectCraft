//
//  TCPPlayerPositionRead.h
//  Minecraft Server
//
//  Created by Victor Brekenfeld on 07.01.14.
//  Copyright (c) 2014 Victor Brekenfeld. All rights reserved.
//

#import "TCPClientPacket.h"

@interface TCPPlayerPositionAndLookClient : TCPClientPacket

@property (readonly) double X;
@property (readonly) double Y;
@property (readonly) double Z;

@property (readonly) float Yaw;
@property (readonly) float Pitch;

@property (readonly) double Stance;
@property (readonly) BOOL OnGround;

@end