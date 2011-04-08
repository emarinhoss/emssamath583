"""
testpython.py file

Note: this is a Python script.  What you are reading now in the triple
quotes is a comment (a "docstring" since it's the first thing in this file).

This file is to test whether you have an appropriate Python version 
installed, along with NumPy and pylab (matplotlib).

To test this, do the following:
    Copy this file to your own directory $MYHG/homeworks/homework1
    and then, in Unix:
        $ cd $MYHG/homeworks/homework1
        $ python testpython.py

This should print out some statements about whether you're set up properly.

** NOTE ** If your version is less than 2.5 or it printed errors trying to
import a module, you should work on this before the next homework.
Get help from the TA if needed.

To finish this homework, do the following:
        $ python testpython.py > testoutput.txt
This will print the same thing into a file testoutput.txt for us to look at.
It's ok for this assignment if there were errors printed, we just want to
see the current state your system and make sure you can check into bitbucket.

Now commit this test script and the output to your bitbucket repository:
        $ hg add testpython.py testoutput.txt 
        $ hg commit -m "For HW1"
        $ hg push
    
"""

# Here's the script:

import sys

print "----------------------------------------------------------------"
print "Python version information:"
print sys.version
print "----------------------------------------------------------------"

# Try importing the modules, and print out whether successful or not:


try:
    import numpy
    print "Successfully imported numpy"   # only printed if import worked
except:
    # this is what's done if there was an error importing:
    print "*** Error importing numpy"


try:
    import pylab
    print "Successfully imported pylab"   # only printed if import worked
except:
    # this is what's done if there was an error importing:
    print "*** Error importing pylab"


print "Done with script"
print "----------------------------------------------------------------"

