# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# Example:
#
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

['juan', 'andrea', 'leon', 'andres', 'natalia', 'camilo', 'rusbel', 'johan'].each do |name|
  User.create email: "#{name}@platzi.com", password: 'njnjnjnj'
end

puts 'Users have been created'

['desarrollo', 'mercadeo', 'conceptualización', 'ejercicios'].each do |name|
  Category.create name: name, description: '--'
end

puts 'Categories has been created'

base = [
  [
    'conceptualización',
    'Bienvenida ',
    ['johan:1', 'leon:2', 'andrea:random']
  ],
  [
    'conceptualización',
    '¿Qué es ruby on rails y por qué usarlo?',
    ['johan:1', 'leon:2', 'andrea:random']
  ],
  [
    'conceptualización',
    'Entorno de desarrollo de RoR',
    ['johan:1', 'leon:2', 'andrea:random']
  ],
  [
    'ejercicios',
    'Instalación de Ruby, RoR en windows y Linux',
    ['johan:1', 'leon:2', 'andrea:random']
  ]
]

owner = User.find_by(email: 'johan@platzi.com')

base.each do |category, description, participant_set|
  participants = participant_set.map do |participant|
    user_name, raw_role = participant.split(':')
    role = raw_role == 'random' ? [1, 2].sample : raw_role

    Participant.new(
      user: User.find_by(email: "#{user_name}@platzi.com"),
      role: role
    )
  end

  Task.create!(
    category: Category.find_by(name: category),
    owner: owner,
    participating_users: participants,
    name: "Tarea ##{Task.count+1}",
    description: description,
    due_date: Date.today + 15.days
  )
end

puts 'Tasks has been created'
