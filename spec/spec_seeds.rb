RSpec.describe do
  User.create(name: 'user1')
  Type.create(amount_type: 'Tests')
  Tracktion.create(author_id: 1, name: 'Track1', amount: 23, type_id: 1) if Tracktion.all.empty?
  Group.create(name: 'Group1', icon: 'Icon1') if Group.all.empty?
end
