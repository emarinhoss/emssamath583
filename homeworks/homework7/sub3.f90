subroutine sub3(n, u, nrhs, b, x, nthreads, count)

	use omp_lib
	integer, intent(in) :: n, nthreads
	integer, dimension(0:15), intent(inout) :: count
	real(kind=8), dimension(1:n,1:nrhs), intent(in) :: b
	real(kind=8), dimension(1:n,1:n), intent(in) :: u
	real(kind=8), dimension(1:n,1:nrhs), intent(out) :: x
	real(kind=8) :: xtemp

	integer :: threadnum, i ,j, k

	!$ call omp_set_num_threads(nthreads)

	!$omp parallel do private(threadnum, k) reduction(+: xtemp)
	do k=1, nrhs
		x(n,k) = b(n,k) / u(n,n)
		do i=n-1,1,-1         ! steps down from n-1 to 1
			!$ threadnum = omp_get_thread_num()
			!$ count(threadnum) = count(threadnum) + 1
			xtemp = b(i,k)
			do j=i+1,n
				xtemp = xtemp - u(i,j)*x(j,k)
				enddo
			x(i,k) = xtemp / u(i,i)
			enddo
		enddo

end subroutine sub3
