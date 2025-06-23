#!/bin/bash
set -eu

#set -x

function log {
  echo "$1" 1>&2
}

function usage {
  log "Usage:"
  log "  $0 --decrypt [--private-key <private_key_file_path>] <file_to_decrypt>"
  log "  $0 --encrypt --public-key <path_to_public_key_file> <file_to_encrypt>"
  log "  $0 --encrypt --users <users_to_generate_encryted_files> <file_to_encrypt>"
}

# Defaults
encrypt=false
decrypt=false
private_key="$HOME/.ssh/id_rsa"

# See /usr/share/doc/util-linux/examples/getopt-example.bash for getopt example
TEMP=$(getopt --name "$0" --options "" --longoptions "encrypt,decrypt,public-key:,private-key:,users:" -- "$@")

# Bad arguments, something has gone wrong with the getopt command.
if [ $? -ne 0 ]; then
  log "Bad arguments passed"
  usage
  exit 1
fi

# Note the quotes around `$TEMP': they are essential!
eval set -- "$TEMP"

# Now go through all the options
while true; do
  case "$1" in
    --encrypt)
      encrypt=true
      shift;;

    --decrypt)
      decrypt=true
      shift;;

    --public-key)
      public_key=$2
      shift 2;;

    --private-key)
      private_key=$2
      shift 2;;

    --users)
      users=$2
      shift 2;;

    --)
      shift
      break;;
  esac
done

# Only --encrypt or --decrypt could be passed
if ! $encrypt && ! $decrypt; then
  log "Neither --encrypt nor --decrypt passed"
  usage
  exit 1
fi
if $encrypt && $decrypt; then
  log "Both --encrypt and --decrypt cannot be passed"
  usage
  exit 1
fi

# If encrypt, users is mandatory
if $encrypt && test -z "${public_key:-}" && test -z "${users:-}"; then
  log "While performing encryption, either --public-key or --users should be specified"
  usage
  exit 1
fi

# File to encrypt or decrypt is mandatory
if (( $# == 0 )); then
  log "File to be encrypted or decrypted is mandatory"
  usage
  exit 1
fi

file=$1

if $encrypt; then
  if test -n "${public_key:-}"; then
    encrypted_file_path="/tmp/$(basename $file).enc"
    ssh-keygen -f "$public_key" -e -m "PKCS8" > "/tmp/$(basename $public_key).pem"
    openssl rsautl -encrypt -inkey "/tmp/$(basename $public_key).pem" -pubin -in "$file" -out "$encrypted_file_path"
    rm -f "/tmp/$(basename $public_key).pem"
    log "$encrypted_file_path"
  else
    for user in ${users//,/ }; do
      log "Encrypting $file for $user ... "
      ssh_public_key=$(ldapsearch -b "ou=People,dc=corp,dc=vizury,dc=internal" -H "ldap://vpc-corpldap-master.vizury.com" -D "cn=nss pam ldap,ou=People,dc=corp,dc=vizury,dc=internal" -w "nss@12345" -x "(uid=$user)" -LLL sshPublicKey | sed -e '/^dn:/d' -e 's/sshPublicKey: //' -e '/^$/d' | perl -p00e 's/\r?\n //g')
      if test -z "$ssh_public_key"; then
        log "no ssh public key found in LDAP for $user"
      else
        encrypted_file_path="/tmp/${user}_$(basename $file).enc"
        echo "$ssh_public_key" > "/tmp/${user}.pub"
        ssh-keygen -f "/tmp/${user}.pub" -e -m "PKCS8" > "/tmp/${user}.pub.pem"
        openssl rsautl -encrypt -inkey "/tmp/${user}.pub.pem" -pubin -in "$file" -out "$encrypted_file_path"
        rm -f "/tmp/${user}.pub" "/tmp/${user}.pub.pem"
        log "$encrypted_file_path"
      fi
    done
  fi
fi

if $decrypt; then
  openssl rsautl -decrypt -inkey "$private_key" -in "$file"
fi
 
