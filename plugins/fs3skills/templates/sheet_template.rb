module AresMUSH
  module FS3Skills
    class SheetTemplate < ErbTemplateRenderer

      attr_accessor :char, :client

      def initialize(char, client)
        @char = char
        @client = client
        super File.dirname(__FILE__) + "/sheet.erb"
      end

      def approval_status
        Chargen.approval_status(@char)
      end

      def luck
        @char.luck.floor
      end

      def attrs
       list = []
        @char.fs3_attributes.sort_by(:name, :order => "ALPHA").each_with_index do |a, i|
          list << format_attr(a, i)
        end
        list
      end

      def action_skills
        list = []
        @char.fs3_action_skills.sort_by(:name, :order => "ALPHA").each_with_index do |s, i|
           list << format_skill(s, i, true)
        end
        list
      end

      def background_skills
        list = []
        @char.fs3_background_skills.sort_by(:name, :order => "ALPHA").each_with_index do |s, i|
           list << format_skill(s, i)
        end
        list
      end

      def languages
        list = []
        @char.fs3_languages.sort_by(:name, :order => "ALPHA").each_with_index do |l, i|
          list << format_skill(l, i)
        end
        list
      end

      def advantages
        list = []
        @char.fs3_advantages.sort_by(:name, :order => "ALPHA").each_with_index do |l, i|
          list << format_skill(l, i)
        end
        list
      end

      def sorceries
        list = []
        @char.fs3_sorcery.sort_by(:name, :order => "ALPHA").each_with_index do |l, i|
          list << format_skill(l, i)
        end
        list
      end

      def use_advantages
        FS3Skills.use_advantages?
      end

      def specialties
        spec = {}
        @char.fs3_action_skills.each do |a|
          if (a.specialties)
            a.specialties.each do |s|
              spec[s] = a.name
            end
          end
        end
        return nil if (spec.keys.count == 0)
        spec.map { |spec, ability| "#{spec} (#{ability})"}.join(", ")
      end

      def format_attr(a, i)
        name = "%xh#{a.name}:%xn"
        linebreak = i % 2 == 1 ? " " : "%r"
        endbreak = i % 2 == 1 ? "" : " "
        rating_attr = " "
        rating_desc = "#{a.rating_name}"
        "#{linebreak}#{left(name, 12)} #{left(a.print_rating, 8)} #{left(rating_attr,3)} #{right(rating_desc, 12)}#{endbreak}"
      end

      def format_skill(s, i, show_linked_attr = false)
        name = "%xh#{s.name}:%xn"
        linked_attr = show_linked_attr ? print_linked_attr(s) : ""
        linebreak = i % 2 == 1 ? " " : "%r"
        endbreak = i % 2 == 1 ? "" : " "
        rating_attr = "#{linked_attr}"
        rating_desc = "#{s.rating_name}"
        "#{linebreak}#{left(name, 12)} #{left(s.print_rating, 8)} #{left(rating_attr,3)} #{right(rating_desc, 12)}#{endbreak}"
      end

      def print_linked_attr(skill)
        apt = FS3Skills.get_linked_attr(skill.name)
        !apt ? "" : "%xh%xx#{apt[0..2].upcase}%xn"
      end

      def section_line(title)
        @client.screen_reader ? title : line_with_text(title)
      end

      def kind
        @char.group("kind") || "Unknown"
      end

      def colony
        @char.group("colony") || "Unknown"
      end

      def background
        @char.group("background") || "Unknown"
      end

      def arcana
        @char.group("arcana") || "Unknown"
      end

      def virtue
        ar = @char.group("arcana") || "Unknown"
        a = "#{ar}".downcase.tr(" ","_")
        dis = "fs3skills.virtue_#{a}"
        t(dis)
      end

      def hubris
        ar = @char.group("arcana") || "Unknown"
        a = "#{ar}".downcase.tr(" ","_")
        dis = "fs3skills.hubris_#{a}"
        t(dis)
      end

      def quirk
        ar = @char.group("background") || "Unknown"
        a = "#{ar}".downcase.tr(" ","_")
        dis = "fs3skills.quirk_#{a}"
        t(dis)
      end

      def dateofbirth
        dob = @char.demographic("birthdate")
        !dob ? "Unknown" : ICTime.ic_datestr(dob)
      end

      def age
        age = @char.age
        age == 0 ? "--" : age
      end

      def game_name
        Global.read_config("game","name")
      end

      def tagline
        Global.read_config("game","tagline")
      end

    end
  end
end
