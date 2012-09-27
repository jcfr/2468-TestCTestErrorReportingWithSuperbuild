cmake_minimum_required(VERSION 2.8.8)

project(A)

include(CTest)
#include(${CMAKE_CURRENT_SOURCE_DIR}/../PatchedCTest.cmake)

add_library(A A.h A.cxx)

export(TARGETS A FILE ${A_BINARY_DIR}/ATargets.cmake)

