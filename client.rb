require "socket"

class client
	def initialize(server)
		@server = server
		send
		listen
		@request = nil
		@response = nil	
		
		@request.join
		@response.join
	end

	def send()
		@request = Thread.new  do
			loop { 

					msg = gets.chomp
					@server.puts( msg )
			 }
		end
		
	end
	def listen
		@response = Thread.new do
			loop { 
					msg  = @server.gets.chomp
					puts "#{msg}"
			 }	
		end
	end
end


server = TCPSocket.open ARGV[0], ARGV[1]
client.new( server )
