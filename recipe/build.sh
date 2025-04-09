# on linux and macos, fortran stack protector flags (brought in by conda) cause the fitting results to be poor
export FFLAGS=$($FFLAGS | perl -pe 's|-O2|-O1|' | perl -pe 's|-fstack-protector.*?\b||')

pip install --no-build-isolation . -v -Ccompile-args=-v