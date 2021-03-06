
from datetime import datetime

from sys import stderr


class Logger:

    def __init__(self, name, fmt="%H:%M:%S"):

        if not isinstance(name, str):

            raise TypeError("'name' must be an instance of 'str'")

        if not isinstance(fmt, str):

            raise TypeError("'fmt' must be an instance of 'str'")

        self.name, self.fmt = name, fmt


    def log(self, *args, **kwargs):

        if self.fmt:

            print("[{}] [{}]".format(self.name, datetime.now().strftime(self.fmt)), file=stderr, *args, **kwargs)

        else:

            print("[{}]".format(self.name), file=stderr, *args, **kwargs)

