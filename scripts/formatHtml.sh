#!/bin/bash

filename="$1"
title="$2"

md_filename="$filename.md"
html_filename="$filename.html"

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
echo "<link type=\"text/css\" rel=\"stylesheet\" href=\"style.css\">" >> "$tmp_file"
echo "</head>" >> "$tmp_file"
echo "<body>" >> "$tmp_file"

# Append the content of the original file to the temporary file
cat "${html_filename}" >> "$tmp_file"

# Add the closing HTML tags to the temporary file
echo "</body></html>" >> "$tmp_file"

# Overwrite the original file with the modified content
mv "$tmp_file" "$html_filename"

# Run the command to list files excluding "index.html" and store the output in a variable
files=$(cd ./html/ && ls -t *.html | grep -v -e '^index\.html$')

# Specify the name of the output HTML file
output_file="./html/index.html"

# Create the HTML file and write the initial HTML structure
echo "<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link type="text/css" rel="stylesheet" href="style.css">
<link rel="icon" type="image/x-icon" href="/images/favicon.png">
<title>Home Page</title>
</head>
<body>
<nav class="crumbs">
    <h1>Home Page</h1>
    <ul>
        <li class="crumb"><a href="https://github.com/Jimmy-Neil-Have-Problems/idea-repository/wiki">Ideas</a></li>
        <li class="crumb"><a href="./hyper-local">Hyper Local Blog</a></li>
    </ul>
</nav>
<ul>" > "$output_file"

# Iterate over the files and generate HTML hyperlinks
while IFS= read -r file; do
  echo "<li><a href=\"$file\">$file</a><br></li>" >> "$output_file"
done <<< "$files"

# Write the closing HTML tags
echo "</ul></body>
</html>" >> "$output_file"