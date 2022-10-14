#!/bin/bash
set -eou pipefail

# install Python and pip
# brew install python

# install the cloudsmith CLI
pip3 install --user cloudsmith-cli

# replace "1.0.0-TEMPLATE-VERSION" with real version number as required
#grep -rl 1.0.0-TEMPLATE-VERSION pubspec.yaml | xargs sed -i "" "s/1.0.0-TEMPLATE-VERSION/$1/g"
sed -i '' "s/version: 1.0.0-TEMPLATE-VERSION/version: $1/g" pubspec.yaml

# create artifact
tar --exclude='scripts' --exclude='artifacts' --exclude='.dart_tool'  --exclude='*.ini' --exclude='**/.DS_Store' --exclude='.github'  --exclude='.vscode' --exclude='android'  --exclude='ios'  --exclude='build'  --exclude='macos'  --exclude='web'  --exclude='windows'  --exclude='.gitignore'  --exclude='.flutter-plugins' --exclude='.flutter-plugins-dependencies'   -czvf artifacts/enhantec_platform_ui_$1.tar.gz ./*

# replace real version number  back to "1.0.0-TEMPLATE-VERSION"
#grep -rl 1.0.0-TEMPLATE-VERSION pubspec.yaml | xargs sed -i "" "s/$1/1.0.0-TEMPLATE-VERSION/g" 
sed -i '' "s/version: $1/version: 1.0.0-TEMPLATE-VERSION/g" pubspec.yaml