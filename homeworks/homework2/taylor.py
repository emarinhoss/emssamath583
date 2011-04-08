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

def sin(x, N=20):
    """
    Approximate sin(x) using N terms of the Taylor series.
    """

    # first term:
    term = x
    partial_sum = term

    for j in range(3,N,2):
        # j'th term is  (-1)**j*x**(2j+1)/(2j+1)!  which is the previous term times x/j:
        term = term*(-x)*x/(j*(j-1))   
        # add this term to the partial sum:
        partial_sum += term   

    return partial_sum
