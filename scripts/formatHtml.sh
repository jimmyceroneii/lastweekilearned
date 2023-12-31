#!/bin/bash

filename="$1"
title="$2"
type="$3"

md_filename="./md/$filename.md"
html_filename="./html/$type/$filename.html"

## convert markdown to html
pandoc --from markdown --to html --ascii "$md_filename" -o "$html_filename"

# Create a temporary file to hold the modified content
tmp_file=$(mktemp)

# Add the HTML markup to the temporary file
echo "<!DOCTYPE html>" > "$tmp_file"
echo "<html>" >> "$tmp_file"
echo "<head>" >> "$tmp_file"
echo "<title>${title}</title>" >> "$tmp_file"
echo "<meta charset=\"utf-8\">" >> "$tmp_file"
echo "<meta name=\"viewport\" content=\"width=device-width\">" >> "$tmp_file"
echo "<link type=\"text/css\" rel=\"stylesheet\" href=\"../style.css\">" >> "$tmp_file"
echo "<link rel=icon type=image/x-icon href=../images/favicon.png>" >> "$tmp_file"
echo "</head>" >> "$tmp_file"
echo "<body>" >> "$tmp_file"
echo "<nav class=menu>" >> "$tmp_file"
echo "<div>" >> "$tmp_file"
echo "<a href=\"../index.html\">Home</a>" >> "$tmp_file"
echo "</div>" >> "$tmp_file"
echo "</nav>" >> "$tmp_file"

# Append the content of the original file to the temporary file
cat "${html_filename}" >> "$tmp_file"

# Add the closing HTML tags to the temporary file
echo "</body></html>" >> "$tmp_file"

# Overwrite the original file with the modified content
mv "$tmp_file" "$html_filename"

# Run the command to list files excluding "index.html" and store the output in a variable
files=$(cd ./html/$type && ls -t *.html | grep -v -e '^index\.html$')

# Specify the name of the output HTML file
output_file="./html/$type/index.html"

# Create the HTML file and write the initial HTML structure
echo "<!DOCTYPE html>
<html>
<head>
<meta charset=\"utf-8\">
<meta name=\"viewport\" content=\"width=device-width\">
<link type=\"text/css\" rel=\"stylesheet\" href=\"../style.css\">
<link rel=\"icon\" type=\"image/x-icon\" href=\"../images/favicon.png\">
<title>$type</title>
</head>
<body>
<nav class=menu>
        <div>
            <a href=\"../index.html\">Home</a>
        </div>
</nav>
<h1>$type</h1>
<ul>" > "$output_file"

# Iterate over the files and generate HTML hyperlinks
while IFS= read -r file; do
  echo "<li><a href=\"$file\">$file</a><br></li>" >> "$output_file"
done <<< "$files"

# Write the closing HTML tags
echo "</ul></body>
</html>" >> "$output_file"

chmod 644 "$output_file"
chmod 644 "$html_filename"

