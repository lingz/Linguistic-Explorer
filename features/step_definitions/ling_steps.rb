Given /^the following lings:$/ do |table|
  table.hashes.each do |attrs|
    Ling.find_by_name(attrs['name']) || Factory(:ling, attrs)
  end
end

Given /^the following lings and properties:$/ do |table|
  table.hashes.each do |attrs|
    ling = Ling.find_by_name_and_depth(attrs['name'], attrs['depth'].to_i) || Factory(:ling, :name => attrs['name'], :depth => attrs['depth'].to_i)

    prop_attrs = {}.tap do |opts|
      opts[:name]      = attrs['property_name']      unless attrs['property_name'].blank?
      opts[:category]  = attrs['property_category']  unless attrs['property_category'].blank?
      opts[:depth]     = attrs['depth'].to_i         unless attrs['depth'].blank?
    end

    prop = Property.find_by_name(prop_attrs[:name]) || Factory(:property, prop_attrs)
    ling.add_property(attrs['property_value'], prop)
  end
end
