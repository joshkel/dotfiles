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

# TODO: Figure out how to make this work
# See https://stackoverflow.com/q/41160447/25507,
# https://stackoverflow.com/q/40391404/25507,
# https://chezsoi.org/lucas/blog/gdb-python-macros
# Maybe the problem is virtual environments?
#set debug auto-load
#add-auto-load-safe-path /usr/lib/debug/usr/bin/python3.4-gdb.py
#set auto-load python-scripts on

# For Mono
handle SIGXCPU SIG33 SIG35 SIG36 SIG37 SIG38 SIGPWR nostop noprint

# libstd++ pretty printers, as provided by Ubuntu.
# See https://sourceware.org/gdb/wiki/STLSupport.
python
import os
import sys
for d in ['/usr/share/gcc-7/python', '/usr/share/gcc-6/python', '/usr/share/gcc-5/python']:
    if os.path.isdir(d):
        sys.path.insert(0, d)
        break
try:
    from libstdcxx.v6.printers import register_libstdcxx_printers
    register_libstdcxx_printers (None)
except ImportError as e:
    print("libstdc++ pretty printers are unavailable: " + str(e))
end

# From https://github.com/mbalabin/Boost-Pretty-Printer (a newer fork of
# ruediger/Boost-Pretty-Printer)
python
import os
import sys
# Not sure of the exact version requirement; I know 2.5 doesn't work.
if sys.version_info > (2, 7):
    boost_dir = os.path.expanduser('~/.homesick/repos/Boost-Pretty-Printer')
    if os.path.exists(boost_dir):
        sys.path.insert(0, boost_dir)
        import boost
        try:
            boost.register_printers()
        except Exception as e:
            print("Boost pretty printers are unavailable: " + str(e))
end
