json.sites do
  json.array! @sites do |site|
    json.call(site, :id, :name, :host)
  end
end
