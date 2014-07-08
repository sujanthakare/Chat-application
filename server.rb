require "socket"

class Server
	def initialize(port,ip)
		@server = TCPServer.open(ip,port)

		@connections = Hash.new

		run
	end

	def run
		#puts "you are in run"

		puts "\t\tserver started ready to accept client connections"

		loop { 

				Thread.start(@server.accept) do |client|
					client.puts "\tEnter Username"
					username = client.gets.chomp
					@connections.each do |other_name, other_client|
						if username == other_name || client == other_client
							client.puts "username already exists"
							client.puts "try connecting again with another username"
							client.close		
						end
					end
					@connections[username] = client 
					puts "\t\t#{username} connected at #{Time.now}"
					client.puts	 "\t\ welcome #{username} you are ready to chat"
					client.puts  "\t\t type 'exit' to leave "
					available_user(client)

					broadcast_to_all(username,client)
			end
		 
		 }
	end

	def available_user(client)
		
			client.puts "Users available"
			@connections.each do |other_name, other_client|
			client.puts "\t#{other_name}"  						
		end
	end

		
	def broadcast_to_all(username,client)

	
		#puts "you are in broadcast_to_all method"

		loop {

				msg = client.gets.chomp
				if msg.to_s == "exit"
					client.close
					puts "#{username} leaved at #{Time.now}"
					break
				end
		      
      	@connections.each do |other_name, other_client|
        
	        unless other_name == username || client == other_client 
	 	         puts "\t#{username.to_s}: #{msg}"	
	    	     other_client.puts "\t#{username.to_s}: #{msg}"
	        end
	    	
    	end
	}
			
	end

end

Server.new ARGV[0] , ARGV[1]