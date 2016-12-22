# Return some system information
# Because the universe will never have enough scripts that do this

# It's only going to work on fairly recent *NIX platforms
import os, socket

uname_ = os.uname()
system = uname_[0]
host = socket.gethostname()
kernel = uname_[2]
release = uname_[3]
processor = uname_[4]



