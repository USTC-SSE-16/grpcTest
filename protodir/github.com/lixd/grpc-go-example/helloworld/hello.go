package helloworld

import (
	"log"

	"golang.org/x/net/context"
)

type HelloServer struct {
}

func (h *HelloServer) SayHello(ctx context.Context, msg *HelloRequest) (*HelloReply, error) {
	log.Printf("received message body from client:%s", msg.Name)
	return &HelloReply{Message: "Hello from the server!"}, nil
}
