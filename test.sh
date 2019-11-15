#!/bin/bash

export LANG=C
export WORKDIR=`pwd`

cd ${WORKDIR}

if [ -d ${WORKDIR}/LOG.my ]; then
   R1=`echo "${WORKDIR}/LOG.my : already existed"`
   if [ -f ${WORKDIR}/LOG.my/test.log ]; then
       R2=`echo "${WORKDIR}/LOG.my/test.log : already existed, but removed. create new test.log"`
       rm -v ${WORKDIR}/LOG.my/test.log
       touch ${WORKDIR}/LOG.my/test.log
   else
       R2=`echo "${WORKDIR}/LOG.my/test.log : create new test.log"`
       touch ${WORKDIR}/LOG.my/test.log
   fi
else
    R1=`echo "${WORKDIR}/LOG.my : create"`
    mkdir ${WORKDIR}/LOG.my
    R2=`echo "${WORKDIR}/LOG.my/test.log : create new test.log"`
    touch ${WORKDIR}/LOG.my/test.log
fi
echo "pwd : ${WORKDIR}" 2>&1 | tee ${WORKDIR}/LOG.my/test.log
echo "$R1" 2>&1 | tee -a ${WORKDIR}/LOG.my/test.log
echo "$R2" 2>&1 | tee -a ${WORKDIR}/LOG.my/test.log


export TIME1=`date '+%Y/%m/%d %H:%M:%S'`
make test 2>&1 | tee -a ${WORKDIR}/LOG.my/test.log
export TIME2=`date '+%Y/%m/%d %H:%M:%S'`
echo "-------------------- Time --------------------" | tee -a ${WORKDIR}/LOG.my/test.log
echo "Start : JST ${TIME1}" | tee -a ${WORKDIR}/LOG.my/test.log
echo "End   : JST ${TIME2}" | tee -a ${WORKDIR}/LOG.my/test.log
echo "----------------------------------------------" | tee -a ${WORKDIR}/LOG.my/test.log
