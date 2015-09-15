//
//  VirtualDeviceForBroadcast.m
//  NewworkDemo
//
//  Created by gree's apple on 25/8/15.
//  Copyright (c) 2015年 WJF. All rights reserved.
//

#import "VirtualDeviceForBroadcastBL.h"
#import "GEHexFactory.h"
#import "GEDeviceBLRepository.h"
#import "VirtualDeviceBL.h"
#import "ControlFormatLists.h"

#define repeatTime 5
static NSString *CustomRunLoopMode = @"CustomRunLoopMode";

@implementation VirtualDeviceForBroadcastBL
{
    GEUDPSocket *udp;
    RTUDPDAO *udpDao;
    
    BCBLBlock _bcSuccessBlock;
    BCBLBlock _bcFailBlock;
}
@synthesize _command,_nw,_context;

#pragma mark-
#pragma mark life cycle
-(instancetype)init
{
    self = [super init];
    if (self) {
        _nw = [GENetworking shareInstance];
        udpDao = [RTUDPDAO shareInstance];
        
        _command = [[Command alloc] init];
        _context = [[GEWiFiContext alloc] init];
    }
    return self;
}

-(void)dealloc
{
    NSLog(@"%s dealloc",__FILE__);
}

//Command
-(void)broadcast:(void (^)(void))success fail:(void (^)(void))fail
{
    _bcSuccessBlock = success;
    _bcFailBlock = fail;
    
    GEHexFactory *fac = [[GEHexFactory alloc] init];
    NSData *data = [_command excuteWithIdentify:KAcDataBroadcast withFactory:fac withBL:nil];
    
    [udp writeData:data withRepeat:1];//repeatTime
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        while (udp._status == GEUDPStatus_NONE);
        
        CFRunLoopAddCommonMode(CFRunLoopGetCurrent(), (__bridge CFStringRef)(CustomRunLoopMode));
        udp._status == GEUDPStatus_Success?_bcSuccessBlock():_bcFailBlock();
    });
}

- (void)creatUdpWithIpAndPortContext:(NSDictionary *)context
{
    [_nw set_udpDao:udpDao];
    
    udp = [_nw creatUdpBroadCastWithDAO:udpDao withDelegate:self];
    
//    [udpDao setExcuteMac:@"00000000"];  //由于broadcast不需要mac标识，本身不放入DAO管理也可以！使用完即销毁。
    NSLog(@"UDP creat");
}

#pragma mark-
#pragma mark message
-(void)sendMessage:(BLMessageEvt)msg
{       if (msg == BLMessageEvt_BroadcastDone) {
    
        NSString *mac = [NSString stringWithFormat:@"%s",_context.mWifiInfo.mac];
      /****************创建设备*****************/
        GEDeviceBLRepository *rp = [GEDeviceBLRepository shareInstance];
        id obj = [rp findVirtualDeviceByMac:mac];
        if (!obj) {
            NSLog(@"%s objcreat",__func__);
            VirtualDeviceBL *vdbl = [[VirtualDeviceBL alloc] init];
            [vdbl set_context:_context];    //context来源于ACData_Broadcast
            vdbl.identify = mac;    //需要手动设置关键的MAC
            
            [rp addVirtualDeviceObj:vdbl];   //加入repository进行管理//创建设备应该是在tcp连接完的情况下吧？？
            
            [vdbl creatTcpWithIpAndPortContext:@{
                                                 @"IP"  : [NSString stringWithFormat:@"%s",_context.mWifiInfo.ip],
                                                 @"Port": [NSNumber numberWithInt:6000]    //协议规定
                                                 }];
            NSLog(@"ip%@ port%d",[NSString stringWithFormat:@"%s",_context.mWifiInfo.ip],6000);
        }
      /****************创建设备*****************/
    }
}

#pragma mark-
#pragma mark GEWiFiContext
-(GEWiFiContext *)configContextWithDictionary:(NSDictionary *)dic
{
    [_context setValuesForKeysWithDictionary:dic];
    
    NSLog(@"%@",_context);
    
    return _context;
}

#pragma mark-
#pragma mark UdpDelegate
- (BOOL)onUdpSocket:(GEUDPSocket *)sock didReceiveData:(NSData *)data fromHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"*******Start******* Udp didReceive *******Start*******");
    NSLog(@"%@",data);
    NSLog(@"*******End********* Udp didReceive *******End*********");
    /*
     *因为是业务层啊，所以应当在这里处理hex or json AND Encrypt
     */
    unsigned char *buf;
    buf = (unsigned char *)[data bytes];
    if (buf[0] == 0x7E && buf[1] == 0x7E) {
        GEHexFactory *fac = [[GEHexFactory alloc] init];
        [_command excuteWithData:data withFactory:fac withBL:self];
    }else{
        //可能是加密的json or other
    }
     
    return YES;
}


@end
