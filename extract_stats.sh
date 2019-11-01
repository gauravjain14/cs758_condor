trap quit INT
function quit() {
    echo "quitting early and killing children..."
    for pid in ${pids[*]}; do
        kill $pid
    done
    exit
}

parent_dir=$1
launch_dir=${PWD}

declare -a configs=("faTLB-128entry-20lat" "faTLB-128entry-40lat" "faTLB-64entry-20lat" "8wayTLB-128entry-20lat" "8wayTLB-128entry-40lat" "8wayTLB-64entry-20lat")
declare -a benchmarks=("bfs" "backprop" "nw" "nn" "pagerank" "bc")


failed=false
for benchmark in ${benchmarks[@]}
do
    for config in ${configs[@]}
    do
		#cd ${PWD}/${parent_dir}/${config}_${benchmark}
		cd ${parent_dir}/${config}_${benchmark}
		if [ -d "results/" ]
		then
			if [ ! -f "results/${benchmark}.err" ]
			then
				echo "${config}_${benchmark} Didn't complete!" 
			else
				if [ -s "results/${benchmark}.err" ]
				then
					echo "${config}_${benchmark} Failed. Error File Not Empty!"
				fi
			fi
		fi
		cd ${launch_dir}
	done
done
