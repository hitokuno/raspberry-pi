#!/bin/sh

GPIO=/sys/class/gpio/
CNT=10
WAIT=0.5s

PIN=$1
if [ -z ${PIN} ]; then
  exit 1
fi

GPPIN=${GPIO}gpio${PIN}
EXIST=0
if [ -d ${GPPIN} ]; then
  EXIST=1
fi

if [ $EXIST = 0 ]; then
  echo ${PIN} > ${GPIO}export
fi
echo out > ${GPIO}gpio${PIN}/direction
for i in `seq ${CNT}`
do
  echo 1 > ${GPIO}gpio${PIN}/value
  sleep ${WAIT}
  echo 0 > ${GPIO}gpio${PIN}/value
  sleep ${WAIT}
done

if [ $EXIST = 0 ]; then
  echo ${PIN} > ${GPIO}unexport
fi
