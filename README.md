These are my dotfiles.

To get started:

```bash
cd ~
git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
. .homesick/repos/homeshick/homeshick.sh
yes | homeshick clone joshkel/dotfiles
bin/homeshick-clone-all.sh
homeshick pull

homeshick cd dotfiles
git remote set-url --push origin git@github.com:joshkel/dotfiles.git
cd ~

. .bashrc
```
