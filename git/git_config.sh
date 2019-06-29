echo "###################################################";
echo "################ Git configuration ################";
echo "###################################################";

sudo apt-get -y  -f install git;

echo "please provide your e-mail";
read email_git;
echo "please provide your git's user name";
read user_git;

git config --global user.email $email_git;
git config --global user.name  $user_git;

repo_dir="/home/$USER/Repositories";

mkdir $repo_dir;
chown -R $USER:$USER $repo_dir;

git config --global alias.lg "log --pretty='%Cred%h%Creset |%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset %C(cyan)[%an]%Creset' --graph"

echo "###################################################";
echo "################## Git configured #################";
echo `git config --list`;
echo "###################################################";
