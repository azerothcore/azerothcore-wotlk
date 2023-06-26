git clone -b 'v3.1.4' --recurse-submodules --single-branch --depth 1 https://github.com/wxWidgets/wxWidgets.git wxWidgets-v3.1.4
cd wxWidgets-v3.1.4
./configure
make -j$(nproc) 
sudo make install
