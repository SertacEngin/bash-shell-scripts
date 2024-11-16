#!/bin/bash

# Loop through a range of numbers
for i in {1..100}
do
  # Check if number is divisible by 3 or 5 but not 15
  if (( i % 3 == 0 || i % 5 == 0 )) && (( i % 15 != 0 )); then
    echo $i
  fi
done

