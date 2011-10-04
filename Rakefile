require 'rake'
require 'erb'

$replace_all = false

task :default => :install

desc "Install all the dot files into the current user's home directory."
task :install do
  Dir['*'].each do |file|
    next if %w[Rakefile README.md LICENSE].include? file
    process_file file
  end
end

def process_file(file)
  target_file = File.join ENV['HOME'], ".#{file.sub('.erb', '')}"
  if File.exist? target_file
    if File.identical? file, target_file
      puts "Files #{file} and #{target_file} are identical."
    elsif $replace_all
      replace_file file, target_file
    else
      print "Overwrite #{target_file}? [ynaq] "
      case $stdin.gets.chomp
      when 'a'
        $replace_all = true
        replace_file file, target_file
      when 'y'
        replace_file file, target_file
      when 'q'
        exit
      else
        puts "Skipping #{target_file}"
      end
    end
  else
    create_file file, target_file
  end
end

def replace_file(source, target)
  system %Q{rm -rf "#{target}"}
  create_file source, target
end

def create_file(source, target)
  if source =~ /.erb$/
    puts "Generating #{target}"
    File.open File.join(target), 'w' do |new_file|
      new_file.write ERB.new(File.read(source)).result(binding)
    end
  else
    puts "Creating #{target}"
    system %Q{cp -r "$PWD/#{source}" "#{target}"}
  end
end
