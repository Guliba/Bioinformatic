#!/bin/bash
###
### RextraBAM_v1.0 - Region extract from bam file by samtools
### Author: OK
### Data:   2021-8
###
### Usage:
###   ./RextraBam.sh <input_BamfileName> <input_Position>
###
### Options:
###   <input>           Input file to read.
###   <input_Posision>  Input position. e. chr1:1000-2000
###   -h                Show this message.

help() {
    sed -rn 's/^### ?//;T;p' "$0"
}

if [[ $# == 0 ]] || [[ "$1" == "-h" ]]; then
    help
    exit 1
fi

if [ ! -e $1.bam.bai ];then
	echo "No bam index file. Start to build index.."
        samtools index -@ 20 $1.bam
	wait	
	echo "index builded"

	sleep 1

	echo "start samtools.."
        samtools view -b -h $1.bam $2 > $1_$2.bam
	sleep 1
	wait
	echo "samtools done!"
else
	echo "start samtools.."
	samtools view -b -h $1.bam $2 > $1_$2.bam
	sleep 1
	wait
	echo "samtools done!"
fi

samtools index $1_$2.bam

wait

rename 's/:/_/' *
