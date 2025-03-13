#!/usr/bin/env python3
import sys

BOHR_TO_ANGSTROM = 0.52917721067

def get_lines(filename):
    with open(filename, 'r') as fd:
        return fd.readlines()

def coordlines_to_data(line):

    tokens = line.split()

    x = float(tokens[0]) * BOHR_TO_ANGSTROM
    y = float(tokens[1]) * BOHR_TO_ANGSTROM
    z = float(tokens[2]) * BOHR_TO_ANGSTROM

    atom_type = tokens[3].upper()
    
    frozen = False
    if len(tokens) == 5:
        frozen = tokens[4].upper() == 'F'
        # atom_type = 'X'

    return (atom_type, x, y, z, frozen)


if __name__ == "__main__":

    coord_filename = sys.argv[1]

    lines = get_lines(coord_filename)

    print(len(lines) - 2)
    print( ".xyz output generated from file:", coord_filename)

    for line in lines[1:-1]:
        (atom_type, x, y, z, frozen) = coordlines_to_data(line)
        print(f"{atom_type:>2}   {x:20.12f} {y:20.12f} {z:20.12f}{' F' if frozen else ''}")
