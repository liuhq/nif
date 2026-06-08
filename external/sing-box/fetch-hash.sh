#!/usr/bin/env sh

json_file="data.json"
output_file="result.nix"
tmpdir=$(mktemp -d)

echo "" >"$output_file"

echo "{" >>"$output_file"

jq -r 'to_entries[] | .key as $type | .value | "\($type) \(.commit) \(.tag[])"' \
  "$json_file" | while read -r type commit tag; do
  url_templates=$(jq -r ".\"$type\".\"\$url\"" "$json_file")
  url=$(echo "$url_templates" | awk -v commit="$commit" -v tag="$tag" '{gsub(/\$commit/, commit); gsub(/\$tag/, tag); print}')

  echo "fetching: $url" >&2
  safe_name=$(echo "$tag" | tr '@!' '-')
  curl -fsSL -o "$tmpdir/${safe_name}.srs" "$url"
  hash=$(nix store prefetch-file --json "file://$tmpdir/${safe_name}.srs" 2>/dev/null | jq -r .hash)

  echo "  \"$tag\" = \"$hash\";" >>"$output_file"
done

rm -rf "$tmpdir"

echo "}" >>"$output_file"

echo "finished! output: $output_file"
echo ""
echo "================"
cat "$output_file"
