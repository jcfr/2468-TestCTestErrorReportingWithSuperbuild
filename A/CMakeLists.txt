cmake_minimum_required(VERSION 2.8.8)

project(A)

#include(CTest)
include(${CMAKE_CURRENT_SOURCE_DIR}/../PatchedCTest.cmake)

add_library(A1 A1.h A1.cxx)

add_library(A2 A2.h A2.cxx)

export(TARGETS A1 A2 FILE ${A_BINARY_DIR}/ATargets.cmake)

