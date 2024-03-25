#!/bin/sh

green ()
{
  GREEN="\033[0;32m";
  NC="\033[0m";
  echo "$GREEN$1$NC";
}

setupFs()
{
  _domain="fs."$1;
  _key=$2;
  _dirname=$3;
  _projectDirectory=$4;

  cd $_dirname;
  git clone https://github.com/aircms/fs.git;
  cd fs;
  export COMPOSER_ALLOW_SUPERUSER=1;
  composer update;
  composer run-script assets;
  composer run-script storage;
  cd $_projectDirectory;
}

updateStorageConfig()
{
  _fsDomain=$1;
  _fsKey=$2;
  _configFile=$(realpath $(dirname $(dirname $0)))/config/live.php;

  sed -i "s~{fsDomain}~$_fsDomain~g" $_configFile;
  sed -i "s~{fsKey}~$_fsKey~g" $_configFile;
}

genVhost ()
{
  _domain=$1;
  _directory=$2;
  _email=$3;
  _environment=$4;
  _key=$5;
  _maxPostSize=$6

  vhost=$(cat "$(realpath $(dirname $0))/vhosts/default");
  vhost=$(echo "$vhost" | sed "s/{domain}/${_domain}/");
  echo "$vhost" > /etc/apache2/sites-enabled/$_domain.conf;

  sudo certbot certonly -d $_domain -m "$_email" --agree-tos --apache -n;

  vhost=$(cat "$(realpath $(dirname $0))/vhosts/ssl");
  vhost=$(echo "$vhost" | sed "s/{domain}/${_domain}/");
  vhost=$(echo "$vhost" | sed "s~{directory}~${_directory}~");
  vhost=$(echo "$vhost" | sed "s/{key}/${_key}/");
  vhost=$(echo "$vhost" | sed "s/{environment}/${_environment}/");
  vhost=$(echo "$vhost" | sed "s/{maxPostSize}/${_maxPostSize}/");

  unlink /etc/apache2/sites-enabled/$_domain.conf;
  echo "$vhost" > /etc/apache2/sites-enabled/$_domain.conf;
}

genDefaultVhost ()
{
  _domain=$1;

  vhost=$(cat "$(realpath $(dirname $0))/vhosts/other");
  vhost=$(echo "$vhost" | sed "s/{domain}/${_domain}/");

  echo "$vhost" > /etc/apache2/sites-enabled/000-default.conf;
}