echo "###################################################";
echo "#		             Git configuration        	      #";
echo "###################################################";

apt-get -y  -f install git;

echo "please provide your e-mail";
read email_git;
echo "please provide your git's user name";
read user_git;

git config --global core.autocrlf true
git config --global user.email $email_git;
git config --global user.name  $user_git;

repo_dir="/home/$user_name/Repositories";

mkdir $repo_dir;
chown -R $user_name:$user_name $repo_dir;

mkdir "$repo_dir/shell_scripts";


git clone https://github.com/kakashi-p87/shell_scripts.git "$repo_dir/shell_scripts";



chown -R $user_name:$user_name $repo_dir/*


echo `git config --list`;

echo "===================================================";
echo "#		               git configured                 #";
echo "===================================================";
