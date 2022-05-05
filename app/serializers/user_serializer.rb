class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :email

  attribute :created_date do Time.now
  end
end
