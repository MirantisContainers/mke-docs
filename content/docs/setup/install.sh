#!/bin/sh
set -e

if [ -n "${DEBUG}" ]; then
  set -x
fi

_detect_uname() {
  os="$(uname)"
  case "$os" in
    Linux) echo "linux" ;;
    Darwin) echo "darwin" ;;
    *) echo "Unsupported operating system: $os" 1>&2; return 1 ;;
  esac
  unset os
}

_detect_arch() {
  arch="$(uname -m)"
  case "$arch" in
    amd64|x86_64) echo "x64" ;;
    arm64|aarch64) echo "arm64" ;;
    armv7l|armv8l|arm) echo "arm" ;;
    *) echo "Unsupported processor architecture: $arch" 1>&2; return 1 ;;
  esac
  unset arch
}

_download_wget_command() {
  if [ "$uname" = "linux" ];
  then
      ID="$(grep -oP '(?<=^ID=).+' /etc/os-release | tr -d '"')"
      case "$ID" in
        ubuntu) installed="$(/usr/bin/dpkg-query --show --showformat='${db:Status-Status}\n' 'wget')"
                if [ "$installed" = "installed" ]; then
                        echo "wget is already installed."
                else
                        sudo apt-get install wget
                fi
                unset installed ;;
        rhel|centos) installed="$(yum info wget | grep Repo | awk '{ print $3 }')"
                     if [ "$installed" = "installed" ]; then
                       echo "wget cmd is already installed."
                     else
                       sudo yum -y install wget
                       #sudo yum install s3cmd
                     fi
                     unset installed ;;
        *) echo "Unsupported processor architecture: $ID" 1>&2; return 1 ;;
      esac
      unset ID
  else
      if ! [ -x "$(command -v wget)" ]; then
        brew install wget
      else
        echo "wget cmd is already installed."
      fi
  fi
}

_download_k0sctl_url() {
  echo "https://github.com/k0sproject/k0sctl/releases/download/v$K0SCTL_VERSION/k0sctl-$uname-$arch"
}

_download_mkectl() {
  if [ "$arch" = "x64" ];
  then
    arch=x86_64
  fi
  wget -q https://s3.us-east-2.amazonaws.com/packages-stage-mirantis.com/${MKECTL_VERSION}/mkectl_${uname}_${arch}.tar.gz
  tar -xvzf mkectl_${uname}_${arch}.tar.gz -C /usr/local/bin
  echo "mkectl is now executable in $installPath"
}

main() {

  echo "Download wget"
  _download_wget_command

  printf "\n\n"

  echo "Step 1/2 : Install k0sctl"
  echo "#########################"

  if [ -z "${K0SCTL_VERSION}" ]; then
    echo "Using default k0sctl version 0.17.8"
    K0SCTL_VERSION=0.17.8
  fi

  k0sctlBinary=k0sctl
  installPath=/usr/local/bin
  uname="$(_detect_uname)"
  arch="$(_detect_arch)"
  k0sctlDownloadUrl="$(_download_k0sctl_url)"



  echo "Downloading k0sctl from URL: $k0sctlDownloadUrl"
  wget -q -cO - $k0sctlDownloadUrl > $installPath/$k0sctlBinary

  sudo chmod 755 "$installPath/$k0sctlBinary"
  echo "k0sctl is now executable in $installPath"

  printf "\n\n"
  echo "Step 2/2 : Install mkectl"
  echo "#########################"

  if [ -z "${MKECTL_VERSION}" ]; then
    echo "Using default mkectl version v4.0.0-alpha.0.3"
    MKECTL_VERSION=v4.0.0-alpha.0.3
  fi
  printf "\n"


  echo "Downloading mkectl"
  _download_mkectl

}

main "$@"