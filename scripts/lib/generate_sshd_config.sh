#!/usr/bin/env bash

generate_sshd_config() {
    local port=''
    local user=''
    local pid_file=''
    local authorized_keys_file=''
    local rsa_host_key_file=''
    local dsa_host_key_file=''
    local ecdsa_host_key_file=''

    local args=("$@")

    while [[ $# -gt 0 ]]
    do
      key="$1"

      case $key in
        --port)
          port=$2
          shift # past argument
          shift # past value
          ;;
        --user)
          user=$2
          shift # past argument
          shift # past value
          ;;
        --pid-file)
          pid_file=$2
          shift # past argument
          shift # past value
          ;;
        --authorized-keys-file)
          authorized_keys_file=$2
          shift # past argument
          shift # past value
          ;;
        --rsa-host-key-file)
          rsa_host_key_file=$2
          shift # past argument
          shift # past value
          ;;
        --dsa-host-key-file)
          dsa_host_key_file=$2
          shift # past argument
          shift # past value
          ;;
        --ecdsa-host-key-file)
          ecdsa_host_key_file=$2
          shift # past argument
          shift # past value
          ;;
        *)    # unknown option
          shift # past argument
          ;;
      esac
    done
    set -- "${args[@]}" # restore positional parameters
cat <<EOL
Port $port
PidFile $pid_file
UsePrivilegeSeparation no
AuthorizedKeysFile $authorized_keys_file
HostKey $rsa_host_key_file
HostKey $dsa_host_key_file
HostKey $ecdsa_host_key_file
PasswordAuthentication no
UsePAM no
PermitRootLogin no
PermitEmptyPasswords no
RSAAuthentication yes
PubkeyAuthentication yes
X11Forwarding yes
X11UseLocalHost no
LogLevel VERBOSE
AllowUsers $user
EOL
}
