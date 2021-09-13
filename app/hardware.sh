# CPU (Version, Model, BogoMIPS)
lscpu|grep 'Byte\|name\|Bogo'

# RAM (Size, Type, Speed)
dmidecode --type 17|grep 'Type\|Speed\|Size'
