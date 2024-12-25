# pylint: disable=C0111
from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401

config: ConfigAPI = config  # noqa: F821 pylint: disable=E0602,C0103

def hi(prefix: str, names: dict[str,str]):
    for key, value in names.items():
        name = 'colors.' + prefix + '.' + key
        config.set(name, value)

U0 = '#000000'; R0 = '#ff0000'
U4 = '#444444'
U7 = '#888888'; R7 = '#ff8888'
UE = '#eeeeee'
UF = '#ffffff'
XX = 'transparent'

UA = 'rgba(255,255,255,245)'

G1 = 'hsva(0,0,100%,97%)'
G3 = 'hsva(0,0,97%, 97%)'
B2 = 'hsva(205,25%,80%,100%)'

hi('completion',                {                                                  'fg': U7, 'match.fg': R7 })
hi('completion.odd',            { 'bg': XX })
hi('completion.even',           { 'bg': G1 })
hi('completion.item.selected',  { 'bg': XX, 'border.bottom': XX, 'border.top': XX, 'fg': U0, 'match.fg': R0 })
hi('completion.category',       { 'bg': XX, 'border.bottom': XX, 'border.top': XX, 'fg': U0 })
hi('completion.scrollbar',      { 'bg': XX,                                        'fg': U7 })

hi('tabs.bar',                  { 'bg': UA })
hi('tabs.odd',                  { 'bg': XX,                                        'fg': U7 })
hi('tabs.even',                 { 'bg': XX,                                        'fg': U7 })
hi('tabs.selected.odd',         { 'bg': XX,                                        'fg': U0 })
hi('tabs.selected.even',        { 'bg': XX,                                        'fg': U0 })

hi('downloads.bar',             { 'bg': UF })
hi('downloads.start',           { 'bg': UF,                                        'fg': U0 })
hi('downloads.stop',            { 'bg': UF,                                        'fg': U0 })
hi('downloads.error',           { 'bg': UF,                                        'fg': U0 })

hi('hints',                     { 'bg': XX,                                        'fg': R7, 'match.fg': R7 })

hi('prompts',                   { 'bg': UF, 'border': U0,                          'fg': U0 })
hi('prompts.selected',          { 'bg': UE,                                        'fg': U0 })

hi('keyhint',                   { 'bg': UF,                                        'fg': U7 })
hi('keyhint.suffix',            {                                                  'fg': U0 })

hi('messages.info',             { 'bg': G1, 'border': XX,                          'fg': U7 })
hi('messages.warning',          { 'bg': G1, 'border': XX,                          'fg': R7 })
hi('messages.error',            { 'bg': G1, 'border': XX,                          'fg': R0 })

hi('statusbar.normal',          { 'bg': UF,                                        'fg': U4 })
hi('statusbar.insert',          { 'bg': UF,                                        'fg': U0 })
hi('statusbar.command',         { 'bg': UF,                                        'fg': U0 })
hi('statusbar.passthrough',     { 'bg': UF,                                        'fg': U0 })
hi('statusbar.progress',        { 'bg': UF })
hi('statusbar.caret',           { 'bg': UF,                                        'fg': U0 })
hi('statusbar.caret.selection', { 'bg': UF,                                        'fg': U0 })
hi('statusbar.url',             { 'fg': U7, 'hover.fg': U0, 'error.fg': U0, 'warn.fg': U0, 'success.http.fg': U7, 'success.https.fg': B2 })

# colors.tabs.indicator.error
# colors.tabs.indicator.start
# colors.tabs.indicator.stop
# colors.tabs.indicator.system
#
# colors.tabs.pinned.even.bg
# colors.tabs.pinned.even.fg
# colors.tabs.pinned.odd.bg
# colors.tabs.pinned.odd.fg
# colors.tabs.pinned.selected.even.bg
# colors.tabs.pinned.selected.even.fg
# colors.tabs.pinned.selected.odd.bg
# colors.tabs.pinned.selected.odd.fg
