"""
Approximate exp(x) using N terms of the Taylor series.
Prints out each term and partial sum along with the error relative to true
value.

This is an example of a program written as a script, with x and N hardwired.
"""

import numpy as np

x = 1.
N = 20
exp_true = np.exp(x)

print "\nTrue value: exp(%20.14e) = %20.14e" % (x, exp_true)
# Table heading:
print "\n   j       j'th term               partial_sum              error"

# first term:
term = 1.
partial_sum = term

for j in range(1,N):
    # j'th term is  x**j / j!  which is the previous term times x/j:
    term = term*x/j   
    # add this term to the partial sum:
    partial_sum += term   
    error = partial_sum - exp_true
    print "%4i    %17.10e    %21.14e    %17.6e" % (j,term,partial_sum,error)
