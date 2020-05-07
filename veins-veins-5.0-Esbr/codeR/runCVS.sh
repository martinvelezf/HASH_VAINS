#!/usr/bin/python3
import subprocess
import csv, os, glob
for file in glob.glob('*.sca'):
    command = "scavetool x {0}sca -o {0}csv".format(file[:-3])
    subprocess.call(command, shell=True)    # and execute when it looks correc
    print(command)
