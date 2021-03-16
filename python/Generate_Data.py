import os
import pandas as pd
import random

class GenerateFakeData(object):
    def __init__(self):
        self.this_dir = os.path.dirname(os.path.realpath(__file__))

    def generate_dates(self):
        pass

    def generate_int(self, length, start, stop, **kwargs):
        if length < 1:
            print("Not a valid number")
            raise SyntaxError
        elif length == 1:
            num = random.randint(start, stop)
        else: 
            num = [random.randint(start, stop) for i in range(0,len(kwargs['df']))]

        return num

    def generate_ids(self, start, stop, **kwargs):
        ids = [hash(i)**2 for i in range(start, stop)]
        
        return ids

    def main(self):
        pass
    
if __name__ == "__main__":
    sys.exit(GenerateFakeData().main())