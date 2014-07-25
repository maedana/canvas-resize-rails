$ ->
  jQuery.fn.extend
    prepareToResizeForAll: ->
      isImageFile = (file) ->
        return (/image/i).test(file.type)

      processFile = (file, base64FieldName, fileNameFieldName, form) ->
        # Ref) http://lealog.hateblo.jp/entry/2013/03/21/212608
        # TODO 外からoptionを渡せるようにする
        $.canvasResize file,
          width: 800
          height: 0
          crop: false
          quality: 80
          callback: (data, width, height) ->
            resizedData     = "<input type='hidden' name='#{base64FieldName}' value='#{data}'>"
            resizedFileName = "<input type='hidden' name='#{fileNameFieldName}' value='#{file.name}'>"
            $(form).append(resizedData)
            $(form).append(resizedFileName)

      $(this).change (e) ->
        unless window.File and window.FileReader and window.FileList and window.Blob
          console.log "The File APIs are not fully supported in this browser."
          return false

        modelName = $(this).attr('id').split('_')[0]
        columnName = $(this).attr('id').split('_')[1]
        fileField = e.target
        form = $(fileField).closest('form')[0]

        # ファイル再選択時に不要なhiddenを削除
        $(form).find("input[name*=#{columnName}_base64\\]]").remove()
        $(form).find("input[name*=#{columnName}_file_name\\]]").remove()

        file = fileField.files[0]
        if isImageFile(file)
          base64FieldName   = "#{modelName}[#{columnName}_base64]"
          fileNameFieldName = "#{modelName}[#{columnName}_file_name]"
          processFile file, base64FieldName, fileNameFieldName, form

