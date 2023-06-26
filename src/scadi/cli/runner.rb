module Scadi
  module CLI
    class Runner
      attr_reader :args

      def initialize(args: ARGV)
        @args = args
      end

      def run
        # TODO: make this 1000% more resilient to bad inputs
        action = args.shift
        file = args.shift

        case action
        when "preview"
          # Follow this first: https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Using_an_external_Editor_with_OpenSCAD
          model = load_model(file)
          scad_path = Engine::OpenSCAD.save_to_scad("top", model.to_openscad)
          puts "Saved OpenSCAD file to: #{scad_path}"
          # TODO: watch mode too?
          # TODO: this deletes the file, will things break - maybe the watch mode should be the only way to preview
        when "render"
          # TODO: explicit output path - this just renders into temp
          model = load_model(file)
          puts "Rendering..."
          stl_path = Engine::OpenSCAD.render("top", model.to_openscad)
          puts "Rendered to: #{stl_path}"
        else
          raise "unknown action #{action}"
        end
      end

      def load_model(file)
        puts "Loading model..."
        DSL.use do
          eval File.read(file)
        end
      end
    end
  end
end
