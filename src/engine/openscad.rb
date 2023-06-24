require 'fileutils'

module Scadi
  module Engine
    PATH = "/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"
    RENDER_TEMP = File.join(__dir__, "..", "..", "render")

    class OpenSCAD
      def self.prepare
        return if @prepared
        FileUtils.rm_rf(RENDER_TEMP)
        FileUtils.mkdir(RENDER_TEMP)
        @prepared = true
      end

      def self.render(name, code)
        prepare

        scad_path = File.join(RENDER_TEMP, "#{name}.scad")
        stl_path = File.join(RENDER_TEMP, "#{name}.stl")
        File.write(scad_path, code)

        system(PATH, scad_path, "--render", "-o", stl_path)
        raise "OpenSCAD error" unless $?.success?
      end
    end
  end
end
