#!/bin/sh

GPIO=/sys/class/gpio/
WAIT=0.1s

err() {
  echo "syntax : repeat_gpio.sh in/out pin cycle"
  echo "example: repreat_gpio.sh in  21 10"
  echo "example: repreat_gpio.sh out 21 10"
  exit 1
}

if [ ! $# = 3 ]; then
  err
fi
if [ $1 != "out" -a $1 != "in" ]; then
  err
fi

MODE=$1
PIN=$2
CNT=$3
GP_PIN=${GPIO}gpio${PIN}
EXIST=0
if [ -d ${GP_PIN} ]; then
  EXIST=1
fi

if [ $EXIST = 0 ]; then
  echo ${PIN} > ${GPIO}export
fi
echo ${MODE} > ${GP_PIN}/direction
for i in `seq ${CNT}`
do
  if [ ${MODE} = "in" ]; then
    cat ${GP_PIN}/value
  else
    echo 1 > ${GP_PIN}/value
    sleep ${WAIT}
    echo 0 > ${GP_PIN}/value
  fi
  sleep ${WAIT}
done

if [ $EXIST = 0 ]; then
  echo ${PIN} > ${GPIO}unexport
fi
