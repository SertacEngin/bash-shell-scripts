#!/bin/bash

# Define the range
start=1
end=100

echo "Prime numbers between $start and $end are:"

# Loop through the range
for ((num=start; num<=end; num++))
do
  # Skip 0 and 1 as they are not prime numbers
  if [[ $num -le 1 ]]; then
    continue
  fi

  # Assume the number is prime
  is_prime=1

  # Check for factors from 2 to the square root of the number
  for ((i=2; i*i<=num; i++))
  do
    if (( num % i == 0 )); then
      is_prime=0
      break
    fi
  done

  # If the number is prime, print it
  if (( is_prime == 1 )); then
    echo "$num"
  fi
done

