module Lokka
  module TwitterUrl
    def self.registered(app)
      %w(posts posts/* pages pages/*).each do |suburl|
        app.before("/admin/#{suburl}") do
          if @request.env['REQUEST_METHOD'] =~ /POST|PUT/ && 
             (body = (params[:post] && params[:post][:body]))
            body.force_encoding("utf-8").gsub!(/\[twitter:(.*?)\]/u){ TwitterUrl::Util.link($1) }
          end
        end
      end
    end

    module Util
      def self.link(id)
        "<a href=\"http://twitter.com/#{id}\" target=\"_blank\">@#{id}</a>"
      end
    end
  end
end
