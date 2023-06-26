require 'fileutils'

module Scadi
  module Engine
    PATH = "/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"
    RENDER_TEMP = File.join(__dir__, "..", "..", "..", "render")

    class OpenSCAD
      def self.prepare
        return if @prepared
        FileUtils.rm_rf(RENDER_TEMP)
        FileUtils.mkdir(RENDER_TEMP)
        @prepared = true
      end

      def self.render(name, code)
        prepare

        scad_path = save_to_scad(name, code)
        stl_path = File.expand_path(File.join(RENDER_TEMP, "#{name}.stl"))
        system(PATH, scad_path, "--render", "-o", stl_path)
        raise "OpenSCAD error" unless $?.success?

        stl_path
      end

      def self.save_to_scad(name, code)
        prepare
        
        scad_path = File.expand_path(File.join(RENDER_TEMP, "#{name}.scad"))
        File.write(scad_path, code)

        scad_path
      end
    end
  end
end
