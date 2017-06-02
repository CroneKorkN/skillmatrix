# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[
  "infra2",
  "python",
  "bash",
  "systemd"
].each do |skillname|
  Skill.create name: skillname
end

[
  "mwiegand",
  "mreinhardt",
  "cengelmann",
  "phofman",
  "tpenndorf",
  "trehn",
  "nkhoushaba"
].each do |username|
  User.create name: username
end
