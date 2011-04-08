"""
Module containing approximate functions using N terms of the Taylor series.

"""

import numpy as np

def exp(x, N=20):
    """
    Approximate exp(x) using N terms of the Taylor series.
    """

    # first term:
    term = 1.
    partial_sum = term

    for j in range(1,N):
        # j'th term is  x**j / j!  which is the previous term times x/j:
        term = term*x/j   
        # add this term to the partial sum:
        partial_sum += term   

    return partial_sum

def exp2(x, N=20):
    """
    Approximate exp(x) using N terms of the Taylor series.
    """

    # first term:
    term = 1.
    partial_sum = term
    y=np.abs(x)

    for j in range(1,N):
        # j'th term is  y**j / j!  which is the previous term times x/j:
        term = term*y/j   
        # add this term to the partial sum:
        partial_sum += term   

    partial_sum = np.where(x < 0. , 1./partial_sum, partial_sum)

    return partial_sum

def exp3(x, N=100):
    """
    Approximate exp(x) using N terms of the Taylor series.
    """

    # first term:
    term = 1.
    partial_sum = term
    y=np.abs(x)

    for j in range(1,N):
        # j'th term is  y**j / j!  which is the previous term times x/j:
        term = term*y/j   
        # add this term to the partial sum:
        partial_sum += term
	if np.all(np.abs(term) < 1.e-16*partial_sum):
	    break
    Nterms = j		# number of terms used
    partial_sum = np.where(x < 0. , 1./partial_sum, partial_sum)

    return partial_sum, Nterms
