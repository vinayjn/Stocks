.PHONY: all

PROJECT_NAME=transport-contracts
VERSION=$(shell cat ./proto/version.txt)

PROTO_IMPORT_PATH=./proto
PROTO_FILES=$(shell cd $(PROTO_IMPORT_PATH); find * -type f -iname "*.proto" -print)
OUT_DIR=out
BIN_DIR=bin

# out dirs
SWIFT_OUT=$(OUT_DIR)/swift/

swift:
	mkdir -p $(SWIFT_OUT)
	protoc --proto_path=$(PROTO_IMPORT_PATH) --swift_out=$(SWIFT_OUT) $(PROTO_FILES)

clean:
	rm -rf $(OUT_DIR)

