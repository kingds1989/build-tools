#!/bin/bash

export LANG=C
#working directory
export WORKDIR=`pwd`
# path to the direcory where you want to install
export INSTALL_PATH=

cd ${WORKDIR}
PLACE=`pwd`

if [ -d ${WORKDIR}/LOG.my ]; then
   R1=`echo "${WORKDIR}/LOG.my : already existed"`
   if [ -f ${WORKDIR}/LOG.my/configure.log ]; then
       R2=`echo "${WORKDIR}/LOG.my/configure.log : already existed, but removed. create new configure.log"`
       rm -v ${WORKDIR}/LOG.my/configure.log
       touch ${WORKDIR}/LOG.my/configure.log
   else
       R2=`echo "${WORKDIR}/LOG.my/configure.log : create new configure.log"`
       touch ${WORKDIR}/LOG.my/configure.log
   fi
else
    R1=`echo "${WORKDIR}/LOG.my : create"`
    mkdir ${WORKDIR}/LOG.my
    R2=`echo "${WORKDIR}/LOG.my/configure.log : create new configure.log"`
    touch ${WORKDIR}/LOG.my/configure.log
fi
echo "pwd : ${PLACE}" 2>&1 | tee ${WORKDIR}/LOG.my/configure.log
echo "$R1" 2>&1 | tee -a ${WORKDIR}/LOG.my/configure.log
echo "$R2" 2>&1 | tee -a ${WORKDIR}/LOG.my/configure.log


export TIME1=`date '+%Y/%m/%d %H:%M:%S'`
./configure --prefix=${INSTALL_PATH} \
            --enable-threads \
            --with-gnu-ld=yes \
            --with-pkcs11=yes \
            --with-libtool \
            --with-openssl=yes \
            --with-python=yes \
            --with-libxml2=yes \
            --with-atf \
            2>&1 | tee -a ${WORKDIR}/LOG.my/configure.log
export TIME2=`date '+%Y/%m/%d %H:%M:%S'`
echo "-------------------- Time --------------------" | tee -a ${WORKDIR}/LOG.my/configure.log
echo "Start : JST ${TIME1}" | tee -a ${WORKDIR}/LOG.my/configure.log
echo "End   : JST ${TIME2}" | tee -a ${WORKDIR}/LOG.my/configure.log
echo "----------------------------------------------" | tee -a ${WORKDIR}/LOG.my/configure.log
