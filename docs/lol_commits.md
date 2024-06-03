# lol-commits

```sh
brew install imagemagick ffmpeg
gem install lolcommits
lolcommits --enable --delay 1 --animate 6 --fork

# to disable
lolcommits --disable

# show latest lolcommit
find ~/.lolcommits -type f -exec stat -f "%m %N" "{}" \; \
    | sort -nr | head -1 \
    | awk '{print sprintf("<img \
    style=\"height: 100vh; \
    display: block; \
    margin: auto;\" \
    src=\"%s\">", $2)}' \
    > ~/lolcommits.html \
    && open ~/lolcommits.html
```
