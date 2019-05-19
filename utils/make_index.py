import re
from subprocess import call

with open('README.md') as fh:
    readme_md = fh.read()

nb_links = re.findall('[.*](.*notebooks/.*.ipynb)', readme_md)
for nb_link in nb_links:
    html_link = nb_link.replace('notebooks/', 'html/').replace('.ipynb', '.html')
    readme_md = readme_md.replace(nb_link, html_link)

with open('README.md', 'w') as fh:
    fh.write(readme_md)
call(['pandoc', 'README.md', '--to', 'html', '--output', 'index.html'])