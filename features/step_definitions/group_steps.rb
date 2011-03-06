Given /^the group "([^\"]*)"$/ do |name|
  @group = Group.find_by_name(name) || Factory(:group, :name => name)
end

Given /^the group "([^\"]*)" with the following ling names:$/ do |name, table|
  Given "the group \"Syntactic Structures\""
  table.hashes.each do |attrs|
    @group.ling0_name = attrs["ling0_name"]
    @group.ling1_name = attrs["ling1_name"]
    @group.save!
  end
end