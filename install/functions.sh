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

genVhost ()
{
  _domain=$1;
  _directory=$2;
  _email=$3;
  _environment=$4;
  _fsKey=$5;
  _fsDomain=$6;
  _rootPassword=$7;
  _tiny=$8;
  _dbName=$9;

  vhost=$(cat "$(realpath $(dirname $0))/vhosts/default");
  vhost=$(echo "$vhost" | sed "s/{domain}/${_domain}/");
  echo "$vhost" > /etc/apache2/sites-enabled/$_domain.conf;

  if [ ! -f "/etc/letsencrypt/live/$_domain/fullchain.pem" ]; then
    sudo certbot certonly -d "$_domain" -m "$_email" --agree-tos --apache -n;
  fi;

  vhost=$(cat "$(realpath $(dirname $0))/vhosts/ssl-site");
  vhost=$(echo "$vhost" | sed "s/{domain}/${_domain}/");
  vhost=$(echo "$vhost" | sed "s~{directory}~${_directory}~");
  vhost=$(echo "$vhost" | sed "s/{fsDomain}/${_fsDomain}/");
  vhost=$(echo "$vhost" | sed "s/{fsKey}/${_fsKey}/");
  vhost=$(echo "$vhost" | sed "s/{rootPassword}/${_rootPassword}/");
  vhost=$(echo "$vhost" | sed "s/{tiny}/${_tiny}/");
  vhost=$(echo "$vhost" | sed "s/{dbName}/${_dbName}/");
  vhost=$(echo "$vhost" | sed "s/{environment}/${_environment}/");

  unlink /etc/apache2/sites-enabled/$_domain.conf;
  echo "$vhost" > /etc/apache2/sites-enabled/$_domain.conf;
}

genFSVhost ()
{
  _domain="fs.$1";
  _directory=$2;
  _email=$3;
  _environment=$4;
  _fsKey=$5;

  vhost=$(cat "$(realpath $(dirname $0))/vhosts/default");
  vhost=$(echo "$vhost" | sed "s/{domain}/${_domain}/");
  echo "$vhost" > /etc/apache2/sites-enabled/$_domain.conf;

  if [ ! -f "/etc/letsencrypt/live/$_domain/fullchain.pem" ]; then
    sudo certbot certonly -d "$_domain" -m "$_email" --agree-tos --apache -n;
  fi;

  vhost=$(cat "$(realpath $(dirname $0))/vhosts/ssl-fs");
  vhost=$(echo "$vhost" | sed "s/{domain}/${_domain}/");
  vhost=$(echo "$vhost" | sed "s~{directory}~${_directory}~");
  vhost=$(echo "$vhost" | sed "s/{fsKey}/${_fsKey}/");
  vhost=$(echo "$vhost" | sed "s/{environment}/${_environment}/");

  unlink /etc/apache2/sites-enabled/$_domain.conf;
  echo "$vhost" > /etc/apache2/sites-enabled/$_domain.conf;
}

genDefaultVhost ()
{
  _domain=$1;
  _default="/etc/apache2/sites-enabled/000-$_domain.conf";

  if [ ! -f _default ]; then
    vhost=$(cat "$(realpath $(dirname $0))/vhosts/other");
    vhost=$(echo "$vhost" | sed "s/{domain}/${_domain}/");

    echo "$vhost" > $_default;
  fi;
}
