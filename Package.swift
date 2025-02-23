// swift-tools-version:5.9
//
// Package.swift
// Sahayak
//
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-async-http",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "swift-async-http",
            targets: ["swift-async-http"]
        )
    ],
    targets: [
        .target(
            name: "swift-async-http",
            path: "Sources/swift-async-http" // Source files directory
        )
    ]   
)
