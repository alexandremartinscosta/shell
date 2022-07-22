## Shell Script da Barra de Status

## Internet
net() {
	ip=`ip route | awk '/default/ {print $9}'`
	echo -e "IP: $ip"
}

## Data
dte() {
	dte="$(date +"%A, %D -%l:%M%p")"
	echo -e "$dte"
}

## HD
hd() {
	hdus="$(df -h | awk 'NR==4{print $3}')"
	hdpc="$(df -h | awk 'NR==4{print $5}')"
	echo -e "HDD: $hdus ($hdpc)"
}

## RAM
mem() {
	mem=`free | awk '/Mem/ {printf "%d MiB / %d MiB\n", $3 / 1024.0, $2 / 1024.0 }'`
	echo -e "MEM: $mem"
}

## CPU
cpu() {
	read cpu a b c previdle rest < /proc/stat
	prevtotal=$((a+b+c+previdle))
	sleep 0.5
	read cpu a b c idle rest < /proc/stat
	total=$((a+b+c+idle))
	cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
	echo -e "CPU: $cpu%"
}

## Volume
vol() {
	vol=`amixer get Master | tail -1 | awk '{print $4}' | cut -c 2-5`
	echo -e "VOL: $vol"
}

## Loop
main() {
	while :; do
    		echo "$(net) | $(cpu) | $(mem) | $(hd) | $(vol) | $(dte)"
    		sleep 1
	done
}

main
