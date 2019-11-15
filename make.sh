#!/bin/bash

export LANG=C
export WORKDIR=`pwd`

cd ${WORKDIR}
PLACE=`pwd`

if [ -d ${WORKDIR}/LOG.my ]; then
   R1=`echo "${WORKDIR}/LOG.my : already existed"`
   if [ -f ${WORKDIR}/LOG.my/make.log ]; then
       R2=`echo "${WORKDIR}/LOG.my/make.log : already existed, but removed. create new make.log"`
       rm -v ${WORKDIR}/LOG.my/make.log
       touch ${WORKDIR}/LOG.my/make.log
   else
       R2=`echo "${WORKDIR}/LOG.my/make.log : create new make.log"`
       touch ${WORKDIR}/LOG.my/make.log
   fi
else
    R1=`echo "${WORKDIR}/LOG.my : create"`
    mkdir ${WORKDIR}/LOG.my
    R2=`echo "${WORKDIR}/LOG.my/make.log : create new make.log"`
    touch ${WORKDIR}/LOG.my/make.log
fi
echo "pwd : ${PLACE}" 2>&1 | tee ${WORKDIR}/LOG.my/make.log
echo "$R1" 2>&1 | tee -a ${WORKDIR}/LOG.my/make.log
echo "$R2" 2>&1 | tee -a ${WORKDIR}/LOG.my/make.log


export TIME1=`date '+%Y/%m/%d %H:%M:%S'`
make --jobs=4 2>&1 | tee -a ${WORKDIR}/LOG.my/make.log
export TIME2=`date '+%Y/%m/%d %H:%M:%S'`
echo "-------------------- Time --------------------" | tee -a ${WORKDIR}/LOG.my/make.log
echo "Start : JST ${TIME1}" | tee -a ${WORKDIR}/LOG.my/make.log
echo "End   : JST ${TIME2}" | tee -a ${WORKDIR}/LOG.my/make.log
echo "----------------------------------------------" | tee -a ${WORKDIR}/LOG.my/make.log
