task :update_group_memberships => :environment do
  Group.all.each do |group|
    group.update_memberships
  end
end
