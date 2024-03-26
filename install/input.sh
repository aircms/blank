dbName=$1;
domain=$2;
environment=$3;
email=$4;
rootPassword=$5;
tiny=$6;
autoUpdate=$7;

echo "Welcome to Apache Virtual host generator."

if [ ${#dbName} = 0 ]; then
  echo "Enter db name:";
  read dbName;
fi;

if [ ${#domain} = 0 ]; then
  echo "Enter main domain name:";
  read domain;
fi;

if [ ${#environment} = 0 ]; then
  echo "Enter environment 'live' or 'dev':";
  read environment;
fi;

if [ ${#email} = 0 ]; then
  echo "Enter email address (used by Lets Encrypt for urgent renewal and security notices):";
  read email;
fi;

if [ ${#rootPassword} = 0 ]; then
  echo "Enter super-user password:";
  read rootPassword;
fi;

if [ ${#tiny} = 0 ]; then
  echo "Enter TinyMce key:";
  read tiny;
fi;

if [ ${#autoUpdate} = 0 ]; then
  echo "Would you like to enable core automatic updates? ('yes' or 'no')";
  read autoUpdate;
fi;

echo "-----------------------------------------------------------";
echo "Will be created:";
echo - $(green "$domain");
echo - $(green "fs.$domain");
echo - $(green "admin.$domain");
echo "-----------------------------------------------------------";
echo "Database name:    $(green $dbName)";
echo "-----------------------------------------------------------";
echo "Environment:      $(green $environment)";
echo "-----------------------------------------------------------";
echo "Email address:    $(green $email)";
echo "-----------------------------------------------------------";
echo "Root password:    $(green $rootPassword)";
echo "-----------------------------------------------------------";
echo "TinyMce key:      $(green $tiny)";
echo "-----------------------------------------------------------";
echo "Automatic update: $(green $autoUpdate)";
echo "-----------------------------------------------------------";
echo "Press [ENTER] to confirm or CTRL+C to cancel";
read _confirm;
echo "-----------------------------------------------------------";
echo "Great, Lets start!";
echo "-----------------------------------------------------------";