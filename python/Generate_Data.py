"""
- create sql database with sql
- create docker container that creates sql database and lets user query through database
"""
import itertools
import json
import os
import random
import re
import sys
import uuid
from datetime import datetime, timedelta

import pandas as pd


class GenerateRawData(object):
    def __init__(self, data_model_file=None):
        self.this_dir = os.path.dirname(os.path.realpath(__file__))
        self.data_model_file = os.path.join(
            self.this_dir, "../data/loan_data_model.xlsx"
        )
        self.data_model = pd.read_excel(
            self.data_model_file, sheet_name="Raw_Table", engine="openpyxl"
        ).dropna(how="all")

    def generate_type(self, **kwargs):
        pass

    def generate_names(self, **kwargs):
        pass

    def generate_dates(self, **kwargs):
        pass

    def generate_nums(self, **kwargs):
        pass

    def generate_int(self, length, start, stop, **kwargs):
        if length < 1:
            print("Not a valid number")
            raise SyntaxError
        elif length == 1:
            num = random.randint(start, stop)
        else:
            num = [random.randint(start, stop) for i in range(0, len(kwargs["df"]))]

        return num

    def generate_ids(self, start, stop, **kwargs):
        ids = [hash(i) ** 2 for i in range(start, stop)]

        return ids

    def main(self):
        pass


if __name__ == "__main__":
    sys.exit(GenerateRawData().main())
