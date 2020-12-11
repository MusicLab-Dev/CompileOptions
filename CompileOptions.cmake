get_filename_component(CompileOptionsRoot ${CMAKE_CURRENT_LIST_FILE} PATH)

# C++ 17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Search for a triplet in environment if not explicitly set
if(NOT DEFINED DVCPKG_TARGET_TRIPLET AND DEFINED ENV{DVCPKG_TARGET_TRIPLET})
    message("DVCPKG_TARGET_TRIPLET found in environment: " $ENV{DVCPKG_TARGET_TRIPLET})
    set(DVCPKG_TARGET_TRIPLET $ENV{DVCPKG_TARGET_TRIPLET})
endif()

# Search for a toolchain in environment if not explicitly set
if(NOT DEFINED CMAKE_TOOLCHAIN_FILE AND DEFINED ENV{CMAKE_TOOLCHAIN_FILE})
    message("CMAKE_TOOLCHAIN_FILE found in environment: " $ENV{CMAKE_TOOLCHAIN_FILE})
    set(CMAKE_TOOLCHAIN_FILE $ENV{CMAKE_TOOLCHAIN_FILE})
endif()

# Add compiler specific flags
if (CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    add_compile_options(
        -Wall
        -fdiagnostics-color=always
    )
elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    add_compile_options(
        /Zc:preprocessor
    )
endif()

# Enable unit testing
option(TESTS "Build tests" OFF)

# Enable benchmarking
option(BENCHMARKS "Build benchmarks" OFF)

# Helper to add a submodule directory
function(add_submodule_directory SubmoduleDir)
    set(TESTS OFF)
    set(BENCHMARKS OFF)
    set(CODE_COVERAGE OFF)
    add_subdirectory(${SubmoduleDir})
endfunction()