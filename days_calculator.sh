#!/bin/bash

echo "Enter start date (dd/mm/yyyy): "
read START_DATE

VALIDATE_START_DATE="$(echo "${START_DATE}" | \
grep '^[1-9]/[1-9]/[0-9]\{4\}$\|^[0-1][0-9]/[1-9]/[0-9]\{4\}$\|^[0-3][0-9]/[1-9]/[0-9]\{4\}$\|^[0-3][0-9]/[0-1][0-9]/[0-9]\{4\}$')"

if [ "${VALIDATE_START_DATE}" == "${START_DATE}" ]; then
  START_DAY="$(echo "${START_DATE}" | awk -F/ {'print $1'})"

  if [ ${START_DAY} -le 0 ] || [ ${START_DAY} -gt 31 ]; then
    echo "${START_DAY} is in valid"
    exit
  fi

  START_MONTH="$(echo "${START_DATE}" | awk -F/ {'print $2'})"

  if [ ${START_MONTH} -le 0 ] || [ ${START_MONTH} -gt 12 ]; then
    echo "${START_MONTH} is in valid"
    exit
  fi

  START_YEAR="$(echo "${START_DATE}" | awk -F/ {'print $3'})"

  if [ ${START_YEAR} -le 1900 ] || [ ${START_YEAR} -gt 2999 ]; then
    echo "${START_YEAR} is in valid"
    exit
  fi

else
  echo "Input date ${START_DATE} is not valid."
  exit
fi

echo "Enter end date (dd/mm/yyyy): "
read END_DATE

VALIDATE_END_DATE="$(echo "${END_DATE}" | \
grep '^[1-9]/[1-9]/[0-9]\{4\}$\|^[0-1][0-9]/[1-9]/[0-9]\{4\}$\|^[0-3][0-9]/[1-9]/[0-9]\{4\}$\|^[0-3][0-9]/[0-1][0-9]/[0-9]\{4\}$')"

if [ "${VALIDATE_END_DATE}" == "${END_DATE}" ]; then
  END_DAY="$(echo "${END_DATE}" | awk -F/ {'print $1'})"

  if [ ${END_DAY} -le 0 ] || [ ${END_DAY} -gt 31 ]; then
    echo "${END_DAY} is in valid"
    exit
  fi

  END_MONTH="$(echo "${END_DATE}" | awk -F/ {'print $2'})"

  if [ ${END_MONTH} -le 0 ] || [ ${END_MONTH} -gt 12 ]; then
    echo "${END_MONTH} is in valid"
    exit
  fi

  END_YEAR="$(echo "${END_DATE}" | awk -F/ {'print $3'})"

  if [ ${END_YEAR} -le 1900 ] || [ ${END_YEAR} -gt 2999 ]; then
    echo "${END_YEAR} is in valid"
    exit
  fi
else
  echo "Input date ${END_DATE} is not valid."
  exit
fi

NODEJS_DATE="$(cat << _TEXTBLOCK_
const oneDay = 24 * 60 * 60 * 1000; // hours*minutes*seconds*milliseconds

const startDate = new Date(${START_YEAR}, ${START_MONTH}, ${START_DAY});
const endDate = new Date(${END_YEAR}, ${END_MONTH}, ${END_DAY});

const numberOfDays = Math.round(Math.abs((startDate - endDate) / oneDay) - 1);

console.log(numberOfDays)
_TEXTBLOCK_
)"

echo "${NODEJS_DATE}" > /tmp/days_calc.js

node /tmp/days_calc.js



