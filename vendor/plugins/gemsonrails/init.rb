gems = Dir[File.join(RAILS_ROOT, "vendor/gems/*")]
if gems.any?
  gems.sort.each do |dir|
    lib = File.join(dir, 'lib')
    $LOAD_PATH.unshift(lib) if File.directory?(lib)
    init_rb = File.join(dir, 'init.rb')
    require init_rb if File.file?(init_rb)
  end
end