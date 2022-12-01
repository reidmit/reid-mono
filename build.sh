#!/usr/bin/env bash

root_dir=$(git rev-parse --show-toplevel)
output_dir=$root_dir/output

mkdir -p $output_dir/built

test -d "$output_dir/cloned" || git clone --depth 1 https://github.com/be5invis/Iosevka $output_dir/cloned

cp $root_dir/private-build-plans.toml $output_dir/cloned

pushd $output_dir/cloned > /dev/null

git pull
npm install
npm run build -- ttf-unhinted::reid-mono

cp dist/reid-mono/ttf-unhinted/*.ttf $output_dir/built

if [ -z "$SKIP_OSX_INSTALL" ]; then
  cp -f dist/reid-mono/ttf-unhinted/*.ttf $HOME/Library/Fonts
fi

popd > /dev/null