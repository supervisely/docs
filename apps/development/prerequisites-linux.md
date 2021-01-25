# Prerequisites for Linux

Make sure you have installed all of the following prerequisites on your development machine:

1. Update package manager
```
sudo apt-get update
```

2. Install `git` and other utilities. They will be needed later.
```
sudo apt-get install -y git curl
```

3. Install [Miniconda](https://docs.conda.io/en/latest/miniconda.html) and `python 3.8`
```
mkdir -p ~/temp
curl -sSL https://repo.anaconda.com/miniconda/Miniconda3-py38_4.8.3-Linux-x86_64.sh -o ~/temp/miniconda.sh
sudo bash ~/temp/miniconda.sh -bfp /usr/local
conda install -y python=3.8
conda clean --all --yes
rm -rf ~/temp/miniconda.sh
```

4. Install your favorite python IDE. We prefer and use [Pycharm](https://www.jetbrains.com/pycharm/download/#section=linux). The further steps will be shown using Pycharm CE (Community Edition).
