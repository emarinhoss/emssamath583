
subroutine writepts(x,y,n)
    integer, intent(in) :: n
    real(kind=8), dimension(n), intent(in) :: x,y
    integer :: i

    ! write the data points x(i),y(i) out to a text file.

    open(unit=20, file="points.txt",status="unknown")

    do i=1,n
        write(20,201) x(i),y(i)
201     format(2e25.10)
        enddo

end subroutine writepts

