# !/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

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
  ATOMIC_NUMBER=$PASSED_VARIABLE

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

# If atomic number not provided
if [[ $CONDITION != "atomic_number" ]]
then

  # get atomic number using condition
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE $CONDITION = '$PASSED_VARIABLE'")
fi
# Get name, symbol, type, mass, melting point, and boiling point using atomic number
ELEMENT_INFORMATION=$($PSQL "SELECT name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $ATOMIC_NUMBER")
# If doesn't exist
if [[ -z $ELEMENT_INFORMATION ]] 
then

  # Display not found message
  echo "I could not find that element in the database."

# If exists
else
  # Seperate into variables
  IFS="|" read -r NAME SYMBOL TYPE MASS MELTING_POINT BOILING_POINT <<< $ELEMENT_INFORMATION
  
  # Display element information
  echo "The element with atomic number $(echo $ATOMIC_NUMBER | sed -E 's/^ *| *$//g') is $(echo $NAME | sed -E 's/^ *| *$//g') ($(echo $SYMBOL | sed -E 's/^ *| *$//g')). It's a $(echo $TYPE | sed -E 's/^ *| *$//g'), with a mass of $(echo $MASS | sed -E 's/^ *| *$//g') amu. $(echo $NAME | sed -E 's/^ *| *$//g') has a melting point of $(echo $MELTING_POINT | sed -E 's/^ *| *$//g') celsius and a boiling point of $(echo $BOILING_POINT | sed -E 's/^ *| *$//g') celsius."
fi


