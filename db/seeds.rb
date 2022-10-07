User.destroy_all 

User.create!(name: 'common', email: 'common@email.com', password: '1234567')
User.create!(name: 'admin', email: 'admin@email.com', password: '1234567', role: :admin)
