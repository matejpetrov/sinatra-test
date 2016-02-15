require 'sinatra'
require 'net/smtp'
require 'yaml'

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

	post '/sendmail' do
		Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
		name = params["name"]
		email_from = params["email"]
		message = params["message"]

		full_message = "D-Custom visitor #{name}, with #{email_from} as email address, sends this message \n\n #{message}"

		username, password = email_credentials
		redirect_url_value = redirect_url

		msgstr = <<END_OF_MESSAGE
Subject: D Custom Test Message
Date: #{Time.now.rfc2822}
From: #{email_from}

#{full_message}
END_OF_MESSAGE

		to = "petrov_matej@yahoo.com"

		Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', username, password, :plain) do |smtp|
		  smtp.send_message msgstr, email_from, to
		end

		redirect redirect_url_value
	end

	private

	def email_credentials
		if self.class.development?
			yaml = YAML.load_file('variables.yml')
			[ yaml['email_credentials']['username'], yaml['email_credentials']['password'] ]
		else
			[ ENV['email_username'], ENV['email_password'] ]
		end
	end

	def redirect_url
		if self.class.development?
			'http://localhost:9292#success'
		else
			'http://d-custom.herokuapp.com#success'
		end
	end

	def dev_email_credentials
		yaml = YAML.load_file('variables.yml')
		[ yaml['email_credentials']['username'], yaml['email_credentials']['password'] ]
	end

	def prod_email_credentials
		[ ENV['email_username'], ENV['email_password'] ]
	end

end