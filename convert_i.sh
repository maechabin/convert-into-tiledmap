#!/bin/sh

rm -rf ./tiles

if [ -z "$1" ]; then
  echo '画像を指定してください！'
  exit 1
fi

image_file=$1
# 画像ファイルの拡張子
image_extension=`echo basename $image_file |  sed 's/^.*\.\([^\.]*\)$/\1/'`
# 画像ファイルの縦、横サイズ
image_width=`convert $image_file[0] -format '%h' info:`
image_height=`convert $image_file[0] -format '%w' info:`

is_retina=false
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
  mkdir ./tiles

  # マップサイズを取得する
  map_size=$(($tile_size * 2 ** $zoom_level ))

  # リサイズ
  convert -resize ${map_size}x${map_size}  -quality 100 ${image_file} ./tiles/zoom${zoom_level}.${image_extension}

  # タイル化
  convert ./tiles/zoom${zoom_level}.${image_extension} -crop ${tile_size}x${tile_size} -quality 95 +gravity -set filename:tile \
  ./tiles/${zoom_level}_%[fx:page.x/${tile_size}]_%[fx:page.y/${tile_size}] %[filename:tile].${image_extension}

  zoom_level=$(($zoom_level + 1))
done
