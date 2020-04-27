# frozen_string_literal: true

user = User.create(
  username: 'lanh',
  password: 'Abcd1234',
  password_confirmation: 'Abcd1234'
)

user.movies.create(url: 'https://www.youtube.com/watch?v=LdOM0x0XDMo')
user.movies.create(url: 'https://www.youtube.com/watch?v=T7O7BtBnsG4')
user.movies.create(url: 'https://www.youtube.com/watch?v=zSWdZVtXT7E')
