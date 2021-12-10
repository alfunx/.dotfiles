#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import os
import readline
import rlcompleter
import atexit
from pprint import pprint
from tempfile import mkstemp
from code import InteractiveConsole

from math import *
import datetime as dt
import pdb

import numpy as np
import pandas as pd


# Color Support
###############

class TermColors(dict):
    COLOR_TEMPLATES = (
        ("black1",    "0;30"),
        ("red1",      "0;31"),
        ("green1",    "0;32"),
        ("yellow1",   "0;33"),
        ("blue1",     "0;34"),
        ("purple1",   "0;35"),
        ("cyan1",     "0;36"),
        ("white1",    "0;37"),
        ("black2",    "0;90"),
        ("red2",      "0;91"),
        ("green2",    "0;92"),
        ("yellow2",   "0;93"),
        ("blue2",     "0;94"),
        ("purple2",   "0;95"),
        ("cyan2",     "0;96"),
        ("white2",    "0;97"),
        ("normal",    "0"),
        ("bold",      "1"),
        ("dim",       "2"),
        ("italic",    "3"),
        ("underline", "4"),
    )
    _base = '\001\033[%sm\002'

    def __init__(self):
        self.update(dict([(k, self._base % v) for k, v in self.COLOR_TEMPLATES]))


_c = TermColors()


# History
#########

HISTFILE = "%s/.pyhistory" % os.environ["HOME"]

# read existing history
if os.path.exists(HISTFILE):
    readline.read_history_file(HISTFILE)

# set maximum number of items
readline.set_history_length(300)

# write history file on exit
atexit.register(lambda: readline.write_history_file(HISTFILE))


# Color Prompts
###############

sys.ps1 = '%(yellow1)s%(bold)s>%(yellow2)s%(bold)s> %(normal)s' % _c
sys.ps2 = '%(yellow2)s%(bold)s | %(normal)s' % _c


# Pretty Printing
#################

def displayhook(value):
    if value is None:
        return
    try:
        import __builtin__
        __builtin__._ = value
    except ImportError:
        __builtins__._ = value
    pprint(value)


sys.displayhook = displayhook


# Welcome message
#################

WELCOME = """
%(cyan1)sType "\\e" to get an external editor.

%(black2)sfrom math import *
%(black2)simport sys, os, pdb
%(black2)simport numpy as np
%(black2)simport pandas as pd
%(black2)simport datetime as dt
%(normal)s""" % _c


# External editor with \e
#########################
# http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/438813/

EDITOR = os.environ.get('EDITOR', 'vim')
EDIT_CMD = '\\e'


class EditableBufferInteractiveConsole(InteractiveConsole):
    def __init__(self, *args, **kwargs):
        self.last_buffer = []  # this holds the last executed statement
        InteractiveConsole.__init__(self, *args, **kwargs)

    def runsource(self, source, *args):
        self.last_buffer = [source.encode('utf-8')]
        return InteractiveConsole.runsource(self, source, *args)

    def raw_input(self, *args):
        line = InteractiveConsole.raw_input(self, *args)
        if line == EDIT_CMD:
            fd, tmpfl = mkstemp('.py')
            os.write(fd, b'\n'.join(self.last_buffer))
            os.close(fd)
            os.system('%s %s' % (EDITOR, tmpfl))
            line = open(tmpfl).read()
            os.unlink(tmpfl)
            tmpfl = ''
            lines = line.split('\n')
            for i in range(len(lines) - 1):
                self.push(lines[i])
            line = lines[-1]
        return line


c = EditableBufferInteractiveConsole(locals=locals())


if sys.version_info >= (3, 0, 0):
    c.interact(banner=WELCOME, exitmsg='')
else:
    c.interact(banner=WELCOME)


# exit the Python shell on exiting the InteractiveConsole
sys.exit()
