#!/bin/sh

rm -rf ./zoom*

if [ -z "$1" ]; then
  echo '画像を指定してください！'
  exit 1
fi

image_file=$1
file $image_file
# image_width=`file "$image_file" | cut -d " " -f7`
# image_height=`file "$image_file" | cut -d " " -f9`

image_width=8192
image_height=6018

is_retina=true
$is_retina && tile_size=512 || tile_size=256

# 縦と横で大きい方のサイズを image_size に代入
[ $image_width -gt $image_height ] && image_size=$image_width || image_size=$image_height

# 画像を縦横大きい方で最大何等分できるか
tile_number=$(($image_size / $tile_size))

# 最大ズームレベル値を取得する
log=`echo "l($((tile_number)))/l(2)" | bc -l`
max_zoom_level=`echo ${log} | awk '{printf("%d", $1 + 0.9)}'`

# ズームレベル単位でタイル画像を生成
zoom_level=0
while [ "$zoom_level" -le "$max_zoom_level" ]
do
  # ディレクトリを作る
  mkdir ./zoom${zoom_level}

  # マップサイズを取得する
  map_size=$(($tile_size * 2 ** $zoom_level ))

  # リサイズ
  convert -resize ${map_size}x${map_size} ${image_file} ./zoom${zoom_level}/zoom${zoom_level}.png

  # タイル化
  convert ./zoom${zoom_level}/zoom${zoom_level}.png -crop ${tile_size}x${tile_size} +gravity -set filename:tile \
  ./zoom${zoom_level}/${zoom_level}_%[fx:page.x/${tile_size}]_%[fx:page.y/${tile_size}] %[filename:tile].png

  zoom_level=$(($zoom_level + 1))
done

exit 1
