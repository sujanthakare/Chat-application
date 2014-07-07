Chat-application using Ruby
===========================

Clone the application to your computer

it contains two files server.rb and client.rb
open terminal and nevigate to the directory where they are located

first create a server as follows

		ruby server.rb 3000 "localhost"
  
it will create a server at port 3000 and ip "localhost" 
it will wait for the clients to be connected 

open another window of terminal and initialize clients as follows
		
		ruby client.rb "localhost" 3000

or you can connect by telnet command

		telnet "localhost" 3000

similarly you can initialize multiple clients by opening multiple windows
