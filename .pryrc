begin
  require 'awesome_print'
  Pry.config.print = proc { |output, value| output.puts value.ai }
rescue LoadError => err
  puts "no awesome_print :("
end

begin
  require 'hirb'
  extend Hirb::Console
rescue LoadError => err
  puts "no Hirb :("
end

