#!/bin/sh
dotnet new console -n ECDSAVerify
dotnet new xunit -n ECDSAVerify.Tests
dotnet add ECDSAVerify.Tests/ECDSAVerify.Tests.csproj reference ECDSAVerify/ECDSAVerify.csproj
