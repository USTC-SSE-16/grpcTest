package main

import (
	"log"
	"net"

	"grpcTest/protodir/github.com/lixd/grpc-go-example/helloworld"

	"google.golang.org/grpc"
)

func main() {
	log.Println("server is running...")
	lis, err := net.Listen("tcp", ":9000")
	if err != nil {
		log.Fatalf("failed to server on Port :%v", err)
	}

	s := helloworld.HelloServer{}
	gServer := grpc.NewServer()
	helloworld.RegisterGreeterServer(gServer, &s)

	if err := gServer.Serve(lis); err != nil {
		log.Fatalf("failed to grpc server:%v", err)
	}

}
