#!/usr/bin/env ruby

# Decrypts user's API key for given user name in Jenkins CI server

require 'base64'
require 'openssl'
require 'rexml/document'

magic = '::::MAGIC::::'

xml_config_file = ENV['JENKINS_HOME'] + '/users/' + ARGV[0] + '/config.xml'
config = REXML::Document.new(File.new(xml_config_file))
encrypted_api_key = config.get_elements("//user/properties/jenkins.security.ApiTokenProperty/apiToken/")[0].text()

secretKeyFile = File.open(ENV['JENKINS_HOME'] + '/secret.key', 'r')
secretKey = ''
secretKeyFile.each_line do |l|
  secretKey += l
end

def decrypt( cipherBase64, cipherKey )
    cipher = Base64.decode64( cipherBase64 )

    aes = OpenSSL::Cipher::Cipher.new( "aes-128-ecb" ).decrypt
    aes.iv = cipher
    aes.key = cipherKey

    return aes.update( cipher ) + aes.final
end

h = Digest::SHA2.new << secretKey
k = h.digest.slice(0,16)
plaintext_with_magic = decrypt( encrypted_api_key, k)
plaintext = plaintext_with_magic.slice(0, plaintext_with_magic.size - magic.size)
puts Digest::MD5.new << plaintext
