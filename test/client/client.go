package main

import (
	"bufio"
	"context"
	"grpcTest/test/server/test"
	"log"
	"os"

	"google.golang.org/grpc"
)

func main() {
	conn, err := grpc.Dial("127.0.0.1:8028", grpc.WithInsecure())
	if err != nil {
		log.Fatal("连接 gPRC 服务失败,", err)
	}

	defer conn.Close()

	// 创建 gRPC 客户端
	grpcClient := test.NewTesterClient(conn)

	// 创建请求参数
	request := test.Request{
		JsonStr: `{"Code":666}`,
	}

	reader := bufio.NewReader(os.Stdin)

	for {
		// 发送请求，调用 MyTest 接口
		response, err := grpcClient.MyTest(context.Background(), &request)
		if err != nil {
			log.Fatal("发送请求失败，原因是:", err)
		}
		log.Println(response)

		reader.ReadLine()
	}
}
