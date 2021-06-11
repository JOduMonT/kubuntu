mkdir -p ~/.local/share/fonts

for file in Sans Serif
do
wget -O /tmp/Noto$file.zip https://fonts.google.com/download?family=Noto%20$file
unzip -o /tmp/Noto$file.zip -d /tmp
done

for file in ColorEmoji Emoji
do
wget -O /tmp/Noto$file.zip https://noto-website-2.storage.googleapis.com/pkgs/Noto$file-unhinted.zip
unzip -o /tmp/Noto$file.zip -d /tmp
done

mv /tmp/Noto*.ttf ~/.local/share/fonts/

fc-cache -fv
