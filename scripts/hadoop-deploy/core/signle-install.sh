#!/bin/bash
# Program:
#       This program is install hadoop.
# History:
# 2015/12/27 Kyle.b Release
# 
# 
function signle-install {
	array=("$@")
	arraylength=${#array[@]}

	SPARK_INDEX=$(index "--spark" ${array[@]})
	VERSION_INDEX=$(index "--version" ${array[@]})

	SPARK=""
	if [ $SPARK_INDEX -gt 0 ]; then
		ARGS="${array[$SPARK_INDEX]}"
		if [ "$ARGS" != "" ] && ([ "$ARGS" == "true" ] || [ "$ARGS" == "false" ]); then
			SPARK=${array[$SPARK_INDEX]}
		else
			msg "Option: --spark value error ..." "ERROR"
			exit 1
		fi
	fi

	VERSION=""
	if [ $VERSION_INDEX -gt 0 ]; then
		ARGS="${array[$VERSION_INDEX]}"
		if [ "$ARGS" != "" ] && echo $ARGS | grep -q "\d\.\d\.\d" ; then
			VERSION=${array[$VERSION_INDEX]}
		else
			msg "Option: --version value error ..." "ERROR"
			exit 1
		fi
	fi

	local spark=${SPARK:-"true"}
	local version=${VERSION:-"2.6.0"}
	
	begin=$(max $SPARK_INDEX $VERSION_INDEX)

	if [ -z "${array[$begin+1]}" ]; then
		msg "No host ..." "ERROR"
		exit 1
	fi

   echo $spark $version

	for (( i=$begin+2; i<${arraylength}+1; i++ )); do
		echo "[ ---------------- ${array[$i-1]} ---------------- ]"
		msg "Installing oracle java8 ....."
   		#install_jdk ${array[$i-1]} &>/dev/null
   		
   		msg "Installing other packages ....."
   		#install_other ${array[$i-1]} &>/dev/null
   		
   		msg "Automatically generated ssh keys ....."
   		#ssh-config ${array[$i-1]} &>/dev/null

   		msg "Installing Hadoop ....."
   		#install_hadoop ${version} ${array[$i-1]} &>/dev/null

	done
}