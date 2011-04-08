

subroutine jacobi2d_sub_omp(n, nthreads, tol, maxiter, iter_final, dumax)
    ! Implements 2d jacobi iteration on n by n grid
    ! Inputs:  n, tol, maxiter
    ! Outputs: iter, dumax
    use omp_lib
    implicit none
    integer, intent(in) :: n, maxiter, nthreads
    integer, intent(out) :: iter_final
    real(kind=8), intent(in) :: tol
    real(kind=8), intent(out) :: dumax

    ! local variables:
    integer, parameter :: nprint = 1000
    real(kind=8), dimension(:,:), allocatable :: u,uold,f
    real(kind=8), dimension(:), allocatable :: x, y
    real(kind=8) :: h, dumax_thread
    integer :: i, j, istart, iend, points_per_thread, thread_num, iter

    ! Specify number of threads to use:
    !$ call omp_set_num_threads(nthreads)
    !$ print "('Using OpenMP with ',i3,' threads')", nthreads

    ! allocate storage for boundary points too:
    allocate(x(0:n+1), y(0:n+1), u(0:n+1, 0:n+1), uold(0:n+1, 0:n+1), &
             f(0:n+1, 0:n+1))

    ! grid spacing:
    h = 1.d0 / (n+1.d0)

    ! tolerance and max number of iterations:
    print *, "Convergence tolerance: tol = ",tol
    print *, "Maximum number of iterations: maxiter = ",maxiter

    ! Determine how many points to handle with each thread.
    points_per_thread = (n + nthreads - 1) / nthreads
    print *, "points_per_thread = ", points_per_thread * n

    open(unit=20, file="heatsoln.txt", status="unknown")

    ! Start of the parallel block... 
    ! ------------------------------

    !$omp parallel private(thread_num, iter, istart, iend, i, j, dumax_thread)

    !$ thread_num = omp_get_thread_num()    ! unique for each thread
    ! Determine start and end index for the set of points to be 
    ! handled by this thread:
    istart = thread_num * points_per_thread + 1
    iend = min((thread_num+1) * points_per_thread, n)

    !$omp critical
    print 201, thread_num, istart, iend
    !$omp end critical
201 format("Thread ",i2," will take i = ",i6," through i = ",i6)


    do i=istart, iend
        ! grid points in x:
        x(i) = i*h
	x(0) = 0.d0
	x(n+1)=(n+1)*h
        ! boundary conditions:
        ! bottom boundary y=0:
        u(i,0) = 0.d0      
        ! top boundary y=1:
        if ((x(i) <= 0.3d0) .or. (x(i) >= 0.7d0)) then
           u(i,n+1) = 0.d0
        else
           u(i,n+1) = 1.d0
        endif
    enddo

    do j=0,n+1
        ! grid points in y:
        y(j) = j*h

        ! boundary conditions:
        ! left boundary x=0
        u(0,j) = 0.d0      
        ! right boundary x=1
        if ((y(j) <= 0.3d0) .or. (y(j) >= 0.7d0)) then
           u(n+1,j) = 0.d0
        else
           u(n+1,j) = 1.d0
        endif
        enddo

    do j=1,n
        do i=istart,iend
            ! source term:
            f(i,j) = 0.d0
            ! initial guess:
            u(i,j) = 0.d0
            enddo
        enddo

    uold = u ! initialize uold, including boundaries

    ! Jacobi iteratation:

    do iter=1,maxiter
	! initialize uold to u (note each thread does part!)
        uold(istart:iend,0:n+1) = u(istart:iend,0:n+1)

        !$omp single
        dumax = 0.d0     ! global max initialized by one thread
        !$omp end single

        ! Make sure all of uold is initialized before iterating
        !$omp barrier
        ! Make sure uold is consitent in memory:
        !$omp flush

	dumax_thread = 0.d0   ! max seen by this thread
        do j=1,n
            do i=istart,iend
                u(i,j) = 0.25d0*(uold(i-1,j) + uold(i+1,j) + &
                                 uold(i,j-1) + uold(i,j+1) + h**2*f(i,j))
		dumax_thread = max(dumax_thread, abs(u(i,j)-uold(i,j)))
                !$omp critical
	        ! update global dumax using value from this thread:
                dumax = max(dumax, dumax_thread)
                !$omp end critical
	        ! make sure all threads are done with dumax:
                !$omp barrier
                enddo
            enddo

        !$omp single
        ! only one thread will do this print statement:
        if (mod(iter,nprint)==0) then
            print 203, iter, dumax
203         format("After ",i8," iterations, dumax = ",d16.6,/)
            endif
        !$omp end single

        !$omp barrier
        ! check for convergence:
        if (dumax .lt. tol) exit
        ! need to synchronize here so no thread resets dumax = 0
        ! at start of next iteration before all have done the test above.

        enddo

    print *, "Total number of iterations: ",iter
    iter_final = iter    

    !$omp end parallel

    ! print out solution to file:
    do i=0,n+1
        do j=0,n+1
            write(20,222), x(i) ,y(j) ,u(i,j)
            enddo
        enddo
222 format(3e20.10)
    print *, "Solution is in heatsoln.txt"
    close(20)
end subroutine jacobi2d_sub_omp
