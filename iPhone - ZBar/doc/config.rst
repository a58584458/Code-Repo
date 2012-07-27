.. _config:

**************************
  Advanced Configuration
**************************

.. list-table::
   :widths: 1 99
   :class: imglist

   * - |gear icon|
     - App configuration settings are available by tapping the "Gear" icon
       from the :ref:`folder list <folders>`.


Configuration Settings
======================

Enable Beep
   Select whether the app plays a tone when a barcode is successfully scanned.
   Enabled by default.

In-app Browser
   Whether to use the built-in browser.  Disable this if you prefer to always
   use Safari.  Enabled by default.

Open Link on Scan
   Allows you to select whether the :ref:`default link <default-link>` will be
   opened automatically.  If this option is disabled, the list of available
   links will always be presented before opening the browser.  Enabled by
   default.

Scrape Results
   By default, external websites may be queried to find a description for some
   barcodes.  Disable the scraping to prevent this external communication.

CSV Function Style
   Spreadsheet programs use (at least) two different formats for hyperlinks.
   If the links in your exported spreadsheets look funny or don't work, try
   changing this setting.

   For reference, Excel and Gnumeric use commas, but only in locales where the
   comma is not used for the decimal separator.  Most other software (OOCalc,
   Google Docs...) uses semicolons or accepts either.

Enabled Symbologies
   This will show you the complete list of supported symbologies so that you
   may selectively enable them.  To avoid confusion, we recommend that you
   leave them all enabled (the default), unless you have a specific need.
