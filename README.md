# Stocks

![Build](https://github.com/vinayjn/Stocks-iOS/workflows/Build/badge.svg) [![codecov](https://codecov.io/gh/vinayjn/Stocks-iOS/branch/master/graph/badge.svg)](https://codecov.io/gh/vinayjn/Stocks-iOS)

Stocks is an iOS app written in Swift using the [VIPER Architecture](https://mutualmobile.com/resources/meet-viper-fast-agile-non-lethal-ios-architecture-framework). The idea behind making this app was to keep API contracts(models) in sync with the backend and avoid hassles of writing of same type of code in both iOS and Android. To achieve that I have created a separate repo for the models used in the iOS app which has to be added as a Linked framework to the host app(this one). I am running a local pipeline to generate models using `protoc` with plugins for Swift and Golang. Check the [Makefile](https://github.com/vinayjn/Stocks-iOS/blob/master/Makefile) to know more about it. After generating the models locally these models are then pushed to the [stock-contracts-ios](https://github.com/vinayjn/stock-contracts-ios) repo which itself is added as a git submodule in this repo. 


### Build Environment

- Xcode 11

- Swift 5.1

- Cocoapods 1.7.5
- Swift Protobuf
- Protoc


#### Setup 

Instead of using JSON files for API responses I have used [Protocol Buffers](https://developers.google.com/protocol-buffers/). Protocol buffers are smaller in size and very simple to write. You can find the `.proto` files in the  [protos/models](https://github.com/vinayjn/Stocks/tree/master/proto/models) directory.

Install [Cocoapods](https://cocoapods.org/)

```shell
brew install cocoapods
```

Install [Swift Protobuf](https://github.com/apple/swift-protobuf)

```shell
brew install swift-protobuf
```

This will install `protoc` compiler and Swift code generator plugin.

If you want to run this app and test the functionality, you also need to setup a local server from this [repo](https://github.com/vinayjn/stocks-web-go). 

