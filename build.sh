echo "Rebuilding all user code..."
rm -rf elm-stuff/build-artifacts/0.18.0/user && time elm-make Main.elm --warn --output /tmp/index.html
