// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CKImageAdditions",
    products: [
        .library(name: "CKImageAdditions", targets: ["CKImageAdditions"])
    ],
    targets: [
        .target(
            name: "CKImageAdditions",
            publicHeadersPath: "."
        )
    ]
)
