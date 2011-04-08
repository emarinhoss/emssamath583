
program hilbertmain

    implicit none
    integer :: n
    real(kind=8) :: errnorm,rcond

    n = 3
    call hilbert(n,errnorm,rcond)

    print 201, n, 1.d0/rcond, errnorm
201 format("For n = ",i4," the approx. condition number is ",e10.3,/, &
           " and the relative error in 1-norm is ",e10.3)    

end program hilbertmain
