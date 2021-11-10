import os

from ranger.api.commands import *
from ranger.core.loader import CommandLoader

class extract(Command):
    """:extract

    Extract selected files to current or specified directory.
    """

    def execute(self):
        cwd = self.fm.thisdir
        owd = cwd.path
        files = cwd.get_selection()

        if not files:
            return

        def refresh(_):
            self.fm.get_directory(owd).load_content()

        if len(files) == 1:
            descr = "extracting: " + os.path.basename(files[0].path)
        else:
            descr = "extracting files from: " + os.path.basename(files[0].dirname)

        if self.arg(1):
            name = ['-X', ' '.join(self.args[1:])]
        else:
            name = []

        cmd = ['aunpack'] + name + ['-e'] + [f.path for f in files]
        obj = CommandLoader(args=cmd, descr=descr, read=True)
        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)

    def tab(self, tabnum):
        return self._tab_directory_content()
