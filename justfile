# Preview the book with live reload
preview:
    #!/usr/bin/env bash
    rm -rf .quarto
    uv run quarto preview

# Clean build artifacts
clean:
    rm -rf .quarto
    rm -rf _book

# Install dependencies
install:
    uv sync

# Format code with ruff (Python) and styler (R)
fmt:
    pre-commit run --all-files
