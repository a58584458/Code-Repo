.. _sharing:

********************
  Sharing Barcodes
********************

Barcodes may be shared by exporting them in an email.


.. _export-one:

Export a Barcode
================

.. list-table::
   :widths: 1 99
   :class: imglist

   * - |email icon|
     - To email a single barcode, tap the barcode from the list to see the
       :doc:`detail`, then tap the "compose email" icon in the toolbar.


.. _export-folder:

Export a Folder
===============

.. list-table::
   :widths: 1 99
   :class: imglist

   * - |email icon|
     - From the :doc:`Barcode List <barcodes>`, tap the "compose email" icon
       in the toolbar.  The list will also be attached as a :ref:`CSV
       spreadsheet <export-csv>`.


.. _export-csv:

CSV Export
==========

Full details an exported barcode list are attached to the email as a
spreadsheet file.  The spreadsheet is in CSV format, as documented by `RFC
4180`_.  This should load directly into your spreadsheet software.  If you
need to select options, use comma (``,``) for the field delimiter and
double-quoted (``"``) field data.

.. tip::

   If the hyperlinks do not work in your spreadsheet program, try changing the
   "CSV Function Style" :doc:`configuration setting <config>`.

.. _`RFC 4180`:
   http://tools.ietf.org/rfc/rfc4180.txt
