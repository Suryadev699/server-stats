#!/bin/bash

showuptime(){
	up=$(uptime -p | cut -c4-)
	since=$(uptime -s)
	cat << EOF
----
This machine has been up for ${up}
It has been running since ${since}
----
EOF
}
showuptime

totcpuusage(){
	tcu=$(mpstat)
	cat << EOF
The total CPU Usage on this machine is ${tcu}
----
EOF
}
totcpuusage

memusage(){
	memuse=$(free -h)
	percentage=$(free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
	cat << EOF
Total ${percentage}
----
EOF
}
memusage

dskusage(){
	dskuse=$(df -h)
	percent=$(df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3, $2, $5}')
	cat << EOF
Total ${percent}
----
EOF
}
dskusage

cat "Top 5 CPU & Memory Usage"

cpumem(){
	cpu=$(ps -eo pid,cmd,%mem,%cpu --sort=-%cpu | head -6)
	mem=$(ps -eo pid,cmd,%mem,%cpu --sort=-%mem | head -6)
	cat << EOF

Top 5 CPU:
${cpu}

Top 5 Memory:
${mem}
----
EOF
}
cpumem

echo "Exiting now..."
