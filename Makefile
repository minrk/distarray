.PHONY: clean inplace srcclean

CYTHON = cython
PYTHON = python
MPI4PY_INCLUDE = ${shell ${PYTHON} -c 'import mpi4py; print( mpi4py.get_include() )'}


src: distarray/core/maps_fast.c distarray/mpi/tests/helloworld.c distarray/fft/py_fftw.c

srcclean:
	-${RM} distarray/core/maps_fast.c
	-${RM} distarray/mpi/tests/helloworld.c
	-$(RM) distarray/fft/py_fftw.c

clean:
	${PYTHON} setup.py clean --all
	-${RM} `find . -name '*.py[co]'`
	-${RM} `find . -name '*.so'`
	-${RM} -r build  *.py[co]
	-${RM} -r MANIFEST dist distarrayegg-info

distarray/core/maps_fast.c: distarray/core/maps_fast.pyx
	${CYTHON} -I. -I${MPI4PY_INCLUDE} distarray/core/maps_fast.pyx

distarray/mpi/tests/helloworld.c: distarray/mpi/tests/helloworld.pyx
	${CYTHON} -I. -I${MPI4PY_INCLUDE} distarray/mpi/tests/helloworld.pyx

distarray/fft/py_fftw.c: distarray/fft/py_fftw.pyx
	${CYTHON} -I. -I${MPI4PY_INCLUDE} distarray/fft/py_fftw.pyx


inplace: src
	${PYTHON} setup.py build_ext --inplace

