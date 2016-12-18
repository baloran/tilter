require 'rails_helper'

RSpec.describe 'Routes', type: :routing do
  it 'handles tweets routes properly' do
    expect(get: '/').to route_to(controller: 'tweets', action: 'index')
    expect(get: '/tilts').to route_to(controller: 'tweets', action: 'index')

    expect(get: '/tilts/1').to route_to(
      controller: 'tweets',
      action: 'show',
      id: '1'
    )
  end

  it 'handles custom users routes properly' do
    expect(get: '/settings').to route_to(
      controller: 'users',
      action: 'settings'
    )

    expect(get: '/users/1').to route_to(
      controller: 'users',
      action: 'show',
      id: '1'
    )

    expect(get: '/users/1/following').to route_to(
      controller: 'users',
      action: 'following',
      user_id: '1'
    )

    expect(get: '/users/1/followers').to route_to(
      controller: 'users',
      action: 'followers',
      user_id: '1'
    )

    expect(get: '/users/1/likes').to route_to(
      controller: 'users',
      action: 'likes',
      user_id: '1'
    )
  end
end
