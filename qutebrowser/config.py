# pylint: disable=C0111
from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401
from qutebrowser.config.config import ConfigContainer  # noqa: F401

config: ConfigAPI = config  # noqa: F821 pylint: disable=E0602,C0103
c: ConfigContainer = c  # noqa: F821 pylint: disable=E0602,C0103

config.load_autoconfig(False)

config.source('colors/zoom.py')

config.set('fonts.default_family', 'LexendDeca')

#config.set('downloads.position', 'bottom')

c.input.insert_mode.auto_enter = False
c.input.insert_mode.auto_leave = False

#config.set('tabs.show', 'never')
config.set('tabs.select_on_remove', 'last-used')

config.set('content.javascript.clipboard', 'access')
config.set('completion.open_categories', ['quickmarks', 'history', 'searchengines'])

c.url.searchengines['am'] = 'https://man.archlinux.org/search?q={}'
c.url.searchengines['ar'] = 'https://archlinux.org/packages/?q={}'
c.url.searchengines['aw'] = 'https://wiki.archlinux.org/title/Special:Search/{}'
c.url.searchengines['br'] = 'https://www.britannica.com/search?query={}'
c.url.searchengines['gh'] = 'https://github.com/search?q={}'
c.url.searchengines['hn'] = 'https://hn.algolia.com/?q={}'
c.url.searchengines['ji'] = 'https://jisho.org/search/{}'
c.url.searchengines['ma'] = 'https://math.stackexchange.com/search?q={}'
c.url.searchengines['nr'] = 'https://search.nixos.org/packages?query={}'
c.url.searchengines['no'] = 'https://search.nixos.org/options?query={}'
c.url.searchengines['pw'] = 'https://proofwiki.org?search={}'
c.url.searchengines['re'] = 'https://www.reddit.com/search/?q={}'
c.url.searchengines['wi'] = 'https://en.wikipedia.org/wiki/Special:Search/{}'
c.url.searchengines['yt'] = 'https://www.youtube.com/results?search_query={}'

# c.editor.command = ['foot', '-e', 'nvim', '{file}', '-c', 'normal {line}G{column0}l']
#
# c.fileselect.handler = 'external'
# c.fileselect.folder.command = ['foot', '-e', 'zsh', '-c', 'realpath $(find . -type -d | fzf) > {}']
# c.fileselect.multiple_files.command = ['foot', '-e', 'zsh', '-c', 'realpath $(fzf -m) > {}']
# c.fileselect.single_file.command = ['foot', '-e', 'zsh', '-c', 'realpath $(fzf) > {}']

config.bind('<Ctrl-o>', 'tab-focus stack-prev')
config.bind('<Ctrl-i>', 'tab-focus stack-next')

config.bind('ey', ':cmd-set-text :tab-focus https://www.youtube.com')
config.bind('ec', ':cmd-set-text :tab-focus https://chatgpt.com')
config.bind('eq', ':cmd-set-text :tab-focus https://q.utoronto.ca')
config.bind('et', ':cmd-set-text :tab-focus https://calendar.google.com')

config.bind('zl', 'spawn --userscript qute-pass -n -d bemenu -U secret -u "username: (.+)"')
config.bind("zul", 'spawn --userscript qute-pass -n -d bemenu -U secret -u "username: (.+)" --username-only')
config.bind("zpl", "spawn --userscript qute-pass -n -d bemenu --password-only")
