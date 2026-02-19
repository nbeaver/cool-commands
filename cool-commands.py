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

# Using python instead of which:
import distutils.spawn
distutils.spawn.find_executable('mkdir')

# Convert hexadecimal to decimal
int("78",16) # 120
float.fromhex('0x1.ffffp10') # -4.9406564584124654e-324
int("0x78",16) # 120
# Convert decimal to hexadecimal.
hex(120) # '0x78'
3.14159.hex() # '0x1.921f9f01b866ep+1'

# Convert octal to decimal.
int('0170', 8)
# Convert decimal to octal.
oct(120)

# Convert decimal to binary.
bin(120)
# '0b1111000'
# Convert binary to decimal.
int('0b1111000', 2)
int('1111000', 2)
int('1111000', base=2)

# Convert decimal to ternary (requires numpy).
import numpy
numpy.base_repr(73, 3)
# '2201'

# Convert integer to character.
chr(32)

# Convert character to integer.
ord(' ')

# Get partial ascii table.
[(chr(i), unicodedata.name(chr(i))) for i in range(32, 127)]

# See where code crashes.
import ipdb; ipdb.set_trace()

# Or use this:
from IPython import embed; embed()
