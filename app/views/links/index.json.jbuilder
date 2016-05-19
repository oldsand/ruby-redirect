json.array!(@links) do |link|
  json.extract! link, :id, :original_url, :short_url
  json.url link_url(link, format: :json)
end
