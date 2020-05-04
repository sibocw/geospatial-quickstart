#!/usr/bin/bash

# checkout to gh-pages
current_branch=$(git branch | sed -n '/\* /s///p')
if [ ! -z "$(git branch | grep gh-pages)" ]; then
    git branch -q -D gh-pages
fi
git checkout -b gh-pages
git reset --hard origin/master
git pull origin master

# make notebook html
mkdir -p html
cd html
ln -s -f ../notebooks/figures .
cd ..
for ipynb in $(ls ./notebooks/*.ipynb); do
    jupyter nbconvert $ipynb --to html --output-dir .
done
rm html/figures

# make index html
cd ..
python utils/make_index.py

# commit changes
git add .
git commit -m "[automated] update github pages"
git push origin gh-pages
git checkout $current_branch
