subroutine sub1(n, x, y, z, nthreads, count)

	use omp_lib
	integer, intent(in) :: n, nthreads
	integer, dimension(0:15), intent(inout) :: count
	real(kind=8), dimension(1:n), intent(in) :: x,y
	real(kind=8), dimension(1:n), intent(out) :: z
	real(kind=8) :: x_inf = -1.d300, y_inf = -1.d300, dumx, dumy

	integer :: threadnum

	!$ call omp_set_num_threads(nthreads)

	!$omp parallel do private(threadnum) reduction(max: x_inf, y_inf)
	do i=1,n
		!$ threadnum = omp_get_thread_num()
		!$ count(threadnum) = count(threadnum) + 1
		x_inf = max(x_inf, y(i))
		y_inf = max(y_inf, y(i))
		enddo

	!$omp parallel do private(threadnum)
	do i=1,n
		!$ threadnum = omp_get_thread_num()
		!$ count(threadnum) = count(threadnum) + 1
		dumx = x(i)/x_inf
		dumy = y(i)/y_inf
		if (dumx > dumy) then
			z(i) = dumx
			else
			z(i) = dumy
			endif
		enddo

end subroutine sub1
