import os

from ranger.api.commands import *
from ranger.core.loader import CommandLoader

class compress(Command):
    """:compress

    Compress selected files to specified archive.
    """

    def execute(self):
        cwd = self.fm.thisdir
        owd = cwd.path
        files = cwd.get_selection()

        if not files:
            return
        if len(self.args) < 1:
            return

        def refresh(_):
            self.fm.get_directory(owd).load_content()

        if len(files) == 1:
            descr = "compressing: " + os.path.basename(files[0].path)
        else:
            descr = "compressing files from: " + os.path.basename(files[0].dirname)

        if self.arg(1):
            name = [' '.join(self.args[1:])]
        else:
            name = [os.path.basename(files[0].path) + '.tar.gz']

        cmd = ['apack'] + name + [os.path.relpath(f.path, cwd.path) for f in files]
        obj = CommandLoader(args=cmd, descr=descr, read=True)
        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)

    def tab(self, tabnum):
        return self._tab_directory_content()
