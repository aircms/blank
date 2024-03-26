#!/bin/sh

. "$(dirname $0)/functions.sh";
. "$(dirname $0)/input.sh";

. "$(dirname $0)/core.sh";

projectDirectory=$(dirname $(realpath $(dirname $0)));
rootDirectory=$(dirname $projectDirectory);
fsKey=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13; echo);

genVhost $domain          "$projectDirectory/www" $email $environment $fsKey "fs.$domain" $rootPassword $tiny $dbName;
genVhost "admin.$domain"  "$projectDirectory/www" $email $environment $fsKey "fs.$domain" $rootPassword $tiny $dbName;

setupFs $domain $fsKey $rootDirectory $projectDirectory;
genFSVhost $domain "$rootDirectory/fs/www" $email $environment $fsKey;

genDefaultVhost $domain;
systemctl restart apache2;

if [ "$autoUpdate" = "yes" ];then
  line="0 * * * * cd $projectDirectory && composer update";
  (crontab -u $(whoami) -l; echo "$line" ) | crontab -u $(whoami) -;

  line="0 * * * * cd $rootDirectory/fs && composer update";
  (crontab -u $(whoami) -l; echo "$line" ) | crontab -u $(whoami) -;
fi;

echo "--------------------------------------";
echo $(green "Done, We are good :)");

echo "Open https://admin.${domain}/ in your browser.";
echo "Login:    " $(green "root");
echo "Password: " $(green $rootPassword);
echo "--------------------------------------";
echo $(green "Don't forget about tiny key.");
echo $(green "Happy development :)");
echo "--------------------------------------";
