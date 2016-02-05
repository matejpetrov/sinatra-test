require 'sinatra'


class SinatraApp < Sinatra::Base
	configure do	  
	  enable :static
	end

	get '/' do
	  send_file 'index.html'
	end

	get '/gallery' do
		send_file 'gallery.html'
	end

	get '/another' do
	  puts "Hello, world!"
	  File.read('another.html')
	end

end