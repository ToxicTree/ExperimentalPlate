###
Testing Web SQL Database
###

# Config
db_file = 'mydb.db'

# Handlers
errorHandler = (transaction, error) ->
    console.log "Error: #{error.message} (Code #{error.code})"
    #transaction.executeSql 'INSERT INTO errors (code, message) VALUES (?, ?);', [error.code, error.message]
    return false
successHandler = (msg) ->
    console.log msg
    document.body.innerHTML += "<p>#{msg}</p>"

# Open database
db = openDatabase db_file, '1.0', 'description', 1

# Insert something into log
db.transaction (tx) ->
    tx.executeSql 'CREATE TABLE IF NOT EXISTS LOGS (id unique, log)', errorHandler
    tx.executeSql 'INSERT INTO LOGS (id, log) VALUES (1, "foobar")', errorHandler
    tx.executeSql 'INSERT INTO LOGS (id, log) VALUES (2, "logmsg")', errorHandler
    successHandler "2 rows inserted."

# Select from log
db.transaction (tx) ->
    tx.executeSql 'SELECT * FROM LOGS', [], (tx, results) ->
        len = results.rows.length
        successHandler "Found #{len} rows"

        for i in [0...len]
            successHandler results.rows.item(i).log

    , errorHandler

# Done
