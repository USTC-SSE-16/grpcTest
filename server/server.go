package main

import (
	"log"
	"net"

	"grpcTest/chat"

	"google.golang.org/grpc"
)

func main() {

	lis, err := net.Listen("tcp", ":9000")
	if err != nil {
		log.Fatalf("failed to server on Port :%v", err)
	}

	s := chat.Server{}
	gServer := grpc.NewServer()
	chat.RegisterChatServiceServer(gServer, &s)

	if err := gServer.Serve(lis); err != nil {
		log.Fatalf("failed to grpc server:%v", err)
	}
	log.Println("server is running...")
}
