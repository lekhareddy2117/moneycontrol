Rack::Attack.throttle("requests by ip", limit: 5, period: 24.hour) do |request|
   
    Rack::Attack.throttled_response = lambda do |env|
        now = Time.now
        match_data = env['rack.attack.match_data']
      
        headers = {
          'X-RateLimit-Limit' => match_data[:limit].to_s,
          'X-RateLimit-Remaining' => '0',
          'X-RateLimit-Reset' => (Time.now+1.day).to_s
        }
      
        [ 429, headers, ["Limit Exceeded\nTry after ",headers['X-RateLimit-Reset']]]
      end
    
      request.ip if request.path == '/api/v1/companies' 
    
  end