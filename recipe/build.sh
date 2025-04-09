#!/bin/bash
set -ex

mkdir builddir

# HACK: extend $CONDA_PREFIX/meson_cross_file that's created in
# https://github.com/conda-forge/ctng-compiler-activation-feedstock/blob/main/recipe/activate-gcc.sh
# https://github.com/conda-forge/clang-compiler-activation-feedstock/blob/main/recipe/activate-clang.sh
# to use host python; requires that [binaries] section is last in meson_cross_file
echo "python = '${PREFIX}/bin/python'" >> ${CONDA_PREFIX}/meson_cross_file.txt

# on linux and macos, fortran stack protector flags (brought in by conda) cause the fitting results to be poor
export FFLAGS=$($FFLAGS | perl -pe 's|-O2|-O1|' | perl -pe 's|-fstack-protector.*?\b||')

$PYTHON -m pip install --no-build-isolation \
    -Cbuilddir=builddir \
    -Csetup-args=${MESON_ARGS// / -Csetup-args=} \
    . \
    || (cat builddir/meson-logs/meson-log.txt && exit 1)