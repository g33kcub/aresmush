module AresMUSH
  module Demographics
    class GroupListTemplate < ErbTemplateRenderer

      attr_accessor :groups

      def initialize(groups)
        @groups = groups.sort_by { |a| a['name'] }
        super File.dirname(__FILE__) + "/group_list.erb"
      end
    end
  end
end
