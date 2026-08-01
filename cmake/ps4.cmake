set(CMAKE_SYSTEM_NAME FreeBSD)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

if(NOT DEFINED ENV{OO_PS4_TOOLCHAIN})
    set(ENV{OO_PS4_TOOLCHAIN} "/opt/openorbis")
endif()

set(PS4_SDK $ENV{OO_PS4_TOOLCHAIN})

set(CMAKE_C_COMPILER "${PS4_SDK}/bin/orbis-clang")
set(CMAKE_CXX_COMPILER "${PS4_SDK}/bin/orbis-clang++")
set(CMAKE_AR "${PS4_SDK}/bin/orbis-ar" CACHE FILEPATH "Archiver")
set(CMAKE_LINKER "${PS4_SDK}/bin/orbis-ld" CACHE FILEPATH "Linker")

include_directories(${PS4_SDK}/include)
link_directories(${PS4_SDK}/lib)

add_definitions(-D__PS4__ -DORBIS -D_GLES2)
