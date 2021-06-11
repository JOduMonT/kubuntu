mkdir -p ~/.local/share/fonts

for file in Code Mono Sans
do
wget -O /tmp/Fira$file.zip https://fonts.google.com/download?family=Fira%20$file
unzip -o /tmp/Fira$file.zip -d /tmp
done

mv /tmp/Fira*.ttf ~/.local/share/fonts/

fc-cache -fv
