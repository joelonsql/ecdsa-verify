#!/bin/sh
dotnet new console -n ECDSAVerify --language F#
dotnet new xunit -n ECDSAVerify.Tests --language F#
dotnet add ECDSAVerify.Tests/ECDSAVerify.Tests.fsproj reference ECDSAVerify/ECDSAVerify.fsproj
