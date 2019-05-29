# Stocks


Stocks is an iOS app written in Swift using the [VIPER Architecture](https://mutualmobile.com/resources/meet-viper-fast-agile-non-lethal-ios-architecture-framework). It provides an easy to use interface to search stocks, find the current price of a stock and also add some stocks to your watchlist. 



### Build Environment

- Xcode 10.2.1

- Swift 5

- Cocoapods 1.6.1
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

