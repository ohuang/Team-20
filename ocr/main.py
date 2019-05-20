try:
    from PIL import Image
except ImportError:
    import Image
import pytesseract
import sys
pytesseract.pytesseract.tesseract_cmd = r'env/bin/tesseract/4.0.0_1/bin/tesseract'
print(sys.argv[1])
print(pytesseract.image_to_string(Image.open(sys.argv[1])))
