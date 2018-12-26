[![Build Status](https://travis-ci.com/opensoft/proof-oss.svg?branch=master)](https://travis-ci.com/opensoft/proof-oss)
# Proof-OSS
Open source subset of Proof. Description of each included module can be found in respective repository.

`3rdparty/proof-gtest`+`proofboot`+`proofseed`+`proofbase` is not related to any printing industry specifics and is mostly a common use framework.
`proofutils` and `proofnetworkjdf` are more inclined to printing industry (JDF is printing industry standard for file-based protocols for example), but some stuff from proofutils can be used in almost any production (support for label printers or EPL generation for example).

#### ProofBoot
Build basics and deployment scripts. [README.md](https://github.com/opensoft/proofboot/blob/develop/README.md)

#### ProofSeed
Low-level abstractions such as futures, containers traversal, task scheduling. [README.md](https://github.com/opensoft/proofseed/blob/develop/README.md)

#### ProofBase
Non-gui common stuff. [README.md](https://github.com/opensoft/proofbase/blob/develop/README.md)

#### ProofUtils
Utility classes mostly needed for printing industry applications. [README.md](https://github.com/opensoft/proofutils/blob/develop/README.md)

#### ProofNetworkJdf
JDF standard support. [README.md](https://github.com/opensoft/proofnetworkjdf/blob/develop/README.md)

## Requirements
 * GCC 4.9.2+ or clang 6.0+ (preferred). MSVC17 compiler is also supported, but not recommended.
 * Python >= 3.5
 * Qt 5.10
 * CMake >=3.12
 * qrencode library
    * Linux already have this library (package libqrencode-dev)
 * QCA. Modern linuxes can have qca for qt5 in repository. For other platforms it is needed to be built.
 * QCA plugin qca-ossl.
 * daemontools (on Linux)
 * openssl installed (on Windows)

## Building Proof
#### Setting up environment ####
Desktop build doesn't use any specific environment variables.
Android build can use `QTDIR`, `JAVA_HOME`, `ANDROID_SDK_ROOT` and `ANDROID_NDK_ROOT` environment vars if they are set as a last resort during components search.
If proof modules are built separately it is assumed that `CMAKE_INSTALL_PREFIX` contains all needed modules installed.
For desktop build the only required change to default cmake configuration is specifying path to Qt directory in `CMAKE_PREFIX_PATH`.
For Android build it is needed to specify next cmake variables:
* `CMAKE_FIND_ROOT_PATH` that contains path to Qt directory
* `ANDROID_PLATFORM` should be `android-16`
* `ANDROID_STL` should be `gnustl_shared`
* `ANDROID_TOOLCHAIN` should be `gcc`
* `CMAKE_TOOLCHAIN_FILE` should be path to `android.toolchain.cmake` file (can be found in android ndk)
* `QTDIR` can be specified as cmake variable and will be used before environment var, but after trying to load Qt5Core module using `find_package()`
* `JAVA_HOME`, `ANDROID_SDK_ROOT` and `ANDROID_NDK_ROOT` can also be specified as cmake vars and will be used before environment vars

#### Extra Proof-related CMake variables ####
* `PROOF_DEV_BUILD` if set to true, will also install private headers and qml files
* `PROOF_SKIP_TESTS` if set to true, will skip tests compilation (and will not generate targets for them)
* `PROOF_SKIP_CTEST_TARGETS` if set to true, will skip ctest targets generation
* `PROOF_GENERATE_TRANSLATIONS` if set to true, will repopulate .ts files
* `PROOF_SKIP_TOOLS` if set to true, will skip tools compilation (and will not generate targets for them)
* `PROOF_STATIC_CODE_CHECK_BUILD` used internally by travis-ci builds in jobs that doesn't require working software, but require it to be built on linux (to be compiled with different static analyzers like clazy or clang-tidy)

#### Build process ####
```bash
mkdir build && cd build
cmake -DCMAKE_PREFIX_PATH=<Path where proof should be installed> .. #It is recommended to specify -G Ninja to use ninja instead of makefile
cmake --build . --target install
cmake --build . --target test #Will run tests
```
## Building Proof-based apps
For stations/services it is also required to specify path to proof installation dir (via `CMAKE_PREFIX_PATH` on desktop platform and `CMAKE_FIND_ROOT_PATH` on Android).
Environment variable `PROOF_PATH` is used in runtime to specify where proof is installed for gui applications if it is not ../lib, ../imports folder (the way how it is deployed on production).

#### Build process ####
```bash
mkdir build && cd build
cmake .. #It is recommended to specify -G Ninja to use ninja instead of makefile
cmake --build . --target all
cmake --build . --target test #Will run tests if they exist
```

## Other proof-related open source repositories
 * https://github.com/opensoft/proof-docker - set of dockerfiles for building proof framework and apps based on proof at Travis-CI
 * https://github.com/opensoft/proof-restarter - svscan-based script that adds autostart and respawning for proof-based apps
 * https://github.com/opensoft/proofservice-lpr-printer - http-based rest service that proxies lpr (to print on thermal printers from mobile apps for example). Is a bit outdated and uses old techniques, but still a viable example of proof-based app
 * https://github.com/opensoft/proofservice-weighing-scale - http-based rest service that provides api for weighing on HID-based scales

## Repository updates
This repository will be updated infrequently (mostly on releases of closed source repository with full Proof framework) and is more a combining repository for all open source parts of Proof. Submodules are pointed on branches so you can run `git submodule update --remote --recursive --merge` to update to recent develop branch of submodules.

## API/ABI compatibility
Right now framework is in its 0 version, which means we are not providing any compatibility (but are trying to not break it of course). With 1.0 release we will support API backward compatibility in major version. ABI compatibility will not be provided unfortunately but we will do our best to not break it. Reasons for no ABI compatibility are:
 * Internally we don't have this library shared between different apps. It is either packed in APK file with everything from Qt and Proof that is needed or (in case of linux environment) we pack proof libraries into deb package and deploy them in application-related directory.
 * Most of closed source parts of Proof are modules with support for various REST APIs. This APIs are pretty fluid and we need to update them pretty often.
