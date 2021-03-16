import os
import pandas as pd

class GenerateFakeData(object):
    def __init__(self):
        self.this_dir = os.path.dirname(os.path.realpath(__file__))

    def generate_dates(self):
        pass

    def generate_ids(self, df, start, stop, **args):
        ids = [hash(i)**2 for i in range(start, stop)]
        return ids

    def main(self):
        pass
    
if __name__ == "__main__":
    sys.exit(GenerateFakeData().main())