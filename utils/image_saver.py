import re
import numpy as np
from PIL import Image
from pathlib import Path

# Open image file, slurp the lot
contents = Path('build/image.txt').read_text()

# Make a list of anything that looks like numbers using a regex...
# ... taking first as height, second as width and remainder as pixels
w,h, *pixels = re.findall(r'[0-9]+', contents)

# Now make pixels into Numpy array of uint8 and reshape to correct height, width and depth
na = np.array(pixels, dtype=np.uint8).reshape((int(h),int(w),3))

# Now make the Numpy array into a PIL Image and save
Image.fromarray(na).save("output/result.png")