program jacobi2d_main_omp
    use omp_lib
    implicit none
    real(kind=8) :: tol, dumax
    integer :: i, j, n,iter,maxiter, nthreads

    n = 50
    tol = 0.1 / (n+1)**2
    maxiter  = 10000
    nthreads = 4

    call jacobi2d_sub_omp(n, nthreads, tol, maxiter, iter, dumax)

    print *, "After returning from subroutine:"
    print *, "  iter = ",iter
    print *, "  dumax = ",dumax

end program jacobi2d_main_omp
