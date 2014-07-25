# Canvas::Resize::Rails

canvasResize(https://github.com/gokercebeci/canvasResize)をRails+carrierwaveで簡単に使えるようにする

## インストール

Gemファイルに以下を追加

```ruby
gem 'canvas-resize-rails'
```

application.jsに以下を追加

```javascript
//= require canvas-resize-sprockets
```

## 使い方

carrierwaveのmodelをProfile, 対象のカラム名をimageとする場合、対象のmodelに以下のように設定

```ruby
  mount_uploader :image, ImageUploader
  canvas_resize :image
```

formで例えば以下のようになっている場合、

```haml
= simple_form_for(@profile) do |f|
  = f.input :image, as: :file, input_html: { class: 'resize_trigger' }
```

jsで以下のようにする。

```coffee
$("input.resize_trigger").prepareToResizeForAll()
```

これでファイルに画像を設定するタイミングで自動的に以下の処理が行われる
* profile[image_base64]というhidden_fieldにbase64でエンコードされた画像が設定される
* profile[image_file_name]というhidden_fieldにファイル名が設定される

この状態でsubmitするとリサイズ済みのファイルがcarrierwaveを通じて保存される
