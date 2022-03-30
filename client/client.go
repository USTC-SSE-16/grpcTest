package main

import (
	"context"
	"grpcTest/chat"
	"log"

	"google.golang.org/grpc"
)

func main() {
	var conn *grpc.ClientConn
	conn, err := grpc.Dial(":9000", grpc.WithInsecure())
	if err != nil {
		log.Fatalf("could not connect:%s", err)
	}

	defer conn.Close()

	c := chat.NewChatServiceClient(conn)
	msg := chat.Message{
		Body: "hello from the client",
	}

	rsp, err := c.SayHello(context.Background(), &msg)
	if err != nil {
		log.Fatalf("err where calling sayHello:%v", err)
	}

	log.Printf("respond from Server :%s", rsp.Body)

}
