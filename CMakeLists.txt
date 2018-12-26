cmake_minimum_required(VERSION 3.12.0)
set(PROOF_FULL_BUILD 1)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/proofboot/cmake")
include(ProofInternal)
proof_init()
project(Proof VERSION ${PROOF_VERSION} LANGUAGES CXX)

enable_testing()

add_subdirectory(proofboot)
add_subdirectory(3rdparty/proof-gtest)
add_subdirectory(proofseed)
add_subdirectory(proofbase)
add_subdirectory(proofutils)
add_subdirectory(proofnetworkjdf)

if (NOT PROOF_DEV_BUILD)
    install(CODE "file(MAKE_DIRECTORY \${CMAKE_INSTALL_PREFIX}/include/private)")
endif()
