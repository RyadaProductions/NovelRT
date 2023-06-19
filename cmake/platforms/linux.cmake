message(STATUS "Building NovelRT for Linux")

include(NovelRTBuildDeps)

find_package(spdlog ${NOVELRT_SPDLOG_VERSION} REQUIRED)
find_package(TBB ${NOVELRT_ONETBB_VERSION} CONFIG REQUIRED)
find_package(Microsoft.GSL ${NOVELRT_GSL_VERSION} REQUIRED)
find_package(stduuid CONFIG REQUIRED)
find_package(glfw3 ${NOVELRT_GLFW_VERSION} CONFIG REQUIRED)
find_package(glm REQUIRED)
find_package(Ogg ${NOVELRT_OGG_VERSION} REQUIRED)
find_package(OpenAL CONFIG REQUIRED)
find_package(Opus REQUIRED)
find_package(Vorbis ${NOVELRT_VORBIS_VERSION} REQUIRED)
find_package(flac ${NOVELRT_FLAC_VERSION} REQUIRED)
find_package(SndFile REQUIRED)
find_package(nlohmann_json REQUIRED)
if(NOVELRT_DEPS_INSTALLED)
  #CMake-standard FindZLIB breaks runtime deps for Windows
  #So we just use our version that doesn't :)
  find_package(ZLIB CONFIG REQUIRED)
  include(${NOVELRT_DEPS_PATH}/lib/libpng/libpng16.cmake)
else()
  find_package(ZLIB REQUIRED)
  find_package(PNG ${NOVELRT_PNG_VERSION} REQUIRED)
endif()
