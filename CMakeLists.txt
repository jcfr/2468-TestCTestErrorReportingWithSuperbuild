cmake_minimum_required(VERSION 2.8.8)

project(TestCTestErrorReportingWithSuperbuild)

#-----------------------------------------------------------------------------
# Testing
#-----------------------------------------------------------------------------
# NOTE: For CTEST_USE_LAUNCHERS to work, it's required to include CTest at the superbuild level.
#       See http://www.kitware.com/blog/home/post/11

set_property(GLOBAL PROPERTY CTEST_TARGETS_ADDED 1) # Do not add CTest default targets
#include(CTest)
include(${CMAKE_CURRENT_SOURCE_DIR}/PatchedCTest.cmake)

#-----------------------------------------------------------------------------
# Superbuild
#-----------------------------------------------------------------------------
option(SUPERBUILD "Build Foo and the projects it depends on via SuperBuild.cmake." ON)
if(SUPERBUILD)
  include(ExternalProject)
  
  # Compute -G arg for configuring external projects with the same CMake generator:
  if(CMAKE_EXTRA_GENERATOR)
    set(gen "${CMAKE_EXTRA_GENERATOR} - ${CMAKE_GENERATOR}")
  else()
    set(gen "${CMAKE_GENERATOR}")
  endif()
    
  ExternalProject_Add(A
    DOWNLOAD_COMMAND ""
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/A
    BINARY_DIR A-build
    CMAKE_GENERATOR ${gen}
    UPDATE_COMMAND ""
    CMAKE_ARGS
      -DCTEST_USE_LAUNCHERS:BOOL=ON
    INSTALL_COMMAND ""
    )
  
  ExternalProject_Add(B
    DOWNLOAD_COMMAND ""
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/B
    BINARY_DIR B-build
    CMAKE_GENERATOR ${gen}
    UPDATE_COMMAND ""
    CMAKE_ARGS
      -DCTEST_USE_LAUNCHERS:BOOL=ON
    INSTALL_COMMAND ""
    )
    
  ExternalProject_Add(C
    URL "http://thisshouldntexist.nop/foo.tgz"
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/C
    BINARY_DIR C-build
    CMAKE_GENERATOR ${gen}
    UPDATE_COMMAND ""
    CMAKE_ARGS
      -DCTEST_USE_LAUNCHERS:BOOL=ON
    INSTALL_COMMAND ""
    )
  
  ExternalProject_Add(Foo
    DEPENDS A B C
    DOWNLOAD_COMMAND ""
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}
    BINARY_DIR Foo-build
    CMAKE_GENERATOR ${gen}
    UPDATE_COMMAND ""
    CMAKE_ARGS
      -DSUPERBUILD:BOOL=OFF
      -DCTEST_USE_LAUNCHERS:BOOL=ON
    INSTALL_COMMAND ""
    )
  
  return()
endif()

#-----------------------------------------------------------------------------
# Inner project
#-----------------------------------------------------------------------------
include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/A
  ${CMAKE_CURRENT_SOURCE_DIR}/B
  )

include(${CMAKE_CURRENT_BINARY_DIR}/../A-build/ATargets.cmake)
include(${CMAKE_CURRENT_BINARY_DIR}/../B-build/BTargets.cmake)

add_library(Bar Bar.cxx Bar.h)

add_library(Iton Iton.cxx Iton.h)

add_executable(Foo Foo.cxx)
target_link_libraries(Foo A B Bar Iton)

# Testing
add_test(NAME RunFooTest COMMAND $<TARGET_FILE:Foo>)
add_test(NAME YeahhhTest COMMAND ${CMAKE_COMMAND} -E echo 'Yeahh')

