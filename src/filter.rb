require "RedCloth"

module TextFilter
    def textilize(input)
      ## RedCloth library to convert Textile for example *hi* => <strong> hi </strong>
      RedCloth.new(input).to_html
    end


    def same_multi(input)
      ## RedCloth library to convert Textile for example *hi* => <strong> hi </strong>
      result = input.to_i * input.to_i
      result.to_s
    end
end
  
