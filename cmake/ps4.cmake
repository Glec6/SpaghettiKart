set(CMAKE_SYSTEM_NAME FreeBSD)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

# Define OpenOrbis root
if(NOT DEFINED ENV{OPENORBIS})
    set(ENV{OPENORBIS} "/opt/pacbrew/ps4/openorbis")
endif()

set(PS4_SDK $ENV{OPENORBIS})

# Check if orbis-clang wrapper exists, otherwise fall back to system clang
if(EXISTS "${PS4_SDK}/bin/orbis-clang")
    set(CMAKE_C_COMPILER "${PS4_SDK}/bin/orbis-clang")
    set(CMAKE_CXX_COMPILER "${PS4_SDK}/bin/orbis-clang++")
elseif(EXISTS "${PS4_SDK}/llvm/bin/clang")
    set(CMAKE_C_COMPILER "${PS4_SDK}/llvm/bin/clang")
    set(CMAKE_CXX_COMPILER "${PS4_SDK}/llvm/bin/clang++")
else()
    # Fallback to standard clang compiler on Ubuntu runner with target triple
    set(CMAKE_C_COMPILER "clang")
    set(CMAKE_CXX_COMPILER "clang++")
    set(CMAKE_C_FLAGS "--target=x86_64-scei-ps4 -sysroot=${PS4_SDK}")
    set(CMAKE_CXX_FLAGS "--target=x86_64-scei-ps4 -sysroot=${PS4_SDK}")
endif()

set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})

include_directories(${PS4_SDK}/include ${PS4_SDK}/target/include)
link_directories(${PS4_SDK}/lib ${PS4_SDK}/target/lib)

add_definitions(-D__PS4__ -DORBIS -D_GLES2)
