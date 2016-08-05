if @status == 200
  json.set! :status, '200'
  json.set! :site, @site
else
  json.set! :status, '400'
  json.set! :message, @site.errors.full_messages
end