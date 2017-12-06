# .dotfiles

![Awesome WM](https://i.imgur.com/GbWSzfw.png)
![Awesome WM](https://i.imgur.com/KaFqLkO.png)

## Setup repository

```bash
git init --bare $HOME/.dotfiles
echo 'alias dotfiles="/usr/bin/env git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"' >> $HOME/.zshrc
source $HOME/.zshrc
echo ".dotfiles" >> $HOME/.gitignore
dotfiles add $HOME/.gitignore
dotfiles commit -m "Git: Add gitignore"
dotfiles remote add origin https://github.com/alfunx/.dotfiles
dotfiles push --set-upstream origin master
dotfiles config --local status.showUntrackedFiles no
```

## Track files

```bash
dotfiles status
dotfiles add .zshrc
dotfiles commit -m "Zsh: Add zshrc"
dotfiles add .vimrc
dotfiles commit -m "Vim: Add vimrc"
dotfiles push
```

## Restore configurations

```bash
git clone --bare --recursive https://github.com/alfunx/.dotfiles $HOME/.dotfiles
function dotfiles() {
  /usr/bin/env git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME
}
dotfiles checkout
if [ $? -ne 0 ]; then
  mkdir -p $HOME/.dotfiles-backup
  dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $HOME/.dotfiles-backup/{}
  dotfiles checkout
fi
dotfiles config --local status.showUntrackedFiles no
```

## Additional commands

In `.bashrc` or `.zshrc`, instead of the previous alias:

```bash
dotfiles() {
  case $1 in
    listall)
      shift
      dotfiles ls-tree --full-tree -r --name-only HEAD $@
      ;;
    listtree)
      shift
      if hash treeify 2>/dev/null; then
        dotfiles ls-tree --full-tree -r --name-only HEAD $@ | treeify
      else
        dotfiles listall
      fi
      ;;
    *)
      /usr/bin/env git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
      ;;
  esac
}
compdef dotfiles='git'
```
