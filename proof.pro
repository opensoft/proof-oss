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

googletest.subdir = 3rdparty/proof-gtest
contains(TARGETS_LIST, tests):SUBDIRS += googletest
test-runner.subdir = tests/test-runner

seed.subdir = proofseed
seed_tests.file = proofseed/proofseed_tests.pro
seed_tests.depends = googletest seed
contains(TARGETS_LIST, libs):SUBDIRS += seed
contains(TARGETS_LIST, tests):SUBDIRS += seed_tests

base.subdir = proofbase
base.depends = seed
base_tests.file = proofbase/proofbase_tests.pro
base_tests.depends = googletest base
contains(TARGETS_LIST, libs):SUBDIRS += base
contains(TARGETS_LIST, tests):SUBDIRS += base_tests

utils.subdir = proofutils
utils.depends = base
utils_plugins.file = proofutils/proofutils_plugins.pro
utils_plugins.depends = utils
utils_tests.file = proofutils/proofutils_tests.pro
utils_tests.depends = googletest utils
contains(TARGETS_LIST, libs):SUBDIRS += utils utils_plugins
contains(TARGETS_LIST, tests):SUBDIRS += utils_tests

network-jdf.subdir = proofnetworkjdf
network-jdf.depends = base
network-jdf_tests.file = proofnetworkjdf/proofnetworkjdf_tests.pro
network-jdf_tests.depends = googletest network-jdf
contains(TARGETS_LIST, libs):SUBDIRS += network-jdf
contains(TARGETS_LIST, tests):SUBDIRS += network-jdf_tests

SORTED_SUBDIRS = $$resolve_depends(SUBDIRS)
SORTED_SUBDIRS = $$reverse(SORTED_SUBDIRS)
for (SUBDIR, SORTED_SUBDIRS):print_log("Target $$SUBDIR depends on: $$eval($${SUBDIR}.depends)")
