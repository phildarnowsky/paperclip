require 'test/helper'

class ContentTypeTest < Test::Unit::TestCase
  context "Paperclip when Rack::Mime is available" do
    setup do
      module ::Rack
        module Mime
          def self.mime_type(ext, fallback='application/octet-stream')
            'application/pdf'
          end
        end
      end
      load File.join(ROOT,'lib','paperclip','content_type.rb')
    end

    teardown do
      Object.send :remove_const, 'Rack'
    end
    
    should "define content_type_for method" do
      assert Paperclip.methods.include?('content_type_for')
    end

    context "and the pdf type is requested" do
      should "return application/pdf" do
        assert_equal 'application/pdf', Paperclip.content_type_for('pdf')
      end
    end
  end

  context "Paperclip when Rack::Mime is not available" do
    setup do
      load File.join(ROOT,'lib','paperclip','content_type.rb')
    end

    should "define content_type_for method" do
      assert Paperclip.methods.include?('content_type_for')
    end

    context "and the pdf type is requested" do
      should "return application/x-pdf" do
        assert_equal 'application/x-pdf', Paperclip.content_type_for('pdf')
      end
    end
  end
end
