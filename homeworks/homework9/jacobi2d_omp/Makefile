
FC = gfortran
FFLAGS = -fbounds-check -fopenmp
LFLAGS = -fbounds-check -fopenmp

.PHONY: plots, clean

%.o : %.f90
	$(FC) $(FFLAGS) -c $<

jacobi2d.exe: jacobi2d_main_omp.o jacobi2d_sub_omp.o
	$(FC) $(LFLAGS) jacobi2d_main_omp.o jacobi2d_sub_omp.o -o jacobi2d.exe

heatsoln.txt: jacobi2d.exe
	./jacobi2d.exe

plots: heatsoln.txt
	python plotheat2d.py

clean:
	rm -f *.o *.exe heatsoln.txt *.png
