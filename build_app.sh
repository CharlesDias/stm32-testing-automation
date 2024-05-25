#!/bin/bash

# Default build type
BUILD_TYPE=${BUILD_TYPE:-Debug}

# Get current directory
CURRENT_DIR=$(pwd)

# Export toolchain path
TOOLCHAIN_PATH="/opt/st/stm32cubeclt_1.15.1/GNU-tools-for-STM32/bin"
export PATH="$PATH:$TOOLCHAIN_PATH"

# Export CMake path
CMAKE_PATH="/opt/st/stm32cubeclt_1.15.1/CMake/bin"
export PATH="$PATH:$CMAKE_PATH"

# Toolchain file configuration
TOOLCHAIN_FILE="$CURRENT_DIR/source/stm32cube-project/cmake/gcc-arm-none-eabi.cmake"

# Source directory
SOURCE_DIR="$CURRENT_DIR/source/stm32cube-project"

# Build directory
BUILD_DIR="$CURRENT_DIR/build"

# CMake flags for source build
CMAKE_FLAGS_SOURCE="-DCMAKE_BUILD_TYPE=$BUILD_TYPE -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN_FILE"

# Clean the build directory
echo "------------------ Clean the Build Directory ------------------"
rm -rf "$BUILD_DIR"
echo ""

# Configure and build the source project
echo "------------------ Configure and Build the Source Project ------------------"
cmake $CMAKE_FLAGS_SOURCE -S "$SOURCE_DIR" -B "$BUILD_DIR/$BUILD_TYPE" -G Ninja 
cmake --build "$BUILD_DIR/$BUILD_TYPE"
echo ""
echo "Done! Built as $BUILD_TYPE. Output files are in $BUILD_DIR/$BUILD_TYPE"