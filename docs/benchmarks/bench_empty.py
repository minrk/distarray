import distarray as da

def f(comm, size, reps, dtype):
    """Benchmark da.empty"""
    for i in range(reps):
        a = da.empty((size,size), dtype=dtype, comm=comm)

for size, reps in zip([1000,2000,4000],3*[10]):
    sizes, times = da.benchmark_function(f, size, reps, 'float64')
    if da.COMM_PRIVATE.Get_rank()==0:
        print
        print "array_size, reps:", size, reps
        print sizes
        print times

