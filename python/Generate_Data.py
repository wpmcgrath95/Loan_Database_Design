import os
import pandas as pd

class GenerateFakeData(object):
    def __init__(self):
        self.this_dir = os.path.dirname(os.path.realpath(__file__))

    def main(self):
        pass
    
if __name__ == "__main__":
    sys.exit(GenerateFakeData().main())
