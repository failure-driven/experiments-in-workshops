**co-authors**

```sh
# check your global config
vi ~/.gitconfig
git config --list
git config --global --edit

# install git-mob, it's a node module
npm install --global git-mob

# configure git-mob to grab users from the internt
git config --global git-mob-config.github-fetch true
# check your ~/.gitconfig
# add a user
git mob saramic
# check the template ~/.gitmessage
cat ~/.gitmessage
# show your users
git mob --list
# or
git cat ~/.git-coauthors

# show your mob
git mob
Jenny <jenny@example.com>
John  <john@example.com>

# go solo
git solo
# ie make the ~/.gitmessage have no co-authors
cat ~/.gitmessage
```
