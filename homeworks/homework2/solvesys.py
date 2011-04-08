"""
Uses the numpy.linalg.solve command to solve the Ax=b system.
"""

import numpy as np

# -------------------------------------------------------------------
A = np.array([[3,4,-1.4],[2.1,1,0],[0,5.1,2]])
b = np.array([24.6,14.02,11.81])

# -------------------------------------------------------------------
x = np.linalg.solve(A,b)

# -------------------------------------------------------------------
print "A = "
print A

print "b = "
print b

print "x = "
print x

# -------------------------------------------------------------------
# -------------------------------------------------------------------
A = np.eye(5)
A[0,3] = 2
A[1,4] = 4
# -------------------------------------------------------------------
b = np.ones((5,1))
b = 2*b
# -------------------------------------------------------------------
# -------------------------------------------------------------------
x = np.linalg.solve(A,b)

# -------------------------------------------------------------------
print "A = "
print A

print "b = "
print b.T

print "x = "
print x.T