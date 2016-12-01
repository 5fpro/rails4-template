module ApiHelper

  def parse_response
    JSON.parse(response.body)
  end

  def api_params(params, header = {})
    {
      params: params,
      headers: header.merge({ 'HTTP_X_TOKEN' => '123456' })
    }
  end

end
