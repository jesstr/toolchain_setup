
# ./add_cross PATHFROM PATHTO PRIO [PREFIX]

PATHFROM=$1
PATHTO=$2
PRIO=$3
PREFIX=${4:-"arm-none-eabi-"}

TOOL_SET=(
    "gcc"
    "gdb"
    "as"
    "size"
    "objcopy"
    "objdump"
    "nm"
)


usage() {
    echo "Usage: ./add_toolchain.sh PATHFROM PATHTO PRIO [PREFIX]"
}


if [ -z $1 ]; then
    echo "Error: PATHFROM is NOT set"
    usage
    exit 1
fi

if [ -z $2 ]; then
    echo "Error: PATHTO is NOT set"
    usage
    exit 1
fi

if [ -z $3 ]; then
    echo "Error: PRIO is NOT set"
    usage    
    exit 1
fi

for DIR in {$PATHFROM,$PATHTO}
do
    if [ ! -d $DIR ]; then
        echo "Error: Directory '$DIR' DOES NOT exists." 
        exit 1
    fi
done

for TOOL in ${TOOL_SET[@]}
do
    FILENAME=$PATHFROM/$PREFIX$TOOL
    if [ ! -f $FILENAME ]; then
        echo "Error: File '$FILENAME' DOES NOT exists." 
        exit 1
    fi
done


PATHFROM=$(realpath $PATHFROM)
PATHTO=$(realpath $PATHTO)

for TOOL in ${TOOL_SET[@]}
do
    if [ $TOOL != "gcc" ]; then
        FILENAME=$PREFIX""$TOOL
        SLAVES+="--slave $PATHTO/$FILENAME $FILENAME $PATHFROM/$FILENAME "
    fi
done

sudo update-alternatives --install $PATHTO/$PREFIX"gcc" $PREFIX"gcc" $PATHFROM/$PREFIX"gcc" $PRIO $SLAVES

VERSION=$($PREFIX"gcc" -dumpversion)
echo "You are using '$PREFIX"gcc"' version: $VERSION"
