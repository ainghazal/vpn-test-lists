#!/bin/sh
#
# Builds miniooni and checks common VPN APIs.
# Dependencies: git, golang-go, wget
#
DIR=/tmp/ooni-vpn-run
MINIOONI_LINUX=miniooni-linux-amd64
MINIOONI_RELEASE=https://github.com/ooni/probe-cli/releases/download/v3.16.7/${MINIOONI_LINUX}
OONIRUN_APIS=https://raw.githubusercontent.com/ainghazal/vpn-test-lists/main/check-apis.sh
OONIRUN_APIS_TOR=https://raw.githubusercontent.com/ainghazal/vpn-test-lists/main/check-apis-tor.sh
OONIRUN_HOURLY=https://raw.githubusercontent.com/ainghazal/vpn-test-lists/main/hourly/000-vpn-providers.json
PROBE_CLI=https://github.com/ooni/probe-cli

mkdir -p ${DIR} && cd ${DIR}

echo "Cloning probe-cli from Github"
git clone ${PROBE_CLI}
cd probe-cli
echo "Compiling miniooni"
CGO_ENABLED=0 go build -o ../miniooni ./internal/cmd/miniooni
cd ../

mkdir -p hourly
wget ${OONIRUN_HOURLY} -O hourly/000-vpn-providers.json
wget ${OONIRUN_APIS} && chmod +x check-apis.sh
wget ${OONIRUN_APIS_TOR} && chmod +x check-apis-tor.sh

echo "Done. You can run with:"
echo
echo "cd" $DIR " && ./check-apis.sh"
echo "And it will do one test each hour until interrupted."

