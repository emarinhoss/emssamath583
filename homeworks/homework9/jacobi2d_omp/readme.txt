
Parallel version of 2d Jacobi iteration.

You can type:

   $ make jacobi2d.exe

to make executable,

   $ make heatsoln.txt

to also run code,

   $ make plots

to also make plots.

Or you can plot the results in heatsoln.txt interactively using

  $ ipython -pylab
  In [1]: run ../plotheat2d.py


------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------
---- The following values in the jaboci2d_main_omp.f90        ----
---- can be adjusted:					      ----
----							      ----
---- n = points along the x and y direction (grid points)     ----
---- tol = tolerance for the jacobi iteration		      ----
---- maxiter  = maximum number of iterations in the jabobi    ----
----            method				      ----
---- nthreads = number of threads to be used ny OpenMP	      ----
------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------
