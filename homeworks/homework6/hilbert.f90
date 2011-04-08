subroutine hilbert(n,errnorm,rcond)
	implicit none
	integer, intent(in) :: n
	real(kind=8), intent(out) :: errnorm, rcond
	real(kind=8), dimension(:,:),allocatable :: a
	real(kind=8) :: xnorm, anorm, colsum
	integer :: i, info, lda, ldb, nrhs, j
	integer, dimension(:), allocatable :: ipiv, iwork
	real(kind=8), allocatable, dimension(:) :: b, x, work
	character, dimension(1) :: norm

	allocate(a(n,n))
	allocate(b(n))
	allocate(x(n))
	allocate(ipiv(n))

	do j=1,n
		do i=1,n
            		a(i,j) = 1.d0 / (i+j-1.d0)
		enddo
	enddo	

	x = 1.d0
	b = matmul(a,x)    ! compute RHS

	! compute 1-norm needed for condition number
	anorm = 0.d0
	do j=1,n
		colsum = 0.d0
		do i=1,n
			colsum = colsum + abs(a(i,j))
		enddo
		anorm = max(anorm, colsum)
        enddo

    
	nrhs = 1 ! number of right hand sides in b
	lda = n  ! leading dimension of a
	ldb = n  ! leading dimension of b

	call dgesv(n, nrhs, a, lda, ipiv, b, ldb, info)

	! compute 1-norm of error
	errnorm = 0.d0
	xnorm = 0.d0
	do i=1,n
		errnorm = errnorm + abs(x(i)-b(i))
		xnorm = xnorm + abs(x(i))
	enddo

	! relative error in 1-norm:
	errnorm = errnorm / xnorm


	! compute condition number of matrix:
	! note: uses A returned from dgesv with L,U factors:

	allocate(work(4*n))
	allocate(iwork(n))
	norm = '1'  ! use 1-norm
	call dgecon(norm,n,a,lda,anorm,rcond,work,iwork,info)

	if (info /= 0) then
        print *, "*** Error in dgecon: info = ",info
        endif

	open(unit=20, file="matrix.txt",status="unknown")
	open(unit=21, file="vector.txt",status="unknown")
	do j=1,n
		do i=1,n
			write(20,210) a(i,j)
210			format(e22.12)
		enddo
		write(20,*) ' '
	enddo

	do j=1,n
		write(21,210) b(j)
	enddo

	deallocate(a,b,ipiv)
	deallocate(work,iwork)

end subroutine hilbert
