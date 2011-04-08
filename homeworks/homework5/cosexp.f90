
subroutine cosexp(x,y,n)
    integer, intent(in) :: n
    real(kind=8), dimension(n), intent(in) :: x
    real(kind=8), dimension(n), intent(out) :: y
    integer :: i

    do i=1,n
	if (x(i) < 0.d0) then
		y(i) = cos(x(i))
		else
		y(i) = exp(-x(i))
		endif
	enddo

end subroutine cosexp
