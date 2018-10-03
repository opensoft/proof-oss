include(proofboot/proof_functions.pri)
TEMPLATE = subdirs

with-translations:print_log(Translation files will be updated)
build-package:print_log(Application package will be created after compilation)

TARGETS_LIST=
libs:TARGETS_LIST *= libs
tests:TARGETS_LIST *= tests
examples:TARGETS_LIST *= examples
tools:TARGETS_LIST *= tools
isEmpty(TARGETS_LIST):TARGETS_LIST = libs tests examples tools
android:TARGETS_LIST -= examples tools
nothing:TARGETS_LIST =
print_log("Selected metatargets: $$TARGETS_LIST")

MODULES = $$all_proof_modules()
MODULES += 3rdparty/proof-gtest
MODULES -= $$EXCLUDED_MODULES
add_proof_modules_to_subdirs(MODULES)

SORTED_SUBDIRS = $$resolve_depends(SUBDIRS)
SORTED_SUBDIRS = $$reverse(SORTED_SUBDIRS)
for (SUBDIR, SORTED_SUBDIRS):print_log("Target $$SUBDIR depends on: $$eval($${SUBDIR}.depends)")

for (module, MODULES):DISTFILES += \
    $${module}/proofmodule.json \
    $${module}/*.py \
    $${module}/*.pri \
    $${module}/*.md \
    $${module}/features/*.prf \
    $${module}/boot/*

DISTFILES += *.md
