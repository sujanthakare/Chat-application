require "socket"

class Client
	def initialize(server)
		@server = server
		send
		listen
		@request
		@response 	

		@request.join
		@response.join
	end

	def send()
		@request = Thread.new  do
			loop { 

					msg = $stdin.gets.chomp
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
Client.new( server )
