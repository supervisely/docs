# Prerequisites for MacOS

Make sure you have installed all of the following prerequisites on your development machine:

1. Install package manager [Homebrew](https://brew.sh/) 

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew update
```

2. Install `git`, `md5sum` and other utilities. They will be needed later.

```sh
brew install git
brew install md5sha1sum
```

3. Install [Miniconda](https://docs.conda.io/en/latest/miniconda.html) and `python 3.8`

```sh
mkdir -p ~/temp
wget https://repo.anaconda.com/miniconda/Miniconda3-py38_4.8.3-MacOSX-x86_64.sh -O ~/temp/miniconda.sh
sudo bash ~/temp/miniconda.sh -bfp /usr/local
sudo conda install -y python=3.8
sudo conda clean --all --yes
rm -rf ~/temp/miniconda.sh
```

4. Install your favorite python IDE. We prefer and use [Pycharm](https://www.jetbrains.com/pycharm/download/#section=mac). The further steps will be shown using Pycharm CE (Community Edition).

