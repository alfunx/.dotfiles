# .dotfiles

![Awesome WM](https://i.imgur.com/yz06QFN.png)

## Setup repository

Setup a bare git repository in your home directory. Bare repositories have no
working directory, so setup an alias to avoid typing the long command. Add the
git directory `~/.dotfiles/` to the gitignore as a security measure. Setup
remote and push. Hide untracked files when querying the status.

```bash
git init --bare "$HOME"/.dotfiles
echo 'alias dotfiles="/usr/bin/env git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"' \
  >> "$HOME"/.zshrc
source "$HOME"/.zshrc
echo '.dotfiles' >> "$HOME"/.gitignore
dotfiles add "$HOME"/.gitignore
dotfiles commit -m 'Git: Add gitignore'
dotfiles remote add origin https://github.com/alfunx/.dotfiles
dotfiles push --set-upstream origin master
dotfiles config --local status.showUntrackedFiles no
```

## Track files

Use the default git subcommands to track, update and remove files.

```bash
dotfiles status
dotfiles add .zshrc
dotfiles commit -m 'Zsh: Add zshrc'
dotfiles add .vimrc
dotfiles commit -m 'Vim: Add vimrc'
dotfiles push
```

To remove a file from the repository while keeping it locally you may use:

```bash
dotfiles rm --cached ~/.some_file
```

## Restore configurations

First clone dependent repositories, in this case for example `oh-my-zsh`. Clone
your dotfiles repository as bare repository. Setup temporary alias and then
checkout. If there exist files that collide with your repository (like a default
`.bashrc`), the files will be moved to `~/.dotfiles.bak/`. Then update all
submodules and again hide untracked files when querying the status.

```bash
git clone https://github.com/robbyrussell/oh-my-zsh \
  "$HOME"/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  "$HOME"/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone --bare --recursive https://github.com/alfunx/.dotfiles \
  "$HOME"/.dotfiles
function dotfiles() {
  /usr/bin/env git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME" "$@"
}
dotfiles checkout
if [ "$?" -ne 0 ]; then
  mkdir -p "$HOME"/.dotfiles.bak
  dotfiles checkout 2>&1 \
    | egrep '\s+\.' \
    | awk {'print $1'} \
    | xargs -I{} mv {} "$HOME"/.dotfiles.bak/{}
  dotfiles checkout
fi
dotfiles submodule update --recursive --remote
dotfiles config --local status.showUntrackedFiles no
```

## Additional commands

Instead of the alias provided above, you can use following function. `listall`
will show all tracked files, `listtree` will show those files in a tree format.
You may need to use a pager for these commands.

```bash
dotfiles() {
  case "$1" in
    listall)
      shift
      dotfiles ls-tree --full-tree -r --name-only HEAD "$@"
      ;;
    listtree)
      shift
      if hash treeify 2>/dev/null; then
        dotfiles ls-tree --full-tree -r --name-only HEAD "$@" | treeify
      else
        dotfiles listall
      fi
      ;;
    *)
      /usr/bin/env git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME" "$@"
      ;;
  esac
}
```

`compdef` can provide `zsh` autocompletion of the `git` command for your
equivalent `dotfiles` command.

```bash
compdef dotfiles='git'
```
