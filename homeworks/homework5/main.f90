program main

	implicit none
	integer, parameter :: n = 1000
	real (kind=8), dimension(n) :: x, y
	real (kind=8) :: dx, pi
	integer :: i
	
	! define the value of pi
	pi = acos(-1.d0)

	! create the values of matrix x
	dx = 4.d0*pi/float(n-1)
	do i=1,n
	        x(i) = -2.d0*pi + (i-1)*dx
		enddo

	! calculate the values of  y
	call cosexp(x,y,n)

	! write the x and y values into file points.txt
	call writepts(x,y,n)

end program main
