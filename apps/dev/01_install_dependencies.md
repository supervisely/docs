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
python3.8 -m pip install --user --upgrade pip
sudo conda clean --all --yes
rm -rf ~/temp/miniconda.sh
```

## Install other packages and libraries ??


brew install -y libgeos-dev=3.5.0-1ubuntu2 
libsm6=2:1.2.2-1 \
libxext6=2:1.3.3-1 \
libxrender-dev=1:0.9.9-0ubuntu1
apt-get install -y libjpeg-dev libpng-dev


- fork project
- clone it to computer and go to the root project folder

https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/#creating-a-virtual-environment
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
deactivate

/usr/local/bin/python


----
I took original python:3.6 dockeimage and started a container from it
docker run --rm -it python:3.6 bash
2. install SLY
python -m pip install git+https://github.com/supervisely/supervisely.git
3. Install Dependencies
apt-get update
apt-get install libgl1-mesa-glx
apt-get install -y --no-install-recommends         libgeos-dev=3.5.0-1ubuntu2 \ libsm6=2:1.2.2-1 \
libxext6=2:1.3.3-1 \
libxrender-dev=1:0.9.9-0ubuntu1
apt-get install -y libjpeg-dev libpng-dev
pip install opencv-python==3.4.11.43
4. Run python
python
5. Tried to import supervisely
import supervisely_lib as sly
And it works
