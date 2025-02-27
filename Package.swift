// swift-tools-version:5.9
//
// Package.swift
// Sahayak
//
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AsyncHTTP",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AsyncHTTP",
            targets: ["AsyncHTTP"]
        )
    ],
    targets: [
        .target(
            name: "AsyncHTTP",
            path: "Sources/AsyncHTTP" // Source files directory
        )
    ]   
)
