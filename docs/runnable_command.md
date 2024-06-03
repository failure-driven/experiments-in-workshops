# runnable command

```sh
mkdir bin

cat << EOF > bin/run.rb
#!/usr/bin/env ruby

\$LOAD_PATH << File.join(File.dirname(__FILE__), '../lib')

# TODO: replace file name with class and filename
require 'file_name'

file_name = FileName.new
file_name.run(*ARGV)
EOF

# make script executable +x
chmod +x bin/run.rb

# run it
bin/run.rb arg_1 arg_2
```
