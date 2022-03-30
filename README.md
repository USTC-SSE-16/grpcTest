go version 1.15

refer to web list :

https://github.com/protocolbuffers/protobuf-go

https://developers.google.com/protocol-buffers/docs/gotutorial

https://github.com/protocolbuffers/protobuf

https://github.com/protocolbuffers/protobuf/tree/main/examples

https://pkg.go.dev/google.golang.org/protobuf/cmd/protoc-gen-go


cmd
# 1  go mod init grpcTest
# 2   
  ## 2.1  go get -u github.com/golang/protobuf/protoc-gen-go
  ## 2.2  go install -u github.com/golang/protobuf/protoc-gen-go@lastest
# 3
  ## 3.1  protoc --go_out=plugins=grpc:chat chat.proto
  ## 3.2

