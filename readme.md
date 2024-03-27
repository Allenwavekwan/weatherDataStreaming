Execute the following commands in order

1. QHOME="$PWD/x"
   ==sub x with "macos_q" for mac, "windows_q" for windows, "linux_q" for linux
2. rlwrap -r $QHOME/x/q fh.q -p 7010
   ==sub x with "m64" for mac, "w64" for windows, "l64" for linux

Open another session in terminal and repeat #1, then

3. rlwrap -r $QHOME/x/q client.q -p 7011
   ==sub x with "m64" for mac, "w64" for windows, "l64" for linux
