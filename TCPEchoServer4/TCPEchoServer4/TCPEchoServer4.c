//
//  TCPEchoServer4.c
//  TCPEchoClient4
//
//  Created by 代隽杰 on 16/3/26.
//  Copyright © 2016年 gree. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include "Practical.h"

static const int MAXPENDING = 5; //maximum outstanding connection requests

int main(int argc, char *argv[]){
    if (argc != 2) {
        DieWithUserMessage("Parameter(s)", "<Server Port>");
    }
    in_port_t servPort = atoi(argv[1]);  //First arg: local port
    
    //Create socket for incoming connections
    int servSock;  //socket descriptor for server 创建socket
    if ((servSock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0) {
        DieWithSystemMessage("socket() failed");
    }
    //Construct local address structure
    struct sockaddr_in servAddr; //Local address
    memset(&servAddr, 0, sizeof(servAddr)); //Zero out structure
    servAddr.sin_family = AF_INET;  // IPv4 address family
    servAddr.sin_addr.s_addr = htonl(INADDR_ANY); // any incoming interface  设置地址
    servAddr.sin_port = htons(servPort);  //local port  设置端口
    
    //Bind to the local address
    if (bind(servSock, (struct sockaddr*) &servAddr, sizeof(servAddr)) < 0) {
        DieWithSystemMessage("bind() failed");
    }
    
    //Mark the socket so it will listen for incoming connections
    if (listen(servSock, MAXPENDING) < 0) {
        DieWithSystemMessage("listen() failed");
    }
    for (; ; ) {   //run forever
        struct sockaddr_in clntAddr;  //client address
        //set length of client address structure (in-out parameter)
        socklen_t clntAddrLen = sizeof(clntAddr);
        
        //wait for a client to connect
        int clntSock = accept(servSock, (struct sockaddr*) &clntAddr, &clntAddrLen);
        if (clntSock < 0) {
            DieWithSystemMessage("accept() failed");
        }
        //clntSock is connected to a client;
        char clntName[INET_ADDRSTRLEN]; //string to contain client address
        if (inet_ntop(AF_INET, &clntAddr.sin_addr.s_addr, clntName, sizeof(clntName)) != NULL) {
            printf("Handling client %s/%d\n", clntName,ntohs(clntAddr.sin_port));
        }else{
            puts("unable to get client address");
        }
        HandleTCPClient(clntSock);
    }
    
}