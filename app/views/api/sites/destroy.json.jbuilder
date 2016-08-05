if @status == 200
  json.set! :status, '200'
  json.set! :message, 'success'
else
  json.set! :status, '400'
  json.set! :message, 'fail'
end