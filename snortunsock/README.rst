Snortunsock
===========

A Python listener to capture `Snort`_ event via the UNIX Socket output.

Snortunsock can parse and show the alert message.

Installation
============

Install Snortunsock from `PyPI`_:

::

    $ pip install snortunsock

Usage
=====

The basic usage

.. code:: python


    import dpkt

    from snortunsock import snort_listener

    for msg in snort_listener.start_recv("/tmp/snort_alert"):
        print('alertmsg: %s' % ''.join(msg.alertmsg))
        buf = msg.pkt

        # buf is a raw packet which can use dpkt library to parsing it

        # Unpack the Ethernet frame (mac src/dst, ethertype)
        eth = dpkt.ethernet.Ethernet(buf)

The complicated examples are in the ``examples`` folder

Related
=======

-  See `dpkt`_ which is a fast, simple packet creation/parsing, with
   definitions for the basic TCP/IP protocols.

LICENSE
=======

Apache License, Version 2.0

.. _Snort: https://www.snort.org/
.. _PyPI: https://pypi.python.org/pypi/snortunsock
.. _dpkt: https://pypi.python.org/pypi/dpkt
