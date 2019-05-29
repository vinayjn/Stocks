.PHONY: all

PROJECT_NAME=stock-contracts
VERSION=$(shell cat ./proto/version.txt)

PROTO_IMPORT_PATH=./proto
PROTO_FILES=$(shell cd $(PROTO_IMPORT_PATH); find * -type f -iname "*.proto" -print)
OUT_DIR=out
BIN_DIR=bin

# out dirs
GOLANG_OUT=$(OUT_DIR)/golang/
SWIFT_OUT=$(OUT_DIR)/swift/

all: golang swift

golang:
	mkdir -p $(GOLANG_OUT)
	@# need to run a for loop because of this: https://github.com/golang/protobuf/issues/39
	for proto in $(PROTO_FILES); do protoc --proto_path=$(PROTO_IMPORT_PATH) --go_out=$(GOLANG_OUT) $$proto; done

swift:
	mkdir -p $(SWIFT_OUT)
	protoc --proto_path=$(PROTO_IMPORT_PATH) --swift_out=$(SWIFT_OUT) $(PROTO_FILES)
