package main

import (
	"context"
	"fmt"

	"google.golang.org/grpc"

	// test.pb.go 默认包名是 package 为 main，不需要在这里引入
	"log"
	"net"

	"grpcTest/test/server/test"

	"google.golang.org/grpc/reflection"
)

// 用于实现 Tester 服务
type MyGrpcServer struct{}

func (myserver *MyGrpcServer) MyTest(context context.Context, request *test.Request) (*test.Response, error) {
	fmt.Println("收到一个 grpc 请求，请求参数：", request)
	response := test.Response{BackJson: `{"Code":666}`}
	return &response, nil
}

func main() {
	// 创建 Tcp 连接
	log.Println("server is running...")
	listener, err := net.Listen("tcp", ":8028")
	if err != nil {
		log.Fatalf("监听失败: %v", err)
	}

	// 创建gRPC服务
	grpcServer := grpc.NewServer()

	// Tester 注册服务实现者
	// 此函数在 test.pb.go 中，自动生成
	test.RegisterTesterServer(grpcServer, &MyGrpcServer{})

	// 在 gRPC 服务上注册反射服务
	// func Register(s *grpc.Server)
	reflection.Register(grpcServer)

	err = grpcServer.Serve(listener)
	if err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
	log.Println("server is running...")
}
