#!/bin/bash

rm -rf ./tiles
mkdir ./tiles

if [ -z "$1" ]; then
  echo '画像を指定してください！'
  exit 1
fi

image_file=$1
image_width=`file "$image_file" | cut -d " " -f7`
image_height=`file "$image_file" | cut -d " " -f9`

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
  # マップサイズを取得する
  map_size=$(($tile_size * 2 ** $zoom_level ))

  # リサイズ
  gifsicle --resize-fit-width ${map_size} -i ${image_file} > ./tiles/zoom${zoom_level}.gif

  # 最大行数
  max_row=$((2 ** $zoom_level))
  # 行数
  row=0

  # タイル化
  while [ "$row" -lt "$max_row" ]
  do
    # 最大列数
    max_column=$((2 ** $zoom_level))
    # 列数
    column=0

    while [ "$column" -lt "$max_column" ]
    do
      x=$column
      y=$row
      x1=$(($x * $tile_size))
      y1=$(($y * $tile_size))
      x2=$(($x1 + $tile_size))
      y2=$(($y1 + $tile_size))
      gifsicle --crop ${x1},${y1}-${x2},${y2} --output ./tiles/${zoom_level}_${x}_${y}.gif ./tiles/zoom${zoom_level}.gif

      column=$(($column + 1))
    done

    row=$(($row + 1))
  done

  zoom_level=$(($zoom_level + 1))
done
