module LodgesHelper
  
  def gravatar_tag(email,*args)
    opts = args.extract_options!
    opts[:class]||=""
    opts[:class]+=" gravatar"
    size = opts.delete(:size) || 80
    require 'digest/md5'
    
    default=""
    if opts[:default]
      require 'cgi'
      default= "&d=#{CGI::escape(opts.delete(:default))}"
    end
    hash = Digest::MD5.hexdigest(email.downcase)
    img= image_tag "http://www.gravatar.com/avatar/#{hash}?size=#{size}#{default}", opts
    if opts[:profile]
      opts.delete(:profile)
      link_to img,"http://www.gravatar.com/#{hash}",opts
    else
      img
    end
  end
  
end
