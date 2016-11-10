###
Testing HTML5 File API
Maybe to select a database located on a filesystem later
###


# Check for the various File API support.
if (window.File && window.FileReader && window.FileList && window.Blob)
    console.log 'All the File APIs are supported.'
else
    return console.error 'No File API'

handleFile = (file) ->
    reader = new FileReader()

    reader.onload = (e) ->
        span = document.createElement('span')

        span.innerHTML = "#{file.name} loaded..."

        document.getElementById('dropZone').insertBefore(span, null);

    reader.readAsDataURL(file)
    console.log file

handleFileSelect = (evt) ->
    evt.stopPropagation()
    evt.preventDefault()

    # Get FileList from drop or input
    files = if evt.dataTransfer then evt.dataTransfer.files else evt.target.files

    for file in files
        handleFile file

handleDragOver = (evt) ->
    evt.stopPropagation()
    evt.preventDefault()
    evt.dataTransfer.dropEffect = 'copy'

# Append some HTML
document.body.innerHTML +=
    "
    <div id='dropZone'>
        <input type='file' id='files' name='files[]' multiple/>
    </div>
    "

# Setup the listeners.
dropZone = document.getElementById('dropZone')
dropZone.addEventListener('dragover', handleDragOver, false)
dropZone.addEventListener('drop', handleFileSelect, false)
fileInput = document.getElementById('files')
fileInput.addEventListener('change', handleFileSelect, false)
