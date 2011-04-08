! $CLASSHG/codes/fortran/taylor_converge.f90

program taylor_converge

    implicit none                  
    real (kind=8), dimension(11) :: exp_true, relative_error
    real (kind=8), dimension(11) :: x, y
    integer :: nmax, npts, i, j
    integer, dimension(11) :: nterms

    nmax = 100
    npts = size(x)
    i = 1
    print *, "     x         true              approximate          error         nterms"
    do j = -20,20,4
       x(i) = float(j)                   ! convert to a real
       i = i + 1
    enddo
       call exptaylor(x,npts,nmax,y,nterms)   ! defined below
       exp_true = exp(x)
       relative_error = abs(y-exp_true) / exp_true
     do j = 1,11
       print '(f10.3,3d19.10,i4)', x(j), exp_true(j), y(j), relative_error(j), nterms(j)
     enddo

end program taylor_converge

!====================================
subroutine exptaylor(x,npts,nmax,y,nterms)
!====================================
    implicit none

    ! subroutine arguments:
    real (kind=8), dimension(npts), intent(in) :: x
    integer, intent(in) :: nmax, npts
    real (kind=8), dimension(npts), intent(out) :: y
    integer, dimension(npts), intent(out) :: nterms

    ! local variables:
    real (kind=8) :: term, partial_sum
    real (kind=8), dimension(npts) :: dummy 
    integer :: j, k

    dummy = abs(x)

    do j=1,npts
        term = 1.
        partial_sum = term
	do k=1,nmax
	    ! j'th term is  x**j / j!  which is the previous term times x/j:
            term = term*dummy(j)/k   
            ! add this term to the partial sum:
            partial_sum = partial_sum + term   
            if (abs(term) < 1.d-16*partial_sum) exit
        enddo
        nterms(j) = k       		! number of terms used
        if (x(j) < 0.d0) then
            y(j) = 1./partial_sum  	! this is the value returned for negative values
        else
	    y(j) = partial_sum
        end if
    enddo

end subroutine exptaylor

