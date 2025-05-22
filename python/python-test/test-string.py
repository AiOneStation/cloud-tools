import re

stripped_line = "## 1.1 example text"
# pattern = r'^[#\*]+\d'
# pattern = r'^[#\*]+\s*\d'
pattern = r'^[#\*]+\s*\d(?!.*\..*\..*)'


if re.search(pattern, stripped_line):
    print("Match found")
else:
    print("No match")
