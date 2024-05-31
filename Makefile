PRODUCT_PACKAGE_PATH := ./OpenApiGenSamplePackage
SWIFT_OPEN_API_GEN_CLI_PACKAGE_PATH := ./SwiftOpenAPIGenCLIPackage

# Ref: swift-openapi-generator - https://github.com/apple/swift-openapi-generator
OPENAPI_PATH := ./schema
OPENAPI_YAML_PATH := ./$(OPENAPI_PATH)/openapi.yaml
OPENAPI_CONFIG_YAML_PATH := ./$(OPENAPI_PATH)/openapi-generator-config.yaml
OPENAPI_GEN_OUTPUT_PATH := ./$(PRODUCT_PACKAGE_PATH)/Sources/OpenApiGenSamplePackage

.PHONY: open-api-gen
open-api-gen:
	swift run --package-path $(SWIFT_OPEN_API_GEN_CLI_PACKAGE_PATH) swift-openapi-generator generate $(OPENAPI_YAML_PATH) --config $(OPENAPI_CONFIG_YAML_PATH) --output-directory $(OPENAPI_GEN_OUTPUT_PATH)
