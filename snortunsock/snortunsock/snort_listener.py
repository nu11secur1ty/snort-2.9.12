import os
import socket
import logging

from . import alert

logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)
BUFSIZE = alert.AlertPkt._ALERTPKT_SIZE


def start_recv(sockfile=None):
    '''Open a server on Unix Domain Socket'''

    if sockfile is not None:
        SOCKFILE = sockfile
    else:
        # default sockfile
        SOCKFILE = "/tmp/snort_alert"

    if os.path.exists(SOCKFILE):
        os.unlink(SOCKFILE)
    unsock = socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)
    unsock.bind(SOCKFILE)
    logging.warning('Unix socket start listening...')
    while True:
        data = unsock.recv(BUFSIZE)
        parsed_msg = alert.AlertPkt.parser(data)
        if parsed_msg:
            yield parsed_msg

if __name__ == '__main__':
    start_recv()
