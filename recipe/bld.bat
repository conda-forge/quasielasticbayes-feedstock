@echo on
setlocal enabledelayedexpansion

mkdir builddir

:: see explanation here:
:: https://github.com/conda-forge/scipy-feedstock/pull/253#issuecomment-1732578945
set "MESON_RSP_THRESHOLD=320000"

%PYTHON% -m pip install . --no-build-isolation -Cbuilddir=builddir -v -Ccompile-args=-v
if %ERRORLEVEL% neq 0 (type builddir\meson-logs\meson-log.txt && exit 1)