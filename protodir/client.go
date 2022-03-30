package main

import (
	"context"
	"log"

	"grpcTest/protodir/github.com/lixd/grpc-go-example/helloworld"

	"google.golang.org/grpc"
)

func main() {
	var conn *grpc.ClientConn
	conn, err := grpc.Dial(":9000", grpc.WithInsecure())
	if err != nil {
		log.Fatalf("could not connect:%s", err)
	}

	defer conn.Close()

	c := helloworld.NewGreeterClient(conn)
	msg := helloworld.HelloRequest{
		Name: "Grpc: hello from client.",
	}

	rsp, err := c.SayHello(context.Background(), &msg)
	if err != nil {
		log.Fatalf("err where calling sayHello:%v", err)
	}

	log.Printf("respond from Server :%s", rsp.Message)

}
