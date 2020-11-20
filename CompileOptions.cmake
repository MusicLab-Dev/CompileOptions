get_filename_component(CompileOptionsRoot ${CMAKE_CURRENT_LIST_FILE} PATH)

# C++ 17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED 17)

# Add compiler specific flags
if (CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    add_compile_options(
        -Wall
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
