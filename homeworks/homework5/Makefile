
# 

OBJECTS = main.o cosexp.o writepts.o
FC	= gfortran
.PHONY: clean


myplot.png: plotpoints.py
	python plotpoints.py

plotpoints.py: points.txt
	python plotpoints.py

points.txt: fullcode.exe
	./fullcode.exe

fullcode.exe: $(OBJECTS)
	$(FC) $(OBJECTS) -o fullcode.exe

%.o : %.f90
	$(FC) -c $< 

clean:
	rm -f *.o *.exe points.txt

