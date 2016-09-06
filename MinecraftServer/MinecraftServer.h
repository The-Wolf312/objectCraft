//
//  MinecraftServer.h
//  MinecraftServer
//
//  Created by Victor Brekenfeld on 22.01.14.
//  Copyright (c) 2014 Victor Brekenfeld. All rights reserved.
//

#import <ObjFW/ObjFW.h>
@class WorldManager;
@class RaknetHandler;
@class TCPClientConnection;
#define UDP_MAX_PACKET_SIZE 1504 //MAX MTU is 1447. 1504 bytes should never be too small

@interface MinecraftServer : OFObject<OFApplicationDelegate> {
    bool running;
    
    OFTCPSocket *tcpServerSocket;
    OFMutableArray *activeTCPConnections;
    
    OFUDPSocket *udpServerSocket;
    void *udpServerSocketBuffer;
    
    OFMutableArray *activeUDPConnections;
    RaknetHandler  *raknetHandler;
    
    WorldManager *worldManager;
}

- (void)tcpClientDisconnected:(TCPClientConnection *)tcpClientConnection;

@end
/*Swift*/
/*
 import ObjFW
 
 let UDP_MAX_PACKET_SIZE = 1504//MAX MTU is 1447. 1504 bytes should never be too small
 
 class MinecraftServer: OFObject, OFApplicationDelegate {
 var running = false
 var tcpServerSocket: OFTCPSocket!
 var activeTCPConnections: OFMutableArray!
 var udpServerSocket: OFUDPSocket!
 var udpServerSocketBuffer
 var activeUDPConnections: OFMutableArray!
 var raknetHandler: RaknetHandler!
 var worldManager: WorldManager!
 
 func tcpClientDisconnected(tcpClientConnection: TCPClientConnection) {
 }
 }
*/
