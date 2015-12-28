#!/bin/bash

# Colors
esc="\033"
bld="${esc}[1m"            #  Bold
rst="${esc}[0m"            #  Reset

bla="${esc}[30m"           #  Black          - Text
red="${esc}[31m"           #  Red            - Text
grn="${esc}[32m"           #  Green          - Text
ylw="${esc}[33m"           #  Yellow         - Text
blu="${esc}[34m"           #  Blue           - Text
mag="${esc}[35m"           #  Magenta        - Text
cya="${esc}[36m"           #  Cyan           - Text
whi="${esc}[37m"           #  Light Grey     - Text

bldbla=${bld}${bla}        #  Dark Grey      - Text
bldred=${bld}${red}        #  Red            - Bold Text
bldgrn=${bld}${grn}        #  Green          - Bold Text
bldylw=${bld}${ylw}        #  Yellow         - Bold Text
bldblu=${bld}${blu}        #  Blue           - Bold Text
bldmag=${bld}${mag}        #  Magenta        - Bold Text
bldcya=${bld}${cya}        #  Cyan           - Bold Text
bldwhi=${bld}${whi}        #  White          - Text

bgbla="${esc}[40m"         #  Black          - Background
bgred="${esc}[41m"         #  Red            - Background
bggrn="${esc}[42m"         #  Green          - Background
bgylw="${esc}[43m"         #  Yellow         - Background
bgblu="${esc}[44m"         #  Blue           - Background
bgmag="${esc}[45m"         #  Magenta        - Background
bgcya="${esc}[46m"         #  Cyan           - Background
bgwhi="${esc}[47m"         #  Light Grey     - Background

bldbgbla=${bld}${bgbla}    #  Dark Grey      - Background
bldbgred=${bld}${bgred}    #  Red            - Bold Background
bldbggrn=${bld}${bggrn}    #  Green          - Bold Background
bldbgylw=${bld}${bgylw}    #  Yellow         - Bold Background
bldbgblu=${bld}${bgblu}    #  Blue           - Bold Background
bldbgmag=${bld}${bgmag}    #  Magenta        - Bold Background
bldbgcya=${bld}${bgcya}    #  Cyan           - Bold Background
bldbgwhi=${bld}${bgwhi}    #  White          - Background

# Repo init our repo
echo -e ${bldblu}"Initializing Repo:"${bldcya}
repo init -u git://github.com/CyanPop/platform_manifest.git -b cm-13.0
   
# Repo SYNC
echo -e ${bldblu}"Syncing sources:"${bldcya}
repo sync -j5 -c --force-sync -f

# User Defined variables
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 300G

# CyanPop Version
export RELEASE_TYPE=CYANPOP_NIGHTLY

device="$1"

# Clean
if [ "$opt_clean" -eq 1 ]; then
    echo -e "${bldblu}Running 'make clobber'${rst}"
    make clobber
elif [ "$opt_clean" -eq 2 ]; then
    echo -e "${bldblu}Running 'rm -rf out/target'${rst}"
    rm -rf out/target
    echo
elif [ ! "$opt_clean" -eq 0 ]; then
    usage
fi

# Setup environment
echo -e "${bldcya}Setting up environment${rst}"
echo -e "${bldmag}${line}${rst}"
. build/envsetup.sh
echo -e "${bldmag}${line}${rst}"
echo

# Lunch device
echo -e "${bldcya}Lunching device${rst}"
breakfast "$device"

# Start compilation
    echo -e "${bldcya}Starting compilation: ${bldgrn}Building CyanPop "
    echo
    mka bacon 

