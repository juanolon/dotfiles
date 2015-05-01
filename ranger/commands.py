from ranger.api.commands import *
import subprocess

class fasd(Command):
    """
    :fasd

    Jump to directory using fasd
    """
    def execute(self):
        arg = self.rest(1)
        if arg:
            directory = subprocess.check_output(["fasd", "-d"]+arg.split(), universal_newlines=True).strip()
            self.fm.cd(directory)

class v(Command):
    """:v

    open file/directory with tvim
    """

    def execute(self):
        action = ['tvim']
        action.extend(f.path for f in self.fm.thistab.get_selection())
        self.fm.execute_command(action)
