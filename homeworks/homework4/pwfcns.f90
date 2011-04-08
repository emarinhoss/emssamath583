

program pwfcns

    implicit none
    real (kind=8) :: x, y, a, b, dx
    real (kind=8), external :: f1
    integer i, npts

    a = -1.
    b = 4.
    npts = 20
    dx = (b-a)/float(npts-1)
    do i=1,npts
        x = a + (i-1)*dx
        y = f1(x)
        print "(2d20.10)", x,y
        enddo

end program pwfcns

function f1(z)
   implicit none
   real (kind=8), intent(in) :: z
   real (kind=8) :: f1

   if (z < 0.d0) then
	f1 = cos(z)
   elseif (Z <= 1.d0) then
	f1 = z**3
   elseif ((z < 2.5d0) .or. (z >= 3.d0)) then
	f1 = z - 3.d0
   else
	f1 = sqrt(z)
   endif

end function f1
