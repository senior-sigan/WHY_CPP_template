# Once done this will define
#  WHYCPP_FOUND - System has WHY_CPP
#  WHYCPP_INCLUDE_DIRS - The WHY_CPP include directories
#  WHYCPP_LIBRARIES - The libraries needed to use WHY_CPP
#  WHYCPP_DEFINITIONS - Compiler switches required for using WHY_CPP

# Find out if this is a 32 or 64 bit build
if( CMAKE_SIZEOF_VOID_P EQUAL 8)
    MESSAGE(STATUS "64 bit system detected.")
    SET( EX_PLATFORM 64)
    SET( EX_PLATFORM_NAME "x64")
else ()
    MESSAGE(STATUS "32 bit system detected.")
    SET( EX_PLATFORM 32)
    SET( EX_PLATFORM_NAME "x86")
endif ()

# Set the proper directory
if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    set(LIB_PATHS "${CMAKE_SOURCE_DIR}/lib/why_cpp/Darwin")
elseif (${CMAKE_SYSTEM_NAME} MATCHES "Windows")
    set(LIB_PATHS "${CMAKE_SOURCE_DIR}/lib/why_cpp/Windows${EX_PLATFORM}")
else ()
    set(LIB_PATHS "${CMAKE_SOURCE_DIR}/lib/why_cpp/Linux${EX_PLATFORM}")
endif ()

MESSAGE(STATUS "LIB_PATHS ${LIB_PATHS}")

# Find the headers
set(WHYCPP_INCLUDE_DIR "${CMAKE_SOURCE_DIR}/lib/why_cpp/include")

# Find the library
if (${CMAKE_SYSTEM_NAME} MATCHES "Windows")
    # Windows doesn't automatically include both .lib and .dll
    #if (MSVC)
    set(CMAKE_FIND_LIBRARY_SUFFIXES ".lib")
    #else ()
    #    set(CMAKE_FIND_LIBRARY_SUFFIXES ".dll")
    #endif ()
    find_library(WHYCPP_LIBRARY NAME whycpp PATHS ${LIB_PATHS})
else (${CMAKE_SYSTEM_NAME} MATCHES "Windows")
    find_library(WHYCPP_LIBRARY NAME whycpp PATHS ${LIB_PATHS})
endif (${CMAKE_SYSTEM_NAME} MATCHES "Windows")

# No compiler switches necessary
set(WHYCPP_DEFINITIONS "")

# Handle _FOUND tags and print success/failure
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(WHY_CPP DEFAULT_MSG WHYCPP_LIBRARY WHYCPP_INCLUDE_DIR)

# Don't display in GUI
mark_as_advanced(WHYCPP_LIBRARY WHYCPP_INCLUDE_DIR)

# No dependencies, so proceed.
set(WHYCPP_INCLUDE_DIRS ${WHYCPP_INCLUDE_DIR})
set(WHYCPP_LIBRARIES ${WHYCPP_LIBRARY})
set(WHYCPP_DLL "${LIB_PATHS}/whycpp.dll")