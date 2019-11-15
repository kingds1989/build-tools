#!/bin/bash

export LANG=C
export WORKDIR=`pwd`

cd ${WORKDIR}
PLACE=`pwd`

if [ -d ${WORKDIR}/LOG.my ]; then
   R1=`echo "${WORKDIR}/LOG.my : already existed"`
   if [ -f ${WORKDIR}/LOG.my/install.log ]; then
       R2=`echo "${WORKDIR}/LOG.my/install.log : already existed, but removed. create new install.log"`
       rm -v ${WORKDIR}/LOG.my/install.log
       touch ${WORKDIR}/LOG.my/install.log
   else
       R2=`echo "${WORKDIR}/LOG.my/install.log : create new install.log"`
       touch ${WORKDIR}/LOG.my/install.log
   fi
else
    R1=`echo "${WORKDIR}/LOG.my : create"`
    mkdir ${WORKDIR}/LOG.my
    R2=`echo "${WORKDIR}/LOG.my/install.log : create new install.log"`
    touch ${WORKDIR}/LOG.my/install.log
fi
echo "pwd : ${PLACE}" 2>&1 | tee ${WORKDIR}/LOG.my/install.log
echo "$R1" 2>&1 | tee -a ${WORKDIR}/LOG.my/install.log
echo "$R2" 2>&1 | tee -a ${WORKDIR}/LOG.my/install.log


export TIME1=`date '+%Y/%m/%d %H:%M:%S'`
make install 2>&1 | tee -a ${WORKDIR}/LOG.my/install.log
export TIME2=`date '+%Y/%m/%d %H:%M:%S'`
echo "-------------------- Time --------------------" | tee -a ${WORKDIR}/LOG.my/install.log
echo "Start : JST ${TIME1}" | tee -a ${WORKDIR}/LOG.my/install.log
echo "End   : JST ${TIME2}" | tee -a ${WORKDIR}/LOG.my/install.log
echo "----------------------------------------------" | tee -a ${WORKDIR}/LOG.my/install.log
