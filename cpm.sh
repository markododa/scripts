#!/bin/bash
shopt -s extglob

# self explanatory
usage() {
  cat <<EOF
usage:  mvmusic <options>
        -s <source dir> 
        -p <playlist>
        -d <destination>

        all three options are mandatory
        <playlist> must be a .m3u file, with filenames seperated by newlines

        this will copy every file in <playlist> from <source dir> to <destination>.
        if the files do not exist in <source dir>, they will be skipped.
        if <destination> does not exist, it will be created.
EOF
}

# get options
if (($# == 6)); then
  for ((i=1; i<=6; i++)); do
    case "${!i}" in
      -s)
        ((i++))
        sourcedir="${!i}"
        ;;
      -d)
        ((i++))
        destdir="${!i}"
        ;;
      -p)
        ((i++))
        [[ ${!i} = *.m3u ]] && playlist="${!i}"
        ;;
    esac
  done
fi

# check to make sure everything is valid
if [[ -z $sourcedir || -z $destdir || -z $playlist ]]; then
  usage
  exit 1
fi
if [[ ! -f $playlist ]]; then
  printf "%s\n" "error: $playlist is not a valid file"
  usage
  exit 1
fi
if [[ ! -d $sourcedir ]]; then
  printf "%s\n" "error: $sourcedir does not exist or is not a directory"
  usage
  exit 1
fi
[[ -d $destdir ]] || mkdir "$destdir"

# actually do the moving
while read -r song; do
  if ! cp "$sourcedir/$song" "$destdir"; then
    printf  "%s\n" "copy of $sourcedir/$song to $destdir failed" \
            "$sourcdir/$song probably doesn't exist"
  fi

sed s'/.*\///' $playlist > $destdir/playlist.m3u

done < "$playlist"
