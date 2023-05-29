#!/bin/bash

while [ 1 ]
do
    
	cpuIdle=$(cat /proc/stat|awk 'NR==1{print$5/100}')
    cpuIowait=$(cat /proc/stat|awk 'NR==1{print$6/100}')
    cpuIrq=$(cat /proc/stat|awk 'NR==1{print$7/100}')
	cpuNice=$(cat /proc/stat|awk 'NR==1{print$3/100}')
    cpuSoftirq=$(cat /proc/stat|awk 'NR==1{print$8/100}')
    cpuSystem=$(cat /proc/stat|awk 'NR==1{print$4/100}')
	cpuUser=$(cat /proc/stat|awk 'NR==1{print$2/100}')
    
	memAvailable=$(free|awk 'NR==2{print$7*1024}')
    
	diskCapacity=$(df /|awk 'NR==2{print$2*1024}')
    diskAvailable=$(df /|awk 'NR==2{print$4*1024}')

	filePath="/var/www/html/metrics/index.txt"

    exec 1>$filePath
    echo "# HELP my_own_node_cpu_seconds_total Seconds the CPUs spent in each mode."
    echo "# TYPE my_own_node_cpu_seconds_total counter"
    echo "my_own_node_cpu_seconds_total{cpu=\"0\",mode=\"idle\"} $cpuIdle"
    echo "my_own_node_cpu_seconds_total{cpu=\"0\",mode=\"iowait\"} $cpuIowait"
    echo "my_own_node_cpu_seconds_total{cpu=\"0\",mode=\"irq\"} $cpuIrq"
    echo "my_own_node_cpu_seconds_total{cpu=\"0\",mode=\"nice\"} $cpuNice"
    echo "my_own_node_cpu_seconds_total{cpu=\"0\",mode=\"softirq\"} $cpuSoftirq"
    echo "my_own_node_cpu_seconds_total{cpu=\"0\",mode=\"system\"} $cpuSystem"
    echo "my_own_node_cpu_seconds_total{cpu=\"0\",mode=\"user\"} $cpuUser"
    
	echo "# HELP node_memory_MemAvailable_bytes Memory information field MemAvailable_bytes."
    echo "# TYPE node_memory_MemAvailable_bytes gauge"
    printf "my_own_node_memory_MemAvailable_bytes %e\n" $memAvailable
    
    echo "# HELP my_own_node_filesystem_capacity_bytes Filesystem capacity in bytes."
    echo "# TYPE my_own_node_filesystem_capacity_bytes gauge"
    printf "my_own_node_filesystem_capacity_bytes{device=\"/dev/mapper/ubuntu--vg-ubuntu--lv\",fstype=\"ext4\",mountpoint=\"/\"} %e\n" $diskCapacity

	echo "# HELP my_own_node_filesystem_avail_bytes Filesystem space available to non-root users in bytes."
    echo "# TYPE my_own_node_filesystem_avail_bytes gauge"
    printf "my_own_node_filesystem_avail_bytes{device=\"/dev/mapper/ubuntu--vg-ubuntu--lv\",fstype=\"ext4\",mountpoint=\"/\"} %e\n" $diskAvailable
    
    sleep 3 # страница обновляется не чаще чем каждые 3 секунды с помощью цикла

done