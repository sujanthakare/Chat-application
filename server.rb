require "socket"

class Server
	def initialize(port,ip)
		@server = TCPServer.open(ip,port)

		@connections = Hash.new
		@name = Hash.new
		@clients = Hash.new


		@connections[:name] = @name
		@connections[:client] = @clients

		run
	end

	def run
		#puts "you are in run"

		puts "server started ready to accept client connections"

		loop { 

				Thread.start(@server.accept) do |client|
					client.puts "Enter Username"
					username = client.gets.chomp
					@connections[:client].each do |other_name, other_client|
						if username == other_name || client == other_client
							client.puts "username already exists"
							client.puts "try connecting again with another username"
							client.close		
						end
					end
					@connections[:client][username] = client 
					puts "#{username} connected at #{Time.now}"
					client.puts	 "welcome #{username} you are ready to chat"
					client.puts  "type 'exit' to leave "
					available_user(client)

					broadcast_to_all(username,client)
			end
		 
		 }
	end

	def available_user(client)
		
			client.puts "Users available"
			@connections[:client].each do |other_name, other_client|
			client.puts "#{other_name}"  						
		end
	end

		
	def broadcast_to_all(username,client)

	
		#puts "you are in broadcast_to_all method"

		loop {

				msg = client.gets.chomp
				if msg.to_s == "exit"
					client.close
					break
				end
		      
      	@connections[:client].each do |other_name, other_client|
        
	        unless other_name == username || client == other_client 
	 	         puts "#{username.to_s}: #{msg}"	
	    	     other_client.puts "#{username.to_s}: #{msg}"
	        end
	    	
    	end
	}
			
	end

end

Server.new ARGV[0] , ARGV[1]