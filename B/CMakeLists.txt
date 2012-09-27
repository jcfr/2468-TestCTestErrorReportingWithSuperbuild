cmake_minimum_required(VERSION 2.8.8)

project(B)

include(CTest)
#include(${CMAKE_CURRENT_SOURCE_DIR}/../PatchedCTest.cmake)

add_library(B B.h B.cxx)

export(TARGETS B FILE ${B_BINARY_DIR}/BTargets.cmake)

