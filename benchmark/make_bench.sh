#!/bin/bash

# prework: untar the linux kernel source of your choosing, create a .config
# then tar it up and define the tarballs basename in the 'source' variable below
# hint:
#  cd linux-6.10.10
#  make x86_64_defconfig
#  cd ..
#  tar cf linux-6.10.10 linux-6.10.10.tar
#
# define the other commented variable to match your system
#
# location of files on physical disk
test_path="/incoming"

# where to do the test - select a ramdisk (tmpfs) to min hdd usage
ramdisk="/scratch/bench"

# name of the tarball containing the preconfigured linux source in gz format
source="linux-6.10.10"

# make flags for benchmark
MAKEFLAGS='-j33'

# number of times to run benchmark knowing that the first run will be dropped (warm up)
limit=13

#####
NAME=$(uname -r)
RUNDATE=$(date "+%F %T")

do_bzimage() {
  bench=bzImage
  echo "Running Make..."
  echo "Kernel: $NAME"
  echo
  echo "Unpacking source..."
  [[ ! -d "$ramdisk/$source" ]] ; tar xf "$test_path/$source.tar" -C "$ramdisk"
  cd "$ramdisk/$source" || exit 1
  [[ ! -f "$test_path/results.csv" ]] && echo "run #,hostname,kernel,benchmark,time(sec),date" > "$test_path/results.csv"
  x=0
  echo "Starting benchmark; status will update as benchmark progresses."
  while [ $x -lt $limit ]; do
    x=$(( x + 1 ))
    make clean &>/dev/null
    begin=$(date +%s.%N)
    sleep 1s
    make $MAKEFLAGS bzImage &>/dev/null || exit
    end=$(date +%s.%N)

    diff=$(echo "scale=6; $end - $begin" | bc)
    simpdiff=$(echo "scale=2; $end - $begin" | bc)
    runsleft=$(echo "scale=2; $limit-$x"| bc)
    secleft=$(echo "scale=2; $runsleft*$diff"|bc)
    minleft=$(echo "scale=2; $runsleft*$diff/60"|bc)
    eta=$(date -d "($date) $secleft sec" +%r)
    echo "Run $x/$limit took $simpdiff seconds. ETA: $eta or about $minleft min from now."

    if [[ $x -eq 1 ]]; then
      # do not report the warmup run
      true
    else
      echo "$x,$HOSTNAME,$NAME,$bench,$diff,$RUNDATE" >> $test_path/results.csv
    fi
  done

  cd "$ramdisk" && rm -rf "${ramdisk:?}/${source:?}"
  echo
  echo "Benchmark done. Find results in $test_path/results.csv"
}

XSRUNNING=$(pidof xfce4-screensaver)
[[ -n "$XSRUNNING" ]] && kill "$XSRUNNING"
[[ ! -d $ramdisk ]] && mkdir -p $ramdisk

case "$1" in
  b)
    do_bzimage
    ;;
  *)
    echo "$0 {b}"
    exit 0
    ;;
esac
