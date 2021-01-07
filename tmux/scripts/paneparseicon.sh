ARG=$1
ISVIM=""
NOTVIM=0
NOTBON=0
if [[ $ARG == *"NVIM" ]]; then
    ISVIM=" "
else
    NOTVIM=1
fi

arrIN=(${ARG/ - / })
INF=${arrIN[1]}
# PWD="${arrIN[2]/NVIM/}"

OUTPUT="$ISVIM$arrIN"
BONJOURN=`scutil --get LocalHostName`.
if [[ $OUTPUT == *$BONJOURN* ]]; then
    OUTPUT="${OUTPUT/$BONJOURN/ }"
else
    NOTBON=1
    TE=`$HOME/.tmux/scripts/getshortenpwd.sh $INF/`\)
    TE=${TE:1}
    OUTPUT=$OUTPUT$TE
fi

if [ $NOTVIM -eq 1 ] && [ $NOTBON -eq 1 ]; then
    echo " no info"
else
    echo $OUTPUT
fi
