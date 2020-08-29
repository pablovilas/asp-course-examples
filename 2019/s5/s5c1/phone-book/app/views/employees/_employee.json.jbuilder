json.extract! employee, :id, :company_id, :last_name, :first_name, :phone_number, :created_at, :updated_at
json.url employee_url(employee, format: :json)
