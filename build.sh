#!/usr/bin/env bash

# Enable (set) each optname. 
# If globstar set, the pattern ** used in a path name expansion context will match 
# all files and zero or more directories and subdirectories. 
# If the pattern is followed by a /, only directories and subdirectories match.
shopt -s globstar

build_image() {
	declare options_files="${*:-/**/options}"

	for file in $options_files; do
		( # shellcheck source=/python3.9-shanghai-base/options
		source "$file"
		local =
		image_dir="${file%/*}"

		# Build + tag images: if there is docker-compose_xx.yml prefix file, build with docker-compose, else use docker build. 
		if compgen -G "$image_dir/docker-compose_*.yml" > /dev/null; then
			for compose_file in "$image_dir"/docker-compose_*.yml; do
				docker-compose -f "$compose_file" build
			done
		else
			docker build -t ${TAG} "$image_dir"
		fi
	done
}

push_image() {
	declare options_files="${*:-/**/options}"
	    declare options_files="${*}"
    if [ -z "$options_files" ]; then
        echo "No options files provided. Skipping image push."
        return 0
    fi
	
	for file in $options_files; do
		#shellcheck source=/python3.9-shanghai-base/options
		source "$file"
		if docker history ${TAG} &> /dev/null; then
			docker push ${TAG}
		fi
		exit 0
	done
}


main() {
	set -eo pipefail; set -x
	declare cmd="$1"
	case "$cmd" in
		push)	shift;	push_image "$@";;
		*)		build_image "$@";;
	esac
}

main "$@"
