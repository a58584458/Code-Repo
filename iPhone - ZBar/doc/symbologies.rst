.. _symbologies:

*************************
  Supported Symbologies
*************************

There are many different kinds of barcodes.  Each one is called a "symbology".
These are the specific symbologies currently supported by the ZBar app.


EAN/UPC Symbologies
===================

These linear symbologies are defined by `GS1`_ specifically for labeling
consumer products.

EAN-13
~~~~~~
`EAN-13`_ encodes an international 13-digit product number known as a
`GTIN-13`_.  These numbers uniquely identify every consumer product in the
world!

UPC-A
~~~~~
`UPC-A`_ is actually just another name for an EAN-13 barcode that starts with
a leading zero (the country code for the US).  If the zero is dropped, the
resulting 12-digit product number is known as a `GTIN-12`_.

EAN-8
~~~~~
`EAN-8`_ is a shortened version of EAN-13 that only encodes 8 digits and uses
specially allocated GTIN-8 product numbers.

UPC-E
~~~~~
`UPC-E`_ is a compressed version of UPC-A that works by eliminating certain
zeros from a GTIN-13 code.  In order to be useful, the data is usually
decompressed back to a GTIN-12 or GTIN-13 product number.


Linear Symbologies
==================

These symbologies use simple bars to encode data in just one dimension.  Note
that, in many cases, it is impossible to know the intended use for these
barcodes just by looking at the decoded data - it may be a package tracking
number, a library book, a receipt or transaction number, just about anything!

Code 128
~~~~~~~~
`Code 128`_, defined by ISO/IEC 15417, is a very dense, secure and flexible
symbology that can encode any ASCII character.  `GS1-128`_ is a special
variation of Code 128 that can be used for structured product data.

Code 93
~~~~~~~
`Code 93`_, defined by AIM-BC5, is less dense but somewhat more secure than
Code 128.  It is used by the health care industry and some postal systems.

Code 39
~~~~~~~
`Code 39`_, defined by ISO/IEC 16388, is still very popular despite inferior
density and data security.  This symbology can represent only numbers, capital
letters and a few punctuation marks.  It is used by the DoD, in the health
care industry, for some tracking numbers and document automation systems,
among others.

Interleaved 2 of 5
~~~~~~~~~~~~~~~~~~
`Interleaved 2 of 5`_, defined by ISO/IEC 16390, is an older symbology that
can represent only numbers.  It is still frequently used in various
applications, even though other symbologies are usually a better choice.

DataBar and DataBar Expanded
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`GS1 DataBar`_, defined by ISO/IEC 24724, is also used to label consumer
products.  It is frequently found on produce and coupons.  Formerly known as
Reduced Space Symbology (RSS), this symbology offers very high density and
data security.  The base symbol encodes only a GTIN-14 product code, similar
to EAN/UPC, while the "expanded" variant supports application identifiers
(AIs) with additional product data.


2-D Symbologies
===============

These symbologies encode data in two dimensions - horizontally and vertically
- allowing for much higher capacity.  They also offer `Error Checking and
Correction (ECC)`_ for very high data security; most symbols may be read
even if sections are missing or damaged!

.. _qr:

QR Code
~~~~~~~
A `QR Code`_, defined by ISO/IEC 18004, can be identified by the telltale
squares in three of the corners.  These symbols may encode almost any kind of
data: URLs, email addresses, VCARDS, mobile tags, vehicle VIN numbers, even an
image or text file.


.. _GS1: http://wikipedia.org/wiki/GS1
.. _GTIN-12:
.. _GTIN-13: http://wikipedia.org/wiki/Global_Trade_Item_Number
.. _EAN-13: http://wikipedia.org/wiki/EAN-13
.. _EAN-8: http://wikipedia.org/wiki/EAN-8 
.. _UPC-E:
.. _UPC-A: http://wikipedia.org/wiki/Universal_Product_Code
.. _Code 128: http://wikipedia.org/wiki/Code_128
.. _GS1-128: http://wikipedia.org/wiki/GS1-128
.. _Code 93: http://wikipedia.org/wiki/Code_93
.. _Code 39: http://wikipedia.org/wiki/Code_39
.. _Interleaved 2 of 5: http://wikipedia.org/wiki/Interleaved_2_of_5
.. _GS1 DataBar: http://wikipedia.org/wiki/GS1_DataBar
.. _`Error Checking and Correction (ECC)`:
.. _ECC: http://wikipedia.org/wiki/Error_Checking_and_Correcting
.. _QR Code: http://wikipedia.org/wiki/QR_code
