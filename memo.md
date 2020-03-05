- ImageMagick の画像 crop
https://qiita.com/yoya/items/62879e6e03d5a70eed09

- How do I crop an animated gif using ImageMagick?
https://stackoverflow.com/questions/14036765/how-do-i-crop-an-animated-gif-using-imagemagick

## zoom レベル 0

- 画像サイズ 256
- 画像枚数 1
- (0,0)(256,256)

```sh
gifsicle --resize-fit-width 256 -i 200109_new-map.gif > ./zoom0/0_0.gif
```

## zoom レベル 1

- 画像サイズ 512
- 画像枚数　 4((2^1)^2)
- 座標
  (0,0)(256,256),(256,0)(512,256)
  (0,256)(256,512),(256,256)(512,512)

```sh
# リサイズ
gifsicle --resize-fit-width 512 -i 200109_new-map.gif > ./zoom1/zoom1.gif

# タイル化
gifsicle --crop 0,0-256,256 --output ./zoom1/1_0_0.gif ./zoom1/zoom1.gif
gifsicle --crop 256,0-512,256 --output ./zoom1/1_1_0.gif ./zoom1/zoom1.gif
gifsicle --crop 0,256-256,512 --output ./zoom1/1_0_1.gif ./zoom1/zoom1.gif
gifsicle --crop 256,256-512,512 --output ./zoom1/1_1_1.gif ./zoom1/zoom1.gif
```

## zoom レベル 2

- 画像サイズ 1024
- 画像枚数　 16((2^2)^2)
- 座標
  (0,0)(256,256),(256,0)(512,256),(512,0)(768,256),(768,0)(1024,256)
  (0,256)(256,512),(256,256)(512,512),(512,256)(768,512),(768,256)(1024,512)
  (0,512)(256,768),(256,512)(512,768),(512,512)(768,768),(768,512)(1024,768)
  (0,768)(256,1024),(256,768)(512,1024),(512,768)(768,1024),(768,768)(1024,1024)

```sh
# リサイズ
gifsicle --resize-fit-width 1024 -i 200109_new-map.gif > ./zoom2/zoom2.gif

# タイル化
gifsicle --crop 0,0-256,256 --output ./zoom2/2_0_0.gif ./zoom2/zoom2.gif
gifsicle --crop 256,0-512,256 --output ./zoom2/2_1_0.gif ./zoom2/zoom2.gif
gifsicle --crop 512,0-768,256 --output ./zoom2/2_2_0.gif ./zoom2/zoom2.gif
gifsicle --crop 768,0-1024,256 --output ./zoom2/2_3_0.gif ./zoom2/zoom2.gif

gifsicle --crop 0,256-256,512 --output ./zoom2/2_0_1.gif ./zoom2/zoom2.gif
gifsicle --crop 256,256-512,512 --output ./zoom2/2_1_1.gif ./zoom2/zoom2.gif
gifsicle --crop 512,256-768,512 --output ./zoom2/2_2_1.gif ./zoom2/zoom2.gif
gifsicle --crop 768,256-1024,512 --output ./zoom2/2_3_1.gif ./zoom2/zoom2.gif

gifsicle --crop 0,512-256,768 --output ./zoom2/2_0_2.gif ./zoom2/zoom2.gif
gifsicle --crop 256,512-512,768 --output ./zoom2/2_1_2.gif ./zoom2/zoom2.gif
gifsicle --crop 512,512-768,768 --output ./zoom2/2_2_2.gif ./zoom2/zoom2.gif
gifsicle --crop 768,512-1024,768 --output ./zoom2/2_3_2.gif ./zoom2/zoom2.gif

gifsicle --crop 0,768-256,1024 --output ./zoom2/2_0_3.gif ./zoom2/zoom2.gif
gifsicle --crop 256,768-512,1024 --output ./zoom2/2_1_3.gif ./zoom2/zoom2.gif
gifsicle --crop 512,768-768,1024 --output ./zoom2/2_2_3.gif ./zoom2/zoom2.gif
gifsicle --crop 768,768-1024,1024 --output ./zoom2/2_3_3.gif ./zoom2/zoom2.gif
```

## zoom レベル 3

- 画像サイズ 2048
- 画像枚数 64((2^3)^2)
- 座標
  (0,0)(256,256),(256,0)(512,256),(512,0)(768,256),(768,0)(1024,256),(1024,0)(1280,256),(1280,0)(1536,256),(1536,0)(1792,256),(1792,0)(2048,256)
  (0,256)(256,512),(256,256)(512,512),(512,256)(768,512),(768,256)(1024,512),(1024,256)(1280,512),(1280,256)(1536,512),(1536,256)(1792,512),(1792,256)(2048,512)
  (0,512)(256,768),(256,512)(512,768),(512,512)(768,768),(768,512)(1024,768),(1024,512)(1280,768),(1280,512)(1536,768),(1536,512)(1792,768),(1792,512)(2048,768)
  (0,768)(256,1024),(256,768)(512,1024),(512,768)(768,1024),(768,768)(1024,1024),(1024,768)(1280,1024),(1280,768)(1536,1024),(1536,768)(1792,1024),(1792,768)(2048,1024)
  (0,1024)(256,1280),(256,1024)(512,1280),(512,1024)(768,1280),(768,1024)(1024,1280),(1024,1024)(1280,1280),(1280,1024)(1536,1280),(1536,1024)(1792,1280),(1792,1024)(2048,1280)
  (0,1280)(256,1536),(256,1280)(512,1536),(512,1280)(768,1536),(768,1280)(1024,1536),(1024,1280)(1280,1536),(1280,1280)(1536,1536),(1536,1280)(1792,1536),(1792,1280)(2048,1536)
  (0,1536)(256,1792),(256,1536)(512,1792),(512,1536)(768,1792),(768,1536)(1024,1792),(1024,1536)(1280,1792),(1280,1536)(1536,1792),(1536,1536)(1792,1792),(1792,1536)(2048,1792)
  (0,1792)(256,2048),(256,1792)(512,2048),(512,1792)(768,2048),(768,1792)(1024,2048),(1024,1792)(1280,2048),(1280,1792)(1536,2048),(1536,1792)(1792,2048),(1792,1792)(2048,2048)

```sh
# ディレクトリ作成
mkdir zoom3

# リサイズ
gifsicle --resize-fit-width 2048 -i 200109_new-map.gif > ./zoom3/zoom3.gif

# タイル化
gifsicle --crop 0,0-256,256 --output ./zoom3/3_0_0.gif ./zoom3/zoom3.gif
gifsicle --crop 256,0-512,256 --output ./zoom3/3_1_0.gif ./zoom3/zoom3.gif
gifsicle --crop 512,0-768,256 --output ./zoom3/3_2_0.gif ./zoom3/zoom3.gif
gifsicle --crop 768,0-1024,256 --output ./zoom3/3_3_0.gif ./zoom3/zoom3.gif
gifsicle --crop 1024,0-1280,256 --output ./zoom3/3_4_0.gif ./zoom3/zoom3.gif
gifsicle --crop 1280,0-1536,256 --output ./zoom3/3_5_0.gif ./zoom3/zoom3.gif
gifsicle --crop 1536,0-1792,256 --output ./zoom3/3_6_0.gif ./zoom3/zoom3.gif
gifsicle --crop 1792,0-2048,256 --output ./zoom3/3_7_0.gif ./zoom3/zoom3.gif

gifsicle --crop 0,256-256,512 --output ./zoom3/3_0_1.gif ./zoom3/zoom3.gif
gifsicle --crop 256,256-512,512 --output ./zoom3/3_1_1.gif ./zoom3/zoom3.gif
gifsicle --crop 512,256-768,512 --output ./zoom3/3_2_1.gif ./zoom3/zoom3.gif
gifsicle --crop 768,256-1024,512 --output ./zoom3/3_3_1.gif ./zoom3/zoom3.gif
gifsicle --crop 1024,256-1280,512 --output ./zoom3/3_4_1.gif ./zoom3/zoom3.gif
gifsicle --crop 1280,256-1536,512 --output ./zoom3/3_5_1.gif ./zoom3/zoom3.gif
gifsicle --crop 1536,256-1792,512 --output ./zoom3/3_6_1.gif ./zoom3/zoom3.gif
gifsicle --crop 1792,256-2048,512 --output ./zoom3/3_7_1.gif ./zoom3/zoom3.gif

gifsicle --crop 0,512-256,768 --output ./zoom3/3_0_2.gif ./zoom3/zoom3.gif
gifsicle --crop 256,512-512,768 --output ./zoom3/3_1_2.gif ./zoom3/zoom3.gif
gifsicle --crop 512,512-768,768 --output ./zoom3/3_2_2.gif ./zoom3/zoom3.gif
gifsicle --crop 768,512-1024,768 --output ./zoom3/3_3_2.gif ./zoom3/zoom3.gif
gifsicle --crop 1024,512-1280,768 --output ./zoom3/3_4_2.gif ./zoom3/zoom3.gif
gifsicle --crop 1280,512-1536,768 --output ./zoom3/3_5_2.gif ./zoom3/zoom3.gif
gifsicle --crop 1536,512-1792,768 --output ./zoom3/3_6_2.gif ./zoom3/zoom3.gif
gifsicle --crop 1792,512-2048,768 --output ./zoom3/3_7_2.gif ./zoom3/zoom3.gif

gifsicle --crop 0,768-256,1024 --output ./zoom3/3_0_3.gif ./zoom3/zoom3.gif
gifsicle --crop 256,768-512,1024 --output ./zoom3/3_1_3.gif ./zoom3/zoom3.gif
gifsicle --crop 512,768-768,1024 --output ./zoom3/3_2_3.gif ./zoom3/zoom3.gif
gifsicle --crop 768,768-1024,1024 --output ./zoom3/3_3_3.gif ./zoom3/zoom3.gif
gifsicle --crop 1024,768-1280,1024 --output ./zoom3/3_4_3.gif ./zoom3/zoom3.gif
gifsicle --crop 1280,768-1536,1024 --output ./zoom3/3_5_3.gif ./zoom3/zoom3.gif
gifsicle --crop 1536,768-1792,1024 --output ./zoom3/3_6_3.gif ./zoom3/zoom3.gif
gifsicle --crop 1792,768-2048,1024 --output ./zoom3/3_7_3.gif ./zoom3/zoom3.gif

gifsicle --crop 0,1024-256,1280 --output ./zoom3/3_0_4.gif ./zoom3/zoom3.gif
gifsicle --crop 256,1024-512,1280 --output ./zoom3/3_1_4.gif ./zoom3/zoom3.gif
gifsicle --crop 512,1024-768,1280 --output ./zoom3/3_2_4.gif ./zoom3/zoom3.gif
gifsicle --crop 768,1024-1024,1280 --output ./zoom3/3_3_4.gif ./zoom3/zoom3.gif
gifsicle --crop 1024,1024-1280,1280 --output ./zoom3/3_4_4.gif ./zoom3/zoom3.gif
gifsicle --crop 1280,1024-1536,1280 --output ./zoom3/3_5_4.gif ./zoom3/zoom3.gif
gifsicle --crop 1536,1024-1792,1280 --output ./zoom3/3_6_4.gif ./zoom3/zoom3.gif
gifsicle --crop 1792,1024-2048,1280 --output ./zoom3/3_7_4.gif ./zoom3/zoom3.gif

gifsicle --crop 0,1280-256,1536 --output ./zoom3/3_0_5.gif ./zoom3/zoom3.gif
gifsicle --crop 256,1280-512,1536 --output ./zoom3/3_1_5.gif ./zoom3/zoom3.gif
gifsicle --crop 512,1280-768,1536 --output ./zoom3/3_2_5.gif ./zoom3/zoom3.gif
gifsicle --crop 768,1280-1024,1536 --output ./zoom3/3_3_5.gif ./zoom3/zoom3.gif
gifsicle --crop 1024,1280-1280,1536 --output ./zoom3/3_4_5.gif ./zoom3/zoom3.gif
gifsicle --crop 1280,1280-1536,1536 --output ./zoom3/3_5_5.gif ./zoom3/zoom3.gif
gifsicle --crop 1536,1280-1792,1536 --output ./zoom3/3_6_5.gif ./zoom3/zoom3.gif
gifsicle --crop 1792,1280-2048,1536 --output ./zoom3/3_7_5.gif ./zoom3/zoom3.gif

gifsicle --crop 0,1536-256,1792 --output ./zoom3/3_0_6.gif ./zoom3/zoom3.gif
gifsicle --crop 256,1536-512,1792 --output ./zoom3/3_1_6.gif ./zoom3/zoom3.gif
gifsicle --crop 512,1536-768,1792 --output ./zoom3/3_2_6.gif ./zoom3/zoom3.gif
gifsicle --crop 768,1536-1024,1792 --output ./zoom3/3_3_6.gif ./zoom3/zoom3.gif
gifsicle --crop 1024,1536-1280,1792 --output ./zoom3/3_4_6.gif ./zoom3/zoom3.gif
gifsicle --crop 1280,1536-1536,1792 --output ./zoom3/3_5_6.gif ./zoom3/zoom3.gif
gifsicle --crop 1536,1536-1792,1792 --output ./zoom3/3_6_6.gif ./zoom3/zoom3.gif
gifsicle --crop 1792,1536-2048,1792 --output ./zoom3/3_7_6.gif ./zoom3/zoom3.gif

gifsicle --crop 0,1792-256,2048 --output ./zoom3/3_0_7.gif ./zoom3/zoom3.gif
gifsicle --crop 256,1792-512,2048 --output ./zoom3/3_1_7.gif ./zoom3/zoom3.gif
gifsicle --crop 512,1792-768,2048 --output ./zoom3/3_2_7.gif ./zoom3/zoom3.gif
gifsicle --crop 768,1792-102420482 --output ./zoom3/3_376.gif ./zoom3/zoom3.gif
gifsicle --crop 1024,1792-128020482 --output ./zoom3/3_476.gif ./zoom3/zoom3.gif
gifsicle --crop 1280,1792-153620482 --output ./zoom3/3_576.gif ./zoom3/zoom3.gif
gifsicle --crop 1536,1792-179220482 --output ./zoom3/3_676.gif ./zoom3/zoom3.gif
gifsicle --crop 1792,1792-204820482 --output ./zoom3/3_776.gif ./zoom3/zoom3.gif
```
