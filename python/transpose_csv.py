'''
Author: Roshan SK
utility script to convert CSV to JSON
'''
import pandas as pd
import os
print(os.getcwd())
files = os.listdir("python/timetables")
for file in files:
    print(file.split(".")[0])
    df = pd.read_csv("python/timetables/"+file)
    df = df.set_index("DAY ORDER")
    df.to_json("json/" + file.split(".")[0] + ".json", orient="index")


