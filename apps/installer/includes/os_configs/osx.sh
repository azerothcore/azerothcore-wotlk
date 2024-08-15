##########################################
## workaround for python upgrade issue https://github.com/actions/runner-images/issues/6817
rm /usr/local/bin/2to3 || true
rm /usr/local/bin/2to3-3.10 || true
rm /usr/local/bin/2to3-3.11 || true
rm /usr/local/bin/2to3-3.12 || true
rm /usr/local/bin/idle3 || true
rm /usr/local/bin/idle3.10 || true
rm /usr/local/bin/idle3.11 || true
rm /usr/local/bin/idle3.12 || true
rm /usr/local/bin/pydoc3 || true
rm /usr/local/bin/pydoc3.10 || true
rm /usr/local/bin/pydoc3.11 || true
rm /usr/local/bin/pydoc3.12 || true
rm /usr/local/bin/python3 || true
rm /usr/local/bin/python3.10 || true
rm /usr/local/bin/python3.11 || true
rm /usr/local/bin/python3.12 || true
rm /usr/local/bin/python3-config || true
rm /usr/local/bin/python3.10-config || true
rm /usr/local/bin/python3.11-config || true
rm /usr/local/bin/python3.12-config || true
##########################################

brew update

##########################################
## workaround for cmake already being installed in the github runners
if ! command -v cmake &>/dev/null ; then
       brew install cmake
fi
##########################################

# DEBUG: speedup feedback loop
# brew install openssl@3 readline boost bash-completion curl unzip mysql ccache
brew install mysql 

# Step 1: Check the Homebrew prefix for MySQL
echo "Checking Homebrew prefix for MySQL..."
brew_prefix=$(brew --prefix mysql)
echo "Homebrew prefix for MySQL: $brew_prefix"

# Step 2: List all versions of MySQL installed in the Homebrew Cellar
echo "Listing all MySQL versions installed in the Cellar..."
ls -la $(brew --cellar mysql)

# Step 3: Check if the specific version directory exists
mysql_version="9.0.1.reinstall"
mysql_cellar_path="$(brew --cellar mysql)/$mysql_version"
echo "Checking if MySQL version $mysql_version directory exists..."
if [ -d "$mysql_cellar_path" ]; then
    echo "Directory $mysql_cellar_path exists."
else
    echo "Directory $mysql_cellar_path does NOT exist. Listing contents of parent directory:"
    ls -la $(brew --cellar mysql)
fi

# Step 4: Verify the installation path using the Homebrew prefix
echo "Verifying the installation path using Homebrew prefix..."
resolved_path="$brew_prefix/Cellar/mysql/$mysql_version"
echo "Resolved MySQL path: $resolved_path"

if [ -d "$resolved_path" ]; then
    echo "Directory $resolved_path exists. Listing contents:"
    ls -la "$resolved_path"
else
    echo "Directory $resolved_path does NOT exist. Listing contents of the parent directory:"
    ls -la "$(brew --prefix mysql)/../Cellar/mysql"
fi

# Step 5: If the directory doesn't exist, list all directories in the Homebrew prefix
echo "Listing all directories in the Homebrew prefix..."
ls -la $brew_prefix

# Step 6: Check Homebrew and MySQL status
echo "Checking Homebrew and MySQL status..."
brew info mysql
