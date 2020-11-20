cmake_minimum_required(VERSION 3.13 FATAL_ERROR)

# Interface library to inherit code coverage
add_library(coverage_config INTERFACE)


option(CODE_COVERAGE "Enable coverage reporting" OFF)
if(CODE_COVERAGE AND CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    # Add required coverage flags on GCC & LLVM/Clang
    target_compile_options(coverage_config INTERFACE
        -O0        # No optimization
        -g         # Generate debug info
        --coverage # Sets all required flags
    )
    target_link_options(coverage_config INTERFACE --coverage)
endif(CODE_COVERAGE AND CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")