"""
Read in a set of points from the text file points.txt and plot them.
"""

import sys
import numpy as np

try:
    import pylab
except:
    print "*** Trouble importing pylab! Aborting"
    sys.exit()

x,y = np.loadtxt("points.txt", unpack=True)

pylab.plot(x,y,'b-',linewidth=2)
pylab.title("Plot of y vs. x")
pylab.xlabel("x")
pylab.ylabel("y")
pylab.xlim([-7., 7.])
pylab.ylim([-1.2, 1.2])

pylab.savefig("myplot.png")

