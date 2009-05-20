module Paperclip
  class << self
    if defined? Rack::Mime
      def content_type_for(type) #:nodoc:
        Rack::Mime.mime_type(".#{type}")
      end
    else
      def content_type_for(type) #:nodoc:
        case type
        when %r"jpe?g"                 then "image/jpeg"
        when %r"tiff?"                 then "image/tiff"
        when %r"png", "gif", "bmp"     then "image/#{type}"
        when "txt"                     then "text/plain"
        when %r"html?"                 then "text/html"
        when "csv", "xml", "css", "js" then "text/#{type}"
        else "application/x-#{type}"
        end
      end
    end
  end
end
