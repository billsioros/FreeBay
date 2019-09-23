
# Example usage: python3 recommend.py -q "$(cat example.vector)"

import numpy as np

from sys import stdin

from json import loads, dumps

from argparse import ArgumentParser

from loader import Loader


np.seterr(all='raise')

parser = ArgumentParser()

parser.add_argument("-t", "--top",       help="return the top TOP candidates", type=int, default=10)
parser.add_argument("-v", "--verbose",   help="explain what is being done",    action="store_true")
parser.add_argument("-o", "--overwrite", help="re-train the model",            action="store_true")

args = parser.parse_args()

model = Loader(verbose=args.verbose, overwrite=args.overwrite)

query = None

while query is None:

    try:

        query = stdin.readlines()

    except:

        continue

    if query:

        try:

            if len(query) > 1:

                raise ValueError("Multiple arguements are not supported")

            response = {
                "data" : [
                    {
                        "id": candidate[0],
                        "score": candidate[1]
                    } for candidate in model.top(loads(query[0]), args.top)
                ],
                "error": False,
                "message": "OK"
            }

        except Exception as e:

            response = {
                "data": [],
                "error": True,
                "message": str(e)
            }

        query = None

        print(dumps(response, indent=4))
