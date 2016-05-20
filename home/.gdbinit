set history save
set history filename ~/.gdb_history

# GDB doesn't let ! mean "repeat last command" by default, since ! can rarely
# have a GDB meaning at the beginning of a line.  "Repeat last command" is
# more useful.
set history expansion

# I personally find the default AT&T style disassembly to be very awkward.
set disassembly-flavor intel

add-auto-load-safe-path ~/trunk/app/scripts/gdbinit
add-auto-load-safe-path /usr/lib/libstdc++.so.6.0.21-gdb.py
add-auto-load-safe-path /usr/lib/i386-linux-gnu/libstdc++.so.6.0.21-gdb.py

# libstd++ pretty printers, as provided by Ubuntu.
# See https://sourceware.org/gdb/wiki/STLSupport.
python
import os
import sys
for d in ['/usr/share/gcc-6/python', '/usr/share/gcc-5/python']:
    if os.path.isdir(d):
        sys.path.insert(0, d)
        break
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end

# From https://github.com/mateidavid/Boost-Pretty-Printer (a newer fork of
# ruediger/Boost-Pretty-Printer)
python
import os
import sys
boost_dir = os.path.expanduser('~/src/Boost-Pretty-Printer')
if os.path.exists(boost_dir):
    sys.path.insert(0, boost_dir)
    import boost.latest
    boost.register_printers()
end
