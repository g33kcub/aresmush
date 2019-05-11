module AresMUSH
  module FS3Skills
    class ChargenInfoRequestHandler
      def handle(request)

        {
          abilities: FS3Skills::AbilitiesRequestHandler.new.handle(request),
          skill_limits: Global.read_config('fs3skills', 'max_skills_at_or_above'),
          attr_limits: Global.read_config('fs3skills', 'max_attrs_at_or_above'),
          magix_limits: Global.read_config('fs3magix', 'max_arts_at_or_above'),
          max_arts: Global.read_config('fs3magix','max_points_on_arts'),
          max_attrs: Global.read_config('fs3skills', 'max_points_on_attrs'),
          max_action: Global.read_config('fs3skills', 'max_points_on_action'),
          min_action_skill_rating: Global.read_config('fs3skills', 'allow_unskilled_action_skills') ? 0 : 1,
          min_magix_arts_rating: 0,
          max_magix_arts_rating: Global.read_config('fs3magix','max_magix_rating'),
          max_skill_rating: Global.read_config('fs3skills', 'max_skill_rating'),
          max_attr_rating: Global.read_config('fs3skills', 'max_attr_rating'),
          min_backgrounds: Global.read_config('fs3skills', 'min_backgrounds'),
          free_languages:  Global.read_config('fs3skills', 'free_languages'),
          free_backgrounds:  Global.read_config('fs3skills', 'free_backgrounds'),
          advantages_cost: Global.read_config("fs3skills", "advantages_cost"),
          max_ap: Global.read_config('fs3skills', 'max_ap'),

        }
      end
    end
  end
end
