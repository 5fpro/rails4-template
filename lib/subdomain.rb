class Subdomain
  def self.matches?(request)
    request.host && request.host == "localhost"? false : true
  end
end