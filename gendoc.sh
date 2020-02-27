cd ProjetTPCI
git checkout --orphan gh-pages
git rm -rf .
echo "My gh-pages branch" > README.md
git add .
git commit -am "Clean gh-pages branch"
git push origin gh-pages
