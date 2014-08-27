set history save
set history filename ~/.gdb_history

# GDB doesn't let ! mean "repeat last command" by default, since ! can rarely
# have a GDB meaning at the beginning of a line.  "Repeat last command" is
# more useful.
set history expansion

# I personally find the default AT&T style disassembly to be very awkward.
set disassembly-flavor intel

add-auto-load-safe-path ~/trunk/app/scripts/gdbinit
