#!/bin/bash

set -eo pipefail

echo "Updating and installing feeds ..."
cd openwrt
[ "x${UPDATE_FEEDS}" != "x1" ] || ./scripts/feeds update -a
./scripts/feeds install -a

mkdir -p package/feeds || true
cd package/feeds

if [ -d mentohust ]; then
  [ "x${UPDATE_FEEDS}" != "x1" ] || git -C mentohust pull --ff
else
  git clone https://github.com/KyleRicardo/MentoHUST-OpenWrt-ipk.git mentohust
fi

if [ -d luci-app-mentohust ]; then
  [ "x${UPDATE_FEEDS}" != "x1" ] || git -C luci-app-mentohust pull --ff
else
  git clone https://github.com/BoringCat/luci-app-mentohust.git luci-app-mentohust
fi