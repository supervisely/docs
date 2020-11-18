# Install Dependencies on your computer

## Install Package Manager

On Linux

```
# update
sudo apt-get update
```

### On MacOS

install package manager if it is not installed yet
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

update it
```
brew update
```

## Install Miniconda

On Linux
```
sudo apt-get install md5sum
```

On MacOS
```
brew install md5sha1sum wget
mkdir -p ~/temp
wget https://repo.anaconda.com/miniconda/Miniconda3-py38_4.8.3-MacOSX-x86_64.sh -O ~/temp/miniconda.sh
sudo bash ~/temp/miniconda.sh -bfp /usr/local
sudo conda install -y python=3.8
sudo conda clean --all --yes
rm -rf ~/temp/miniconda.sh
```

## Install other packages and libraries
