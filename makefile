proto:
	protoc auth/v1/auth.proto \
		--proto_path=. \
		--go_out=. --go_opt=paths=source_relative \
		--go-grpc_out=. --go-grpc_opt=paths=source_relative \
		--validate_out=lang=go,paths=source_relative:. \
		--grpc-gateway_out=. --grpc-gateway_opt=paths=source_relative,generate_unbound_methods=true \
		--openapiv2_out=docs/openapi --openapiv2_opt=logtostderr=true,allow_merge=true,merge_file_name=linkvault-auth


protoi:
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	go install github.com/envoyproxy/protoc-gen-validate@latest
	go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@latest
	go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@latest


bump:
	@powershell -Command "$$last = git describe --tags --abbrev=0; \
		$$parts = $$last -split '\.'; \
		$$new = '{0}.{1}.{2}' -f $$parts[0], $$parts[1], ([int]$$parts[2] + 1); \
		Write-Output ('New tag: ' + $$new); \
		git tag $$new; \
		git push origin $$new"