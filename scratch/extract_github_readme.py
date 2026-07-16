import re
from bs4 import BeautifulSoup

path = r"C:\Users\XU RONG\.gemini\antigravity-cli\brain\3bd9b2dd-3212-4e41-92cc-de515024204c\.system_generated\steps\110\content.md"
with open(path, "r", encoding="utf-8") as f:
    html = f.read()

soup = BeautifulSoup(html, "html.parser")
article = soup.find("article")

with open("readme_content.txt", "w", encoding="utf-8") as out:
    if article:
        out.write(article.get_text())
    else:
        out.write("No <article> tag found in HTML. Let's dump all text or first 2000 chars.\n")
        out.write(soup.get_text()[:5000])

print("Readme extraction complete!")
