##################
#  BASH_PROFILE  #
##################

# profile
[[ -f ~/.profile ]] && source ~/.profile

# opam configuration
test -r /home/toaster/.opam/opam-init/init.sh && . /home/toaster/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
