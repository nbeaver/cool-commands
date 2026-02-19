# sage command
plot_vector_field((y, -x), (x,-3,3), (y,-3,3))
VectorPlot[{y, -x}, {x, -3, 3}, {y, -3, 3}]

# in python, save interactive history in current directory:
import readline
readline.write_history_file("my_history.txt")

# Python version.
import binascii
binascii.crc32("This is only a test.\n")
# 828642827
import hashlib
hashlib.md5("This is only a test.\n").hexdigest()
# 'b9fdcb35dba569b1ca651f2b243b5144'
