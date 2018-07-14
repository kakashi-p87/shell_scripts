file_dbeaver="dbeaver-ce_5.0.0_amd64.deb";
version="5.0.0";
prefix="dbeaver-ce_";
arch="_amd64.deb"

echo "Please provide a valid version";
read version;

file_dbeaver=$prefix$version$arch;

wget https://dbeaver.jkiss.org/files/$version/$file_dbeaver;

sudo dpkg -i $file_dbeaver;

