//
//  GetIpV4.m
//  RemoteController
//
//  Created by WJF-Monk  330694 on 13/11/12.
//  Copyright (c) 2012 WJF-Monk  330694. All rights reserved.
//

#import "AppContext.h"
#import "IPAdress.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/socket.h>
#import <net/if_dl.h>
#import <sys/xattr.h>

#define VERSION_INFO @"1.0" //软件版本

@implementation AppContext

+(AppContext *)sharelocalIPV4
{
    static AppContext *ctx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ctx = [[self alloc] init];
    });
    return ctx;
}

-(NSString *)lh
{
    NSString *ip = @"192.168.1.0";
    
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0) {
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    ip = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);

    return ip;
}

-(NSInteger)lp
{
    return 1024;
}

-(NSString *)appv
{
    return VERSION_INFO;
}

-(NSString *)osv
{
    return [[UIDevice currentDevice] systemVersion];
}

-(NSString *)osn
{
    return [[UIDevice currentDevice] systemName];
}

-(NSString *)teln
{
    return [[UIDevice currentDevice] name];
}

-(NSString *)uuid
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

@end





