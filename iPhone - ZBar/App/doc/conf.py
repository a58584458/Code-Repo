import sys, os
from plistlib import readPlist

# General configuration

extensions = []
templates_path = ['ext']
source_suffix = '.rst'
master_doc = 'index'
exclude_patterns = ['.#*', 'static/*.svg', 'subst.rst']

project = u'ZBar iOS App User Guide'
copyright = u'2009-2011, Jeff Brown et al'

today_fmt = '%Y-%m-%d'
info = readPlist('../info.plist')
version = 'X.Y'
if info:
    version = info['CFBundleVersion']
release = version

pygments_style = 'sphinx'

rst_epilog = open('subst.rst').read()

# Options for HTML output

html_theme = 'sphinxdoc'
html_theme_options = {
    'nosidebar': True,
}

html_short_title = 'ZBar ' + version
html_title = u'ZBar iOS App'
html_static_path = ['static']
html_logo = '../rsrc/zbar-iphone.118.png'
##html_favicon = '../../zbar.ico'
html_style = 'style.css'
html_use_modindex = False
html_use_index = False
html_copy_source = False
html_show_sourcelink = False
htmlhelp_basename = 'doc'

# Options for LaTeX output

latex_paper_size = 'letter'
latex_font_size = '10pt'

# Grouping the document tree into LaTeX files. List of tuples
# (source start file, target name, title, author, documentclass [howto/manual])
latex_documents = [
  ('index', 'ZBar-iphone-ug.tex', project, u'Jeff Brown', 'manual'),
]

#latex_logo = ''
#latex_use_parts = False
#latex_preamble = ''
#latex_appendices = []
#latex_use_modindex = False
