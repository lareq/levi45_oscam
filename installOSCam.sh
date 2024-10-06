#!/bin/bash
#### "***********************************************"
#### "*       ..:: Script by MOHAMED_OS ::..        *"
#### "*  Support: https://github.com/MOHAMED19OS    *"
#### "*       E-Mail: mohamed19eng@gmail.com        *"
#### "***********************************************"
FIN="<--------------------------------------------->"

#mod 06.10.2024 lareq
OPLI=false
##### Path File #####
TMPDIR="/tmp/Levi45"
CONFIGPATH='/etc/tuxbox/config'
DIR="/usr/bin"
SCRIPTPATH="/etc/init.d"
BINDIR="/usr/bin"
SOURCESCRIPTNAME="egami_bh_domica_peterPan_opli.sh"


#Manager /usr/camscript  OSCam_manager-802.sh

#OSCam_Pure2_Merlin3_oozon-802.sh
#Pure2 Merlin3
#WHERE /usr/script/cam
#oozone
#where /usr/script    
#ppteam
#/usr/ppteam  file with pp extension not sh
#BH /usr/camscript Ncam_OSCam_11840-802.sh

#delete older oscam files leaving only 2 newest
FILES=($(ls -1tr ${DIR}/OSCa* 2>/dev/null))
if [ ${#FILES[@]} -gt 2 ]; then
    DELETE_COUNT=$((${#FILES[@]} - 2))
    for ((i=0; i<DELETE_COUNT; i++)); do
        echo "Deleting: ${FILES[$i]}"
        rm -f "${FILES[$i]}"
    done
fi

file=$(find $TMPDIR/OSCAM -type f | head -n 1)

if [[ -n "$file" ]]; then
  filename=$(basename "$file")
  echo "${filename:0:11}"
  BIN=${filename:0:11}
fi

#### Binary File ####
BIN_FILES="oscam"
BIN="$BIN-802"

SSL_VERSION=$(openssl version)

# Determine which script to run based on the OpenSSL version
if [[ $SSL_VERSION == *"1.0.2"* ]]; then
    SSL_VERSION='ssl102'
elif [[ $SSL_VERSION == *"1.1.1"* ]]; then
    SSL_VERSION='ssl111'
elif [[ $SSL_VERSION == *"3."* ]]; then
    SSL_VERSION='ssl310'
else
    echo "Unsupported OpenSSL version: $openssl_version"
    exit 1
fi

#### checking your device and bin file #####
echo ${FIN}
echo ":I'm checking your device processor ..."

if uname -m | grep -qs armv7l; then
    ARCH='arm'
elif uname -m | grep -qs aarch64; then
    ARCH='aarch64'
elif uname -m | grep -qs mips; then
    ARCH='mips'
elif uname -m | grep -qs 7401c0; then # dm800 clone
    ARCH='mips'
elif uname -m | grep -qs sh4; then
    ARCH='sh4'
else
    echo "Sorry, your device does not have the proper CPU :("
    rm -rf ${TMPDIR} >/dev/null 2>&1
    exit 1
fi

#here we move oscam binary file
mv -f "${TMPDIR}/OSCAM/${BIN}-${ARCH}-${SSL_VERSION}" "${TMPDIR}/${BIN}"

####
if [ -r /usr/lib/enigma2/python/Plugins/Extensions/Manager ]; then
    echo "Levi45 Manager"
    cp -rf ${TMPDIR}/Manager/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif [ -r /usr/lib/enigma2/python/Plugins/Extensions/tvManager ]; then
    echo "TV Manager"
    cp -rf ${TMPDIR}/Manager/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif [ -r /usr/lib/enigma2/python/Plugins/Extensions/nssManager ]; then
    echo "NSS Manager"
    cp -rf ${TMPDIR}/Manager/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1          



elif grep -qs -i "OpenNFR" /etc/image-version; then
    echo "OpenNFR image"
    OPLI=true
    cp -rf ${TMPDIR}/openpli/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif grep -qs -i "openATV" /etc/image-version; then
    echo "openATV image"
    OPLI=true
    cp -rf ${TMPDIR}/openpli/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif [ -r /usr/lib/enigma2/python/OPENDROID ]; then
    echo "OpenDroid image"
    OPLI=true
    cp -rf ${TMPDIR}/openpli/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif [ -r /usr/lib/enigma2/python/Plugins/Satdreamgr ]; then
    echo "SatdreamGr image"
    OPLI=true
    cp -rf ${TMPDIR}/openpli/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif grep -qs -i "openpli" /etc/issue; then
    echo "OpenPLI image"
    OPLI=true
    cp -rf ${TMPDIR}/openpli/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif grep -qs -i "openvision" /etc/issue; then
    echo "OpenVision image"
    OPLI=true
    cp -rf ${TMPDIR}/openpli/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif grep -qs -i "cobralibero" /etc/issue; then
    echo "CobraLibero image"
    OPLI=true
    cp -rf ${TMPDIR}/openpli/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif [ -r /usr/lib/enigma2/python/Plugins/SystemPlugins/ViX ]; then
    echo "OpenVIX image"
    OPLI=true
    cp -rf ${TMPDIR}/openpli/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/softcams/ >/dev/null 2>&1
elif grep -qs -i "OpenViX" /etc/image-version ; then
    echo "OpenVIX image"
    OPLI=true
    cp -rf ${TMPDIR}/openpli/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/softcams/ >/dev/null 2>&1        
elif [ -r /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox ]; then
    echo "OpenHDF image"
    OPLI=true
    cp -rf ${TMPDIR}/openpli/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif grep -qs -i "teamBlue" /etc/image-version; then
    echo "TeamBlue image"
    OPLI=true
    cp -rf ${TMPDIR}/openpli/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif grep -qs -i "OpenEight" /etc/image-version; then
    echo "OpenEight image"
    OPLI=true
    cp -rf ${TMPDIR}/openpli/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif grep -qs -i "openfix" /etc/issue; then
    echo "OpenFIX image"
    OPLI=true
    cp -rf ${TMPDIR}/openpli/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif grep -qs -i "opentr" /etc/issue; then
    echo "OpenTR image"
    OPLI=true
    cp -rf ${TMPDIR}/openpli/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif grep -qs -i "areadeltasat" /etc/issue.net; then
    echo "AreadeLtasat image"
    OPLI=true
    cp -rf ${TMPDIR}/openpli/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1





elif [ -r /usr/lib/enigma2/python/Blackhole ]; then
    echo "Blackhole image"
    cp -rf ${TMPDIR}/BH/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif [ -f /usr/lib/enigma2/python/Screens/BpBlue.pyc ]; then
    echo "OpenBlackhole image"
    cp -rf ${TMPDIR}/BH/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1


elif grep -qs -i "OpenSPA" /etc/image-version; then
    echo "OpenSPA image"
    cp -rf ${TMPDIR}/dddemon/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1

elif [ -r /usr/lib/enigma2/python/EGAMI ]; then
    echo "Egami image"
    if [ ! -d /var/bin ]; then
        ln -sfn /usr/bin /var/bin
    fi
    cp -rf ${TMPDIR}/egami/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1

elif [ -r /usr/lib/enigma2/python/Plugins/Extensions/PowerboardCenter ]; then
    echo "PBnigma-VIX image"
    cp -rf ${TMPDIR}/Pure2/* / >/dev/null 2>&1
    if [ ! -r /usr/bin/cam ]; then
        mkdir -p /usr/bin/cam >/dev/null 2>&1
    fi
    cp -rf ${TMPDIR}/${BIN} /usr/bin/cam/ >/dev/null 2>&1
elif grep -qs -i "PURE2" /etc/image-version; then
    echo "PURE2 image"
    cp -rf ${TMPDIR}/Pure2/* / >/dev/null 2>&1
    if [ ! -r /usr/bin/cam ]; then
        mkdir -p /usr/bin/cam >/dev/null 2>&1
    fi
    cp -rf ${TMPDIR}/${BIN} /usr/bin/cam/ >/dev/null 2>&1

elif [ -r /usr/lib/enigma2/python/Plugins/Extensions/PKT ]; then
    echo "PKT image"
    if [ ! -r /var/emu ]; then
        mkdir -p /var/emu >/dev/null 2>&1
    fi
    cp -rf ${TMPDIR}/${BIN} /var/emu/ >/dev/null 2>&1



elif [ -r /usr/lib/enigma2/python/Plugins/Extensions/LDteam ]; then
    echo "OpenLD image"
    cp -rf ${TMPDIR}/BH/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif [ -r /usr/lib/enigma2/python/Plugins/Extensions/ExtraAddonss ]; then
    echo "OpenESI image"
    cp -rf ${TMPDIR}/OpenPlus/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1



elif [ -r /usr/lib/enigma2/python/Plugins/Extensions/NssPanel ]; then
    echo "NonSoloSat image"
    cp -rf ${TMPDIR}/Pure2/* / >/dev/null 2>&1
    if [ ! -r /usr/bin/cam ]; then
        mkdir -p /usr/bin/cam >/dev/null 2>&1
    fi
    cp -rf ${TMPDIR}/${BIN} /usr/bin/cam/ >/dev/null 2>&1





elif grep -qs -i "openMips" /etc/image-version; then
    echo "OpenMips image"
    cp -rf ${TMPDIR}/Pure2/* / >/dev/null 2>&1
    if [ ! -r /usr/bin/cam ]; then
        mkdir -p /usr/bin/cam >/dev/null 2>&1
    fi
    cp -rf ${TMPDIR}/${BIN} /usr/bin/cam/ >/dev/null 2>&1
elif grep -qs -i "OpenPlus" /etc/image-version; then
    echo "OpenPlus image"
    cp -rf ${TMPDIR}/OpenPlus/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif grep -qs -i "titannit" /etc/image-version; then
    echo " OpenAFF-Titan image"
    cp -rf ${TMPDIR}/OpenPlus/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif [ -r /usr/lib/enigma2/python/Plugins/TSimage ]; then
    echo "OpenTS/Ts image"
    cp -rf ${TMPDIR}/Pure2/* / >/dev/null 2>&1
    if [ ! -r /usr/bin/cam ]; then
        mkdir -p /usr/bin/cam >/dev/null 2>&1
    fi
    cp -rf ${TMPDIR}/${BIN} /usr/bin/cam/ >/dev/null 2>&1
elif grep -qs -i "Merlin" /etc/image-version ; then
    echo "Merlin4 OE2.5 image"
    cp -rf ${TMPDIR}/Merlin4/* / >/dev/null 2>&1
    if [ ! -r /usr/bin/cam ]; then
        mkdir -p /usr/bin/cam >/dev/null 2>&1
    fi
    cp -rf ${TMPDIR}/${BIN} /usr/bin/cam/ >/dev/null 2>&1
elif grep -qs -i "merlinfeed.boxpirates.to" cat /etc/apt/sources.list ; then
    echo "Merlin4 OE2.5 image"
    cp -rf ${TMPDIR}/Merlin4/* / >/dev/null 2>&1
    if [ ! -r /usr/bin/cam ]; then
        mkdir -p /usr/bin/cam >/dev/null 2>&1
    fi
    cp -rf ${TMPDIR}/${BIN} /usr/bin/cam/ >/dev/null 2>&1    
elif [ -r /usr/lib/enigma2/python/Plugins/Extensions/AddOnManager ]; then
    echo "Merlin3 image"
    cp -rf ${TMPDIR}/Merlin3/* / >/dev/null 2>&1
    if [ ! -r /usr/bin/cam ]; then
        mkdir -p /usr/bin/cam >/dev/null 2>&1
    fi
    cp -rf ${TMPDIR}/${BIN} /usr/bin/cam/ >/dev/null 2>&1
elif [ -r /usr/lib/enigma2/python/Plugins/Extensions/Blue_Panel ]; then
    echo "Demonisat image"
    cp -rf ${TMPDIR}/demonisat/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif [ -r /usr/lib/enigma2/python/Plugins/DreamElite/ElitePanel ]; then
    echo "Dream-Elite OE2.5 image"
    if [ ! -d /var/bin ]; then
        ln -sfn /usr/bin /var/bin
    fi
    cp -rf ${TMPDIR}/dreamelite2/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
    if [ ! -r /usr/lib/enigma2/python/Plugins/DreamElite/EliteSoftcamManager ]; then
        TMP=`mktemp -d`;
        cd ${TMP} > /dev/null 2>&1;
        rm -rf /var/run/apt/archives/* > /dev/null 2>&1;
        if [ -n "$(uname -m | grep aarch64)" ]; then
            wget -q "http://de-extra.co/ElitePanel/pyro/aarch64/dream-elite-extra_arm64.deb" > /dev/null 2>&1;
            echo "y" | dpkg --install --force-depends --force-overwrite dream-elite-extra_arm64.deb > /dev/null 2>&1;
            wget -q "http://de-extra.co/ElitePanel/pyro/aarch64/dream-elite-elitesoftcam_arm64.deb" > /dev/null 2>&1;
            echo "y" | dpkg --install --force-depends --force-overwrite dream-elite-elitesoftcam_arm64.deb > /dev/null 2>&1;
            apt-get -f --force-yes --assume-yes install > /dev/null 2>&1;
        elif [ -n "$(uname -m | grep armv7l)" ]; then
            wget -q "http://de-extra.co/ElitePanel/krogoth/armhf/dream-elite-extra_armhf.deb" > /dev/null 2>&1;
            echo "y" | dpkg --install --force-depends --force-overwrite dream-elite-extra_armhf.deb > /dev/null 2>&1;
            wget -q "http://de-extra.co/ElitePanel/krogoth/armhf/dream-elite-elitesoftcam_armhf.deb" > /dev/null 2>&1;
            echo "y" | dpkg --install --force-depends --force-overwrite dream-elite-elitesoftcam_armhf.deb > /dev/null 2>&1;
            apt-get -f --force-yes --assume-yes install > /dev/null 2>&1;
        elif [ -n "$(uname -m | grep mips)" ]; then
            wget -q "http://de-extra.co/ElitePanel/krogoth/mipsel/dream-elite-extra_mipsel.deb" > /dev/null 2>&1;
            echo "y" | dpkg --install --force-depends --force-overwrite dream-elite-extra_mipsel.deb > /dev/null 2>&1;
            wget -q "http://de-extra.co/ElitePanel/krogoth/mipsel/dream-elite-elitesoftcam_mipsel.deb" > /dev/null 2>&1;
            echo "y" | dpkg --install --force-depends --force-overwrite dream-elite-elitesoftcam_mipsel.deb > /dev/null 2>&1;
            apt-get -f --force-yes --assume-yes install > /dev/null 2>&1;
        fi
        rm -rf ${TMP} > /dev/null 2>&1;
        cd ~;
    fi
elif grep -qs -i "deb http://feed.dream-elite.net" cat /etc/apt/sources.list.d/all-feed.list ; then
    echo "Dream-Elite OE2.5 image"
    if [ ! -d /var/bin ]; then
        ln -sfn /usr/bin /var/bin
    fi
    cp -rf ${TMPDIR}/dreamelite2/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
    touch /etc/DExtra
elif [ -r /usr/lib/enigma2/python/DE ]; then
    echo "Dream-Elite image"
    if [ ! -d /var/bin ]; then
        ln -sfn /usr/bin /var/bin
    fi
    cp -rf ${TMPDIR}/dreamelite/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif [ -e /etc/apt/sources.list.d/gp4-unstable-all-feed.list ]; then
    echo "GP4 image"
    cp -rf ${TMPDIR}/GP4/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif [ -e /usr/lib/enigma2/python/Plugins/Bp/geminimain ]; then
    echo "GP3 image"
    cp -rf ${TMPDIR}/GP3/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif [ -e /usr/lib/enigma2/python/Plugins/Bp/geminimain ]; then
    echo "GP3 image"
    cp -rf ${TMPDIR}/dddemon/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1


elif grep -qs -i "OoZooN" /etc/image-version; then
    echo "OoZooN image"
    cp -rf ${TMPDIR}/oozoon/* / >/dev/null 2>&1
    if [ ! -r /usr/bin/camd ]; then
        mkdir -p /usr/bin/camd >/dev/null 2>&1
    fi
    cp -rf ${TMPDIR}/${BIN} /usr/camd/ >/dev/null 2>&1    
elif grep -qs -i "newnigma2" /etc/image-version; then
    echo "newnigma2 image"
    cp -rf ${TMPDIR}/newnigma2/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif grep -qs -i "Peter" /etc/issue.net; then
    echo "PeterPan image"
    cp -rf ${TMPDIR}/PeterPan/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif grep -qs -i "Power-Sat" /etc/issue.net; then
    echo "PowerSat image"
    cp -rf ${TMPDIR}/PowerSat/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1                             
elif [ -r /usr/lib/enigma2/python/Plugins/SystemPlugins/DemonisatManager ]; then
    echo "DDD-Demoni image"
    cp -rf ${TMPDIR}/dddemon/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1
elif [ -r /usr/lib/enigma2/python/Plugins/Domica ]; then
    echo "Domica image"
    cp -rf ${TMPDIR}/domica/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1

elif grep -qs -i "SatLodge" /etc/issue.net; then
    echo "SatLodge image"
    cp -rf ${TMPDIR}/SatLodge/* / >/dev/null 2>&1
    cp -rf ${TMPDIR}/${BIN} /usr/bin/ >/dev/null 2>&1






else
    rm -r ${TMPDIR} >/dev/null 2>&1
    echo "No emu script to this image for now .. ask @ https://satellite-forum.com"
    rm -rf /tmp/enigma2-plugin-softcams-oscam*.ipk
    exit 1
fi

#### Checking Config Files ####
if [ ! -d ${CONFIGPATH} ]; then
    mkdir -p ${CONFIGPATH} >/dev/null 2>&1
fi

echo ${FIN}
echo ":I'm checking your config OSCam ..."
for file in ${BIN_FILES}.conf ${BIN_FILES}.dvbapi ${BIN_FILES}.provid ${BIN_FILES}.server ${BIN_FILES}.services ${BIN_FILES}.user CCcam.cfg; do
    if [ ! -f "${CONFIGPATH}/${file}" ]; then
        cp -f "${TMPDIR}${CONFIGPATH}/${file}" $CONFIGPATH >/dev/null 2>&1
        echo "  send: ${file} ... file"
    fi
done
echo ${FIN}

#### Checking OpenPLI Softcam Symlink ####
if [ -f /etc/init.d/softcam.None ]; then
    if type update-rc.d 2>/dev/null; then
        if [ -n "${D}" ]; then
            OPT="-r ${D}"
        else
            OPT="-s"
        fi
        update-rc.d "${OPT}" softcam defaults 50 >/dev/null 2>&1
    fi
fi
