#!/usr/bin/env python3
import socket
import sys
import os
import time

HOST = "127.0.0.1"
PORT = 55355
STATE_FILE = "/run/retroarch-was-playing"
TIMEOUT = 0.3

def send_cmd(cmd):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.settimeout(TIMEOUT)
    try:
        sock.sendto(cmd.encode(), (HOST, PORT))
        return sock.recv(1024).decode()
    except socket.timeout:
        return ""
    finally:
        sock.close()

mode = sys.argv[1] if len(sys.argv) > 1 else ""

if mode == "pre":
    with open("/tmp/pre-debug.log", "w") as f:
        status = send_cmd("GET_STATUS")
        f.write(f"status={status!r}\n")
        if "PLAYING" in status:
            open(STATE_FILE, "w").close()
            f.write("created STATE_FILE\n")
            send_cmd("PAUSE_TOGGLE")
        else:
            f.write("did not match PLAYING\n")
            if os.path.exists(STATE_FILE):
                os.remove(STATE_FILE)
elif mode == "post":
    if os.path.exists(STATE_FILE):
        with open("/tmp/suspend-hook-debug.log", "w") as f:
            for i in range(15):
                time.sleep(0.3)
                status = send_cmd("GET_STATUS")
                f.write(f"try {i}: status={status!r}\n")
                if "PAUSED" in status:
                    send_cmd("PAUSE_TOGGLE")
                    f.write("sent PAUSE_TOGGLE\n")
                    break
        os.remove(STATE_FILE)
