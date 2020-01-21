require 'liquid'

module Tag
    class Random < Liquid::Tag
        def initialize(tag_name, max, tokens)
            super
            @max = max.to_i
        end

        def render(context)
            rand(@max).to_s
        end
    end

    class AssignmentsMultiply < Liquid::Tag
        def initialize(tag_name, factor, tokens)
            super
            @factor = factor.to_f
         end
       
         def render(context)
           (@factor * context["multiply_by"].to_f).to_s
         end
    end

    class BlocksRandom < Liquid::Block
        def initialize(tag_name, markup, tokens)
           super
           @rand = markup.to_i
        end
      
        def render(context)
          value = rand(@rand)
          super.sub('^^^', value.to_s)  # calling `super` returns the content of the block
        end
    end

    class TwoValMult < Liquid::Tag
        def initialize(tag_name, factor, tokens)
           super
           params = Hash[factor.gsub('"','').split(',').map{|x|x.strip.split(':')}] # transformo el string a:10 , b:20 en un hash.

           @factor = params["a"].to_i * params["b"].to_i
        end

        def render(context)
            @factor.to_s
        end
    end
      


end