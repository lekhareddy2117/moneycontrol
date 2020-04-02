json.extract! stock, :id, :date, :open, :close, :high, :low, :volume, :value, :company_id, :created_at, :updated_at
json.url stock_url(stock, format: :json)
