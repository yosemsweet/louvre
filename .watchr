ENV["WATCHR"] = "1"
system 'clear'

def growl(message)
  #growlnotify = `which growlnotify`.chomp
  title = "Watchr Test Results"
  options = "-w -n Watchr -m '#{message}' '#{title}'"
  system "growlnotify #{options}"
end

def run(cmd)
  puts(cmd)
  `#{cmd}`
end

def run_spec_file(file)
  system('clear')
  result = run "rake spec SPEC=#{file})"
  growl result.split("\n").last rescue nil
  puts result
end

def run_all_specs
  system('clear')
  result = run "rake spec"
  growl result.split("\n").last rescue nil
  puts result
end

def run_all_features
  system('clear')
  result = run "rake cucumber"
  results = result.split("\n")
  
  growl results[results.length - 3 .. results.length].join("\n") rescue nil
  puts result
end

def related_spec_files(path)
  Dir['spec/**/*.rb'].select { |file| file =~ /#{File.basename(path).split(".").first}_spec.rb/ }
end

def run_suite
  run_all_specs
  run_all_features
end

watch('spec/spec_helper\.rb') { run_all_specs }
watch('spec/.*/.*_spec\.rb') { |m| run_spec_file(m[0]) }
watch('app/.*/.*\.rb') { |m| related_spec_files(m[0]).map {|tf| run_spec_file(tf) } }
watch('features/(.*)') { run_all_features }
watch('features/(.*)/(.*)') { run_all_features}

# Ctrl-\
Signal.trap 'QUIT' do
  puts " --- Running all specs ---\n\n"
  run_all_specs
end

@interrupted = false

# Ctrl-C
Signal.trap 'INT' do
  if @interrupted then
    @wants_to_quit = true
    abort("\n")
  else
    puts "Interrupt a second time to quit"
    @interrupted = true
    Kernel.sleep 1.5
    # raise Interrupt, nil # let the run loop catch it
    run_suite
  end
end