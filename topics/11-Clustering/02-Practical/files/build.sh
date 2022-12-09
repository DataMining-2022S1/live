#!/bin/bash
if [ $# -lt 1 ]; then
	echo "### Usage $0 <option> where <option> is either -b (build) or -c (clean)"
	echo "Stopping..."
	exit 1
fi

if [ "$1" == '-b' ]; then

	d=clusSupport
  [ ! -d $d ] && ln -s ../../../../datasets/$d .
  zip -r ${d}.zip $d

	d=data
  [ ! -d $d ] && ln -s ../../../../datasets/12-Blobs/$d .
  zip -r ${d}.zip $d

	L=Practical_A_GeneratedData.py
  [ ! -L $L ] && ln -s ../../../../datasets/12-Blobs/KM_GMM.py $L
  fromPy $L
	L=Practical_B_GMM.py
  [ ! -L $L ] && ln -s ../../../../datasets/12-Blobs/GMM_DBSCAN.py $L
  fromPy $L
	L=Practical_C_DigitsData.py
  [ ! -L $L ] && ln -s ../../../../datasets/09-Digits/GMM_KM.py $L
  fromPy $L

elif [ "$1" == '-c' ]; then

	for d in clusSupport data; do
	  [ -d $d ] && unlink $d
	done
	for f in Practical_A_GeneratedData.py Practical_B_GMM.py Practical_C_DigitsData.py; do
    [ -f  $f ] && unlink $f
	done
	[ -d .ipynb_checkpoints ] && rm -rf .ipynb_checkpoints

else

	echo "### Invalid option $1 must be either -b or -c"
	exit 2
	
fi
# Remember: chmod u+x build.sh
