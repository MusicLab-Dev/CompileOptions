get_filename_component(CompileOptionsRoot ${CMAKE_CURRENT_LIST_FILE} PATH)

if (${CMAKE_SYSTEM_PROCESSOR} STREQUAL "armv6l")
    set(WerrorFlag "")
else()
    set(WerrorFlag "-Werror")
endif()

# Add compiler specific flags
if (CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    message("Compiling for GNU or Clang, setting C++ 17")
    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
    add_compile_options(
        -Wall
        -fdiagnostics-color=always
        -Wextra
        -Wpedantic
        -Wconversion
        -Wunused
        -Wold-style-cast
        -Wpointer-arith
        -Wcast-qual
        -Wno-missing-braces
        ${WerrorFlag}
    )
elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    # Enable __VA_OPT__
    message("Compiling for MSVC, setting C++ 20 and preprocessor")
    set(CMAKE_CXX_STANDARD 20)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
    add_compile_options(
        /Zc:preprocessor
    )
    add_compile_definitions(
        NOMINMAX
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
