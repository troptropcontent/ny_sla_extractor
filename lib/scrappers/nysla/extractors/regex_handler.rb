module Nysla
  module Extractors
    class RegexHandler
      def regex(text_node_set, regex)
        text_node_set.find_all { |text_element| text_element.text =~ /#{regex}/ }
      end
    end
  end
end
