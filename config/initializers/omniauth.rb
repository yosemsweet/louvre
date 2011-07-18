Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :facebook, '178863089564', '5df447b8480c97b38307cae54e1627c0'  
  provider :twitter, 'FSTx5kL5Ni9bl6sClZf5Pw', '0BWf0FCBXpgduFevvOhbjMrvMsTbRk4AUpMnhMlqU'  
end