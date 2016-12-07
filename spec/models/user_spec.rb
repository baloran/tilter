RSpec.describe 'User', type: :model do
  it 'create an user' do
    baloran = User.create(
      username: 'baloran',
      password: 'password',
      email: 'baloranandco@gmail.com'
    )

    expect(baloran.email).to eq('baloranandco@gmail.com')
  end
end
