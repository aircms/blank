#!/bin/sh

echo "Welcome to Apache Virtual host generator."

echo "Please, Enter main domain name:";
read domain;

echo "Please, Enter environment 'live' or 'dev':";
read environment;

echo "Please, Enter email address (used for urgent renewal and security notices):";
read email;

echo "Would you like to enable core automatic updates? ('yes' or 'no')";
read autoUpdate;

. "$(dirname $0)/functions.sh";

echo "--------------------------------------";
echo "Will be created:";
echo - $(green $domain);
echo - $(green admin.$domain);
echo - $(green "fs.$domain");
echo "--------------------------------------";
echo "Email address: $(green $email)";
echo "--------------------------------------";
echo "Press [ENTER] to confirm or CTRL+C to cancel";
read _confirm;
echo "--------------------------------------";
echo "Great, Lets start!";
echo "--------------------------------------";

. "$(dirname $0)/core.sh";

unlink /etc/apache2/sites-enabled/000-default.conf;

projectDirectory=$(dirname $(realpath $(dirname $0)));
rootDirectory=$(dirname $projectDirectory);
key=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13; echo);

genVhost $domain "$projectDirectory/www" $email $environment $key "2M";
genVhost "admin.$domain" "$projectDirectory/www" $email $environment $key "2M";

setupFs $domain $key $rootDirectory $projectDirectory;
genVhost "fs.$domain" "$rootDirectory/fs/www" $email $environment $key "1000M";
updateStorageConfig "fs.$domain" $key;

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
echo "Password: " $(green "very-secured-password");
echo "--------------------------------------";
echo $(green "Dont forget about tiny key.");
echo $(green "Happy development :)");
echo "--------------------------------------";
