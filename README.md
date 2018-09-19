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
 * qrencode library
    * Linux already have this library (package libqrencode-dev)
 * QCA. Modern linuxes can have qca for qt5 in repository. For other platforms it is needed to be built.
 * QCA plugin qca-ossl.
 * daemontools (on Linux)
 * openssl installed (on Windows)

## Building Proof
Set `$PROOF_PATH` env variable as main directory for Proof.
Set `$QMAKEFEATURES` env variable to `$PROOF_PATH/features`.
```bash
proofboot/bootstrap.py --src ./ --dest $PROOF_PATH
mkdir build
cd build
qmake ../proof.pro
make -j8
```

## Building Proof-based apps
Set `$PROOF_PATH` env variable to directory where Proof was built previously.
Set `$QMAKEFEATURES` env variable to `$PROOF_PATH/features`.
```bash
mkdir build
cd build
qmake ../APP_NAME.pro
make -j8
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
