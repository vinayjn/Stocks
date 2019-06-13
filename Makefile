.PHONY: all

PROJECT_NAME=stock-contracts
VERSION=$(shell cat ./proto/version.txt)

PROTO_IMPORT_PATH=./proto
PROTO_FILES=$(shell cd $(PROTO_IMPORT_PATH); find * -type f -iname "*.proto" -print)
OUT_DIR=proto-output


GO_OUT=$(OUT_DIR)/golang/
SWIFT_OUT=$(OUT_DIR)/swift/

all: golang swift

golang:
	mkdir -p $(GO_OUT)
	protoc --proto_path=$(PROTO_IMPORT_PATH) --go_out=$(GO_OUT) $(PROTO_FILES)

swift:
	mkdir -p $(SWIFT_OUT)
	protoc --swift_opt=Visibility=Public --proto_path=$(PROTO_IMPORT_PATH) --swift_out=$(SWIFT_OUT) $(PROTO_FILES)
