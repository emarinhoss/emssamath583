subroutine sub2(m, n, a, anorm1, anorminf, nthreads, count)

	use omp_lib
	integer, intent(in) :: m, n, nthreads
	real(kind=8), intent(out) :: anorm1, anorminf
	integer, dimension(0:15), intent(inout) :: count
	real(kind=8), dimension(n) :: dummy_i
	real(kind=8), dimension(m) :: dummy_j
	real(kind=8), dimension(1:m, 1:n), intent(in) :: a

	integer :: threadnum, i, j

	!$ call omp_set_num_threads(nthreads)
	
	anorm1 = 0.d0
	!$omp parallel do private(threadnum, i) reduction(max: dummy_i)
	do j=1,n
		do i=1,m
			!$ threadnum = omp_get_thread_num()
			!$ count(threadnum) = count(threadnum) + 1
			dummy_i(j) = dummy_i(j) + abs(a(i,j))
			enddo		
		anorm1 = max(anorm1, dummy_i(j))
		enddo

	anorminf = 0.d0
	!$omp parallel do private(threadnum, j) reduction(max: dummy_j)
	do i=1,m
		do j=1,n
			!$ threadnum = omp_get_thread_num()
			!$ count(threadnum) = count(threadnum) + 1
			dummy_j(i) = dummy_j(i) + abs(a(i,j))
			enddo		
		anorminf = max(anorminf, dummy_j(i))
		enddo

end subroutine sub2
