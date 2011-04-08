
import numpy as np
#import pylab
import time

def f1(x):
    tstart = time.clock()
    y = np.zeros(x.shape)     # initialize to same shape as x
    for j in range(len(x)):
        if x[j] < 0.:
            y[j] = np.cos(x[j])
        elif x[j] <= 1.:
            y[j] = x[j]**3
        elif (x[j] < 2.5) or (x[j] >= 3.):
            y[j] = x[j] - 3.
        else:
            y[j] = np.sqrt(x[j])
    t_cpu = time.clock() - tstart
    return y, t_cpu

def f2(x):
    tstart = time.clock()
    y = np.zeros(x.shape)     # initialize to same shape as x
    y = np.where(x <  0.0, np.cos(x), y)
    y = np.where(x >= 0.0, x**3, y)
    y = np.where(x >  1.0, x-3, y) 
    y = np.where(x >= 2.5, np.sqrt(x), y)
    y = np.where(x >= 3., x-3, y)
    t_cpu = time.clock() - tstart
    return y, t_cpu


#x = np.linspace(-1., 4., 100)
#y = f2(x)

#pylab.clf()            # clear figure
#pylab.plot(x,y,'bo')   # plot with blue circles
#pylab.show()           # Show the plot.  Note: this may cause pylab to hang.
