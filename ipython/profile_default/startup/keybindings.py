"""Improve history access so I can skip over functions"""

from IPython import get_ipython
from prompt_toolkit.enums import DEFAULT_BUFFER
from prompt_toolkit.filters import HasFocus, ViNavigationMode, ViInsertMode
from prompt_toolkit.key_binding.vi_state import InputMode
from prompt_toolkit.key_binding.bindings.named_commands import get_by_name


ahoj = ""
def switch_to_navigation_mode(event):
    vi_state = event.cli.vi_state
    vi_state.input_mode = InputMode.NAVIGATION

ip = get_ipython()
registry = ip.pt_app.key_bindings
registry.add_binding('k','j',
                    filter=(HasFocus(DEFAULT_BUFFER)
                     & ViInsertMode()))(switch_to_navigation_mode)
