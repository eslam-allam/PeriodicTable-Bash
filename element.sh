# !/bin/bash

# Get passed variable
PASSED_VARIABLE=$1

# If empty
if [[ -z $PASSED_VARIABLE ]] 
then

  # Echo appropriate message and exit
  echo Please provide an element as an argument.
  exit
fi
# If variable is a number
if [[ $PASSED_VARIABLE =~ ^[0-9]+$ ]]
then

  # Query condition = atomic_number
  CONDITION="atomic_number"

# If variable is a character (regex only works with the elements in this database
elif [[ $PASSED_VARIABLE =~ ^[Aa-Zz]{1,2}$ ]] 
then

  # Query condition = symbol
  CONDITION="symbol"

# If variable is a word
elif [[ $PASSED_VARIABLE =~ ^[Aa-Zz]{3,} ]]
then

  # Query condition = name
  CONDITION="name"
fi

echo $CONDITION

# Get atomic number, name, symbol, type, mass, melting point, and boiling point using query condition

# If doesn't exist

  # Display not found message

# Else display element information


