require 'tilt/template'
require 'kramdown'

module RevealCK
  module Markdown
    #
    # Public: This class allows Kramdown to hook into Tilt 2.0. See
    # https://github.com/rtomayko/tilt.
    #
    class SlideMarkdownTemplate < ::Tilt::Template
      # Must be implemented by all subclasses of Tilt::Template
      def prepare; end

      def pre_process(input)
        PreProcessor.new(input).process
      end

      def post_process(input)
        PostProcessor.new(input).process
      end

      def kramdown_options
        {
          auto_ids: false,
          input: 'GFM',
          syntax_highlighter: nil
        }
      end

      def evaluate(*)
        pre_process_result = pre_process(data)
        kramdown_result =
          Kramdown::Document.new(pre_process_result, kramdown_options).to_html
        post_process(kramdown_result)
      end
    end
  end
end
