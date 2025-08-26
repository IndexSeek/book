#!/bin/bash

[[ $# -eq 0 ]] && exit 0

for f in "$@"; do
    [[ $f != *.qmd && $f != *.md ]] && continue

    tmp=$(mktemp)
    code=0
    yaml=0

    while read -r line; do
        case "$line" in
            "---")
                yaml=$((1-yaml))
                echo "$line"
                ;;
            '```'*)
                code=$((1-code))
                echo "$line"
                ;;
            *)
                if (( code || yaml )); then
                    echo "$line"
                elif [[ -z "$line" || "$line" =~ ^[[:space:]]*(#|\*|[0-9]+\.) ]]; then
                    echo "$line"
                else
                    fmt -w90 <<< "$line"
                fi
                ;;
        esac
    done < "$f" > "$tmp"

    mv "$tmp" "$f"
done
