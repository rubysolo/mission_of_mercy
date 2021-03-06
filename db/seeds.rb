require_relative 'seeds/users'
require 'highline'

# Custom Settings

console = HighLine.new

if User.count.zero?

  password = console.ask("Default password for all user accounts") do |q|
    q.default = "temp123"
  end
  total_xray_stations = console.ask("Number of X-Ray Stations", Integer) do |q|
    q.default = 5
  end

  Seeds.create_users(:password => password, :xray_stations => total_xray_stations)

  puts "#{User.count} users created"
  puts "Passwords have been set to #{password.bright}".color(:red)
else
  puts "Skip: #{User.count} users already exist"
end

if Treatment.count.zero?
  treatments = [ { :name => "Filling" },
                 { :name => "Cleaning" },
                 { :name => "Extraction" } ]

  treatments.each do |treatment|
    Treatment.create(treatment)
  end
end

if TreatmentArea.count.zero?

  areas = [ { :name => "Radiology",   :capacity => 50 },
            { :name => "Hygiene",     :capacity => 50 },
            { :name => "Restoration", :capacity => 50,
                :amalgam_composite_procedures => true },
            { :name => "Pediatrics",  :capacity => 50 },
            { :name => "Endodontics", :capacity => 50 },
            { :name => "Surgery",     :capacity => 50 },
            { :name => "Prosthetics", :capacity => 15 } ]

  areas.each do |area|
    TreatmentArea.create(area)
  end

  puts "#{TreatmentArea.count} treatment areas created"
else
  puts "Skip: #{TreatmentArea.count} treatment areas already exist"
end