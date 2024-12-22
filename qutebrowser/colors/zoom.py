# pylint: disable=C0111
from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401

config: ConfigAPI = config  # noqa: F821 pylint: disable=E0602,C0103

U0 = '#000000'; R0 = '#ff0000'
U4 = '#444444'
U7 = '#777777'; R7 = '#ff7777'
UE = '#eeeeee'
UF = '#ffffff'
UG = 'transparent'

def set_color(prefix: str, names: dict[str,str]):
    for key, value in names.items():
        name = 'colors.' + prefix + '.' + key
        config.set(name, value)

set_color('completion',               { 'fg': U7, 'odd.bg': UF, 'even.bg': UF, 'match.fg': R7 })
set_color('completion.item.selected', { 'fg': U0, 'bg': UF, 'match.fg': R0, 'border.top': UG, 'border.bottom': UG })
set_color('completion.category',      { 'fg': U0, 'bg': UF, 'border.top': UG, 'border.bottom': UG })
set_color('completion.scrollbar',     { 'fg': U0, 'bg': UF })

set_color('hints', {'fg': U4, 'match.fg': U0, 'bg': UF })

set_color('prompts',          { 'fg': U0, 'bg': UF, 'border': U0 })
set_color('prompts.selected', { 'fg': U0, 'bg': UE })

set_color('keyhint', { 'fg': U7, 'bg': UF, 'suffix.fg': U0 })

set_color('messages.info',    { 'fg': U7, 'bg': UF, 'border': UG })
set_color('messages.warning', { 'fg': R0, 'bg': UF, 'border': UG })
set_color('messages.error',   { 'fg': R7, 'bg': UF, 'border': UG })

set_color('downloads',       { 'bar.bg': UF })
set_color('downloads.start', { 'fg': U0, 'bg': UF })
set_color('downloads.stop',  { 'fg': U0, 'bg': UF })
set_color('downloads.error', { 'fg': U0, 'bg': UF })

set_color('statusbar.normal',      { 'fg': U4, 'bg': UF })
set_color('statusbar.insert',      { 'fg': U0, 'bg': UF })
set_color('statusbar.command',     { 'fg': U0, 'bg': UF })
set_color('statusbar.passthrough', { 'fg': U0, 'bg': UF })
set_color('statusbar.progress',    { 'bg': UF })
set_color('statusbar.caret',       { 'fg': U0, 'bg': UF, 'selection.fg': U0, 'selection.bg': UF })
set_color('statusbar.url',         { 'fg': U0, 'warn.fg': U0, 'error.fg': U0, 'success.http.fg': U0, 'success.https.fg': U0 })
