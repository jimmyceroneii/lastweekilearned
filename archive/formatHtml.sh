sed -i "" '1s|^|<html>\n<head>\n<title>'"$2"'<\/title>\n<meta charset="utf-8">\n<link type="text/css" rel="stylesheet" href="style.css">\n<\/head>\n<body>\n|' "$1"
echo "</body>\n</html>" >> "$1"