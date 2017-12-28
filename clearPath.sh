#! /bin/bash
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
	echo "Using: ./$0 [OPTIONS]."
	echo 'This script outputs directories in which there are executable files.'
	echo '[OPTIONS] is following:'
	echo '-h/--help displays this help message'
	echo '-p/--path <directory 1:directory 2>(required) Path to directory (there should be no relative ways)'
	exit
fi

if [ -z "$1" ]; then
	echo $PATH
	Path="$PATH"
else
	while [ $# != 0 ]; do
    	case "$1" in
        	-p|--Path)
		    if ! [ -z "$2" ]; then
            		Path="$2"
	            else
	            	echo "Not path"
	            	exit
	            fi
	            shift 2
	            ;;
	        *)
	            echo 'Try use "-h" or "--help" after command.'
	            exit
	            ;;
	    esac
	done
fi

newPath=''
IFS=":"
for dir in $Path;
do
if [[ "$dir" =~ ^(\.{1,2}(\/|$)) ]]; then
  echo "Use $0 -h or --help"
  exit
fi
done

for dir in $Path;
do
	#echo "$dir"
	if [ -d "$dir" ]; then
		cd "$dir"
		#echo "$dir"
		#ls -l "$dir"
		for file in *;
		do
			if [[ -x "$file" && -f "$file" ]]; then
				if ! [ "$newPath" == "" ]; then
					newPath="$newPath":"$dir"
					else
					newPath="$dir"
					fi
				break
			fi
		done
	fi
done
echo "$newPath"
