PACKAGE_NAME := ./OpenApiGenSamplePackage

# Ref: swift-openapi-generator - https://github.com/apple/swift-openapi-generator
OPENAPI_PATH := ./schema
OPENAPI_YAML_PATH := ./$(OPENAPI_PATH)/openapi.yaml
OPENAPI_CONFIG_YAML_PATH := ./$(OPENAPI_PATH)/openapi-generator-config.yaml
OPENAPI_GEN_OUTPUT_PATH := ./$(PACKAGE_NAME)/Sources/OpenApiGenSamplePackage

.PHONY: open-api-gen
open-api-gen:
	swift run --package-path $(PACKAGE_NAME) swift-openapi-generator generate $(OPENAPI_YAML_PATH) --config $(OPENAPI_CONFIG_YAML_PATH) --output-directory $(OPENAPI_GEN_OUTPUT_PATH)
