mkdir -p ~/.local/share/fonts

for file in Sans Serif
do
wget -O /tmp/Noto$file.zip https://fonts.google.com/download?family=Noto%20$file
unzip -o /tmp/Noto$file.zip -d /tmp
done

mv /tmp/Noto*.ttf ~/.local/share/fonts/

fc-cache -fv
