class Greeting
  def greet(@name : String)
    puts "Hello #{@name}!"
  end
end

g = Greeting.new()
g.greet("World")
