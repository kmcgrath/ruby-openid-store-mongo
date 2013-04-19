# -*- encoding : utf-8 -*-

require 'fileutils'
require 'pathname'
require 'tempfile'

require 'openid/util'
require 'openid/store/interface'
require 'openid/association'

module OpenID
  module Store
    class Mongo < OpenID::Store::Interface
      VERSION = "0.0.1"

      attr_accessor :collection

      def initialize(options = {})
        self.collection = options[:collection]
      end

      # Put a Association object into storage.
      # When implementing a store, don't assume that there are any limitations
      # on the character set of the server_url.  In particular, expect to see
      # unescaped non-url-safe characters in the server_url field.
      def store_association(server_url, association)
        [nil, association.handle].each do |handle|
          key = assoc_key(server_url, handle)
          Rails.logger.info(association.inspect)
          Rails.logger.info("ASDFASFSADF: #{expiry(association.lifetime)}")
          Rails.logger.info("ASDFASDFSDF: #{key}")
          collection.save({:_id => key, :value => association.serialize, :expiry => expiry(association.lifetime)})
        end
      end

      # Returns a Association object from storage that matches
      # the server_url.  Returns nil if no such association is found or if
      # the one matching association is expired. (Is allowed to GC expired
      # associations when found.)
      def get_association(server_url, handle=nil)
        doc = collection.find_one({:_id => assoc_key(server_url, handle)})
        if doc 
          return OpenID::Association.deserialize(doc['value'])
        else
          return nil
        end
      end

      # If there is a matching association, remove it from the store and
      # return true, otherwise return false.
      def remove_association(server_url, handle)
        deleted = delete(assoc_key(server_url, handle))
        server_assoc = get_association(server_url)
        if server_assoc && server_assoc.handle == handle
          deleted = delete(assoc_key(server_url)) | deleted
        end
        return deleted
      end

      # Return true if the nonce has not been used before, and store it
      # for a while to make sure someone doesn't try to use the same value
      # again.  Return false if the nonce has already been used or if the
      # timestamp is not current.
      # You can use OpenID::Store::Nonce::SKEW for your timestamp window.
      # server_url: URL of the server from which the nonce originated
      # timestamp: time the nonce was created in seconds since unix epoch
      # salt: A random string that makes two nonces issued by a server in
      #       the same second unique
      def use_nonce(server_url, timestamp, salt)
        return false if (timestamp - Time.now.to_i).abs > Nonce.skew
        ts = timestamp.to_s # base 10 seconds since epoch
        nonce_key = 'N' + server_url + '|' + ts + '|' + salt
        begin 
          result = collection.insert({:_id=>nonce_key, :value=> '', :expiry => expiry(Nonce.skew + 5)})
          return true
        rescue
          return false
        end
      end

      def assoc_key(server_url, assoc_handle=nil)
        key = 'A' + server_url
        if assoc_handle
          key += '|' + assoc_handle
        end
        return key
      end

      def cleanup_nonces
      end

      def cleanup
      end

      def cleanup_associations
      end

      protected

      def delete(key)
        result = collection.remove({:_id => key})
      end

      # Convert a lifetime in seconds into a memcache expiry value
      def expiry(t)
        Time.now.to_i + t
      end

    end
  end
end
