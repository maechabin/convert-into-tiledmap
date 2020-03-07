#!/bin/bash

rm -rf ./tiles
mkdir ./tiles

if [ -z "$1" ]; then
  echo '画像を指定してください！'
  exit 1
fi

image_file=$1
# 画像ファイルの拡張子
image_extension=`echo basename $image_file |  sed 's/^.*\.\([^\.]*\)$/\1/'`
# 画像ファイルの縦、横サイズ
[ $2 ] && image_width=$2 || image_width=`convert $image_file[0] -format '%h' info:`
[ $3 ] && image_height=$3 || image_height=`convert $image_file[0] -format '%w' info:`

is_retina=false
$is_retina && readonly TILE_SIZE=512 || readonly TILE_SIZE=256

# 縦と横で大きい方のサイズを image_size に代入
[ $image_width -gt $image_height ] && image_size=$image_width || image_size=$image_height

# 画像を縦横大きい方で最大何等分できるか
tile_number=$(($image_size / $TILE_SIZE))

# 最大ズームレベル値を取得する
log=`echo "l($((tile_number)))/l(2)" | bc -l`
max_zoom_level=`echo ${log} | awk '{printf("%d", $1 + 0.9)}'`

# ズームレベル単位でタイル画像を生成
zoom_level=0
while [ "$zoom_level" -le "$max_zoom_level" ]
do
  # マップサイズを取得する
  map_size=$(($TILE_SIZE * 2 ** $zoom_level ))

  # リサイズ
  convert -resize ${map_size}x${map_size}  -quality 100 ${image_file} ./tiles/zoom${zoom_level}.${image_extension}

  # タイル化
  convert ./tiles/zoom${zoom_level}.${image_extension} -crop ${TILE_SIZE}x${TILE_SIZE} -quality 95 +gravity -set filename:tile \
    ./tiles/${zoom_level}_%[fx:page.x/${TILE_SIZE}]_%[fx:page.y/${TILE_SIZE}] %[filename:tile].${image_extension}

  rm ./tiles/zoom${zoom_level}.${image_extension}
  zoom_level=$(($zoom_level + 1))
done
