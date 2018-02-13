These are my dotfiles.

To get started:

```bash
cat <<EOF | bash
set -e
cd ~
git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
. .homesick/repos/homeshick/homeshick.sh
yes | homeshick clone joshkel/dotfiles
bin/homeshick-clone-all.sh
homeshick pull
homeshick cd dotfiles
git remote set-url --push origin git@github.com:joshkel/dotfiles.git
cd ~
EOF

# If all of the above worked:
. .bashrc
vim +PluginInstall +qall
```
