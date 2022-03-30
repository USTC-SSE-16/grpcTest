package chat

import (
	"log"

	"golang.org/x/net/context"
)

type Server struct {
}

func (s *Server) SayHello(ctx context.Context, msg *Message) (*Message, error) {
	log.Printf("received message body from client:%s", msg.Body)
	return &Message{Body: "Hello from the server!"}, nil
}
