
# 

OBJECTS = hilbertmain.o hilbert.o
FC	= gfortran
LFLAGS  = -lblas -llapack

.PHONY: clean
.PHONY: output

output: run.exe
	./run.exe

run.exe: $(OBJECTS)
	$(FC) $(LFLAGS) $(OBJECTS) -o run.exe

%.o : %.f90
	$(FC) -c $< 

clean:
	rm -f *.o *.exe *.txt

