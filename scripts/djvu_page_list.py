#!/usr/bin/env python3

COVER_PAGE = 1
MIN_ROMAN = 1
MAX_ROMAN = 5
MIN_ARABIC = 1
MAX_ARABIC = 154
NEW_PAGE = "new_page_list"

def int_to_roman(num):
    # Define the mapping of integer values to Roman numeral symbols
    val = [
        1000, 900, 500, 400,
        100, 90, 50, 40,
        10, 9, 5, 4,
        1
    ]
    syms = [
        "m", "cm", "d", "cd",
        "c", "xc", "l", "xl",
        "x", "ix", "v", "iv",
        "i"
    ]
    
    # Initialize the result string
    roman_numeral = ""
    
    # Iterate through the integer values and construct the Roman numeral
    for i in range(len(val)):
        while num >= val[i]:
            roman_numeral += syms[i]
            num -= val[i]
    
    return roman_numeral

def main():
    with open("new_page_list", 'w') as f:
        page = 1
        if COVER_PAGE is not None:
            f.write(f'select {page}; set-page-title "Cover"\n')
            page += 1

        for idx in range(MIN_ROMAN, MAX_ROMAN+1):
            f.write(f'select {page}; set-page-title "{int_to_roman(idx)}"\n')
            page += 1

        for idx in range(MIN_ARABIC, MAX_ARABIC+1):
            f.write(f'select {page}; set-page-title "{idx}"\n')
            page += 1

if __name__ == "__main__":
    main()
