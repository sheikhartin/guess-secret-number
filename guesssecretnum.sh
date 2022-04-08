#!/bin/bash

read -p "Enter the start and end points (seperated by space): " rng_start rng_end
if [[ "${rng_start}" -ge "${rng_end}" ]]; then
  echo "The start number must be less than the end number."
  exit 1
fi

read -p "How many chances do you want to guess the number? " chances
if [[ "${chances}" -le 0 ]]; then
  echo "The number of chances must be greater than 0."
  exit 1
elif [[ "${chances}" -gt $(( rng_end - rng_start )) ]]; then
  echo "The number of chances must be less than the range difference."
  exit 1
fi

secret_num=$(( RANDOM % (rng_end - rng_start) + rng_start ))
echo "The secret number is generated."

for (( i = 1; i <= chances; i++ )); do
  read -p $'\n'"Please guess the number for the ${i} time: " guessed_num
  if [[ "${guessed_num}" -lt "${rng_start}" ]] \
    || [[ "${guessed_num}" -gt "${rng_end}" ]]; then
    echo "The number is out of range."
  elif [[ "${guessed_num}" -lt "${secret_num}" ]]; then
    echo "The number is too small."
  elif [[ "${guessed_num}" -gt "${secret_num}" ]]; then
    echo "The number is too big."
  else
    echo "Congratulations, you guessed the number!"
    exit 0
  fi
done

echo -e "\nYou lose! The secret number is ${secret_num}."
read -p "Do you want to give up? [Y/n] " giveup
if [[ "${giveup,,}" == "y" ]]; then
  x-www-browser "https://www.quora.com/why-should-we-give-up" &>/dev/null &
elif [[ "${giveup,,}" == "n" ]]; then
  x-www-browser "https://online.concordia.edu/computer-science/pros-and-cons-of-video-gaming" &>/dev/null &
else
  x-www-browser "https://bit.ly/3ISq21K" &>/dev/null &
fi
