cmake_minimum_required(VERSION 2.8.8)

#-----------------------------------------------------------------------------
set(CTEST_SOURCE_DIRECTORY "/tmp/2468-TestCTestErrorReportingWithSuperbuild")
set(CTEST_BINARY_DIRECTORY "/tmp/2468-TestCTestErrorReportingWithSuperbuild-build")

set(CTEST_SITE "karakoram.kitware.com")
#set(CTEST_BUILD_NAME "2468-TestCTestErrorReportingWithSuperbuild-WithoutCTestUseLauncher")
#set(CTEST_BUILD_NAME "2468-TestCTestErrorReportingWithSuperbuild-WithCTestUseLauncherAtTopLevel-UnpatchedCTest")
#set(CTEST_BUILD_NAME "2468-TestCTestErrorReportingWithSuperbuild-WithCTestUseLauncherInSubProject-PatchedCTest")
#set(CTEST_BUILD_NAME "2468-TestCTestErrorReportingWithSuperbuild-WithCTestUseLauncherInSubProject-PatchedCTest-TopLevelWarning")
#set(CTEST_BUILD_NAME "2468-TestCTestErrorReportingWithSuperbuild-WithCTestUseLauncherInSubProject-PatchedCTest-TopLevelWarning-TopLevelBuildError")
#set(CTEST_BUILD_NAME "2468-TestCTestErrorReportingWithSuperbuild-WithCTestUseLauncherAllLevel-PatchedCTest-TopLevelWarning-TopLevelBuildError")
set(CTEST_BUILD_NAME "2468-TestCTestErrorReportingWithSuperbuild-WithCTestUseLauncherAllLevel-PatchedCTest-TopLevelWarning-TopLevelBuildErrors")
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
set(CTEST_BUILD_FLAGS "-j4") # Use multiple CPU cores to build. For example "-j4" on unix
set(CTEST_PARALLEL_LEVEL 8)

#-----------------------------------------------------------------------------
ctest_empty_binary_directory(${CTEST_BINARY_DIRECTORY})

find_program(CTEST_GIT_COMMAND NAMES git)

if(NOT EXISTS "${CTEST_SOURCE_DIRECTORY}")
  set(CTEST_CHECKOUT_COMMAND "${CTEST_GIT_COMMAND} clone git://github.com/jcfr/2468-TestCTestErrorReportingWithSuperbuild.git ${CTEST_SOURCE_DIRECTORY}")
endif()

set(CTEST_UPDATE_COMMAND "${CTEST_GIT_COMMAND}")

# For more details, see http://www.kitware.com/blog/home/post/11
set(CTEST_USE_LAUNCHERS 1)
set(ENV{CTEST_USE_LAUNCHERS_DEFAULT} ${CTEST_USE_LAUNCHERS})


#-----------------------------------------------------------------------------
ctest_start("Experimental")

#ctest_update()
#ctest_submit(PARTS Update)

#-----------------------------------------------------------------------------
ctest_configure(
  BUILD "${CTEST_BINARY_DIRECTORY}"
#  OPTIONS "-DCTEST_USE_LAUNCHERS=${CTEST_USE_LAUNCHERS}"
  OPTIONS "-DCTEST_USE_LAUNCHERS=${CTEST_USE_LAUNCHERS};-DUNUSED_CMAKE_VARIABLE_THAT_SHOULD_TRIGGER_WARNING_TOP_LEVEL:BOOL=FALSE"
  )
ctest_read_custom_files("${CTEST_BINARY_DIRECTORY}")
ctest_submit(PARTS Configure)

ctest_build(BUILD "${CTEST_BINARY_DIRECTORY}" NUMBER_ERRORS build_errors APPEND)
ctest_submit(PARTS Build)

set(inner_build_dir "${CTEST_BINARY_DIRECTORY}/Foo-build")

ctest_test(
  BUILD "${inner_build_dir}"
  PARALLEL_LEVEL ${CTEST_PARALLEL_LEVEL}
  )
ctest_submit(PARTS Test)
      
#ctest_submit(PARTS Notes)

