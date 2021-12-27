# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
# * Case-insensitive globbing (used in pathname expansion)
for option in autocd globstar extglob nocaseglob; do
	shopt -s "$option" 2> /dev/null;
done;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

