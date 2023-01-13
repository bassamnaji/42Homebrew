# Setup Homebrew on your Mac with one command

This executable <**42brew**> will clean the Homebrew under your accont NOT the root. Then it will install a new one under **~/Homebrew** and it will create a symbolic link for the **Taps** to your goinfre to not fill your storage no matter how many packages you will install.

It will also add it to the path in ```.zshrc``` and ```.bashrc```, then ```source``` them to be used instead of builtin ```brew```. It does not touch or play with the builtin one. It just installs a seperate one under ```Home``` and setup the terminals to use it instead of the builtin one.

This will setup Homebrew only. you will need to look up for the packages you want to install.
You can check this website to check all the packages you can install => [ https://formulae.brew.sh ]

**NOTE:** Keep in mind that Xcode in our Mac is outdated, so you will find that a good number of packages will not install because of that!!

## Usage

```bash
git clone https://github.com/Basam1881/42Homebrew
```
You can also retrieve the executable as following:
```bash
curl -O https://raw.githubusercontent.com/Basam1881/42Homebrew/main/42brew
wget https://raw.githubusercontent.com/Basam1881/42Homebrew/main/42brew
```

```bash
# Give permission to execute the file
chmod +x 42brew

# run the executable to install homebrew
./42brew install -y
# "-y" is an optional flag you can add to skip questions.

# update the shell to be able to use brew on it
source ~/.zshrc # if you are running zsh
#source ~/.bashrc # if you are running bash
```
If you just want to remove remove Homebrew that is under ```Home``` you can run:
```bash
./42brew clean -y
# "-y" is an optional flag you can add to skip questions.
```
