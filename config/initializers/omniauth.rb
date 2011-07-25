Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    provider :facebook, '141901352559841', '8f146b3b2120f3d416148eecedce0e27' , :scope => "email"
    provider :twitter, 'FSTx5kL5Ni9bl6sClZf5Pw', '0BWf0FCBXpgduFevvOhbjMrvMsTbRk4AUpMnhMlqU'
  elsif Rails.env.development? || Rails.env.test? 
    provider :facebook, '196297497094752', 'f2b1ddb79af75dbd498752f37fddc013' , :scope => "email"  
  end
end